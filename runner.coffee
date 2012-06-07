forever = require "forever"
fs = require "fs"

module.exports = class Runner
    constructor: (@path,@env) ->
        
        console.log "env is ", @env
                
        @instance = null
        @old = []
        
        @_startInstance()
        
        # if we get a HUP, pass it through to our instance
        process.on "SIGHUP", => process.kill @instance.child.pid, "SIGHUP"
        
        process.on "SIGTERM", => 
            # need to shut down instance and any old instances
            process.kill @instance.child.pid, "SIGTERM"
            
        # set up watcher on tmp/restart.txt
        # it needs to exist for us to watch it...
        
        @watcher = fs.watchFile "#{@path}/tmp/restart.txt", => @_startInstance()
                
    #----------
    
    _startInstance: ->
        if @instance
            # need to handle graceful shutdown for an existing instance
            oldinstance = @instance
            
            # keep track of the instance
            @old.push oldinstance
            
            # send TERM signal to old instance, causing it to release the 
            # listening port
            oldinstance.forceStop = true
            process.kill oldinstance.child.pid, "SIGTERM"
            
            @instance = null
        
        # now start our new process
        @instance = new (forever.Monitor) "#{@path}/node_modules/StreamMachine/index.js", options:["--config=#{@path}/config/#{@env}.json"]
        
        @instance.on "restart", (forever) =>
            console.log "got restart event of ", forever
            
        @instance.on "start", (ever) =>
            console.log "got start with ", ever
            
        @instance.start()
        #forever.startServer(@instance)
        
        console.log "instance is ", @instance.child.pid