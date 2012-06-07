-----
     ____  _                            __  __            _     _            
    / ___|| |_ _ __ ___  __ _ _ __ ___ |  \/  | __ _  ___| |__ (_)_ __   ___ 
    \___ \| __| '__/ _ \/ _` | '_ ` _ \| |\/| |/ _` |/ __| '_ \| | '_ \ / _ \
     ___) | |_| | |  __/ (_| | | | | | | |  | | (_| | (__| | | | | | | |  __/
    |____/ \__|_|  \___|\__,_|_| |_| |_|_|  |_|\__,_|\___|_| |_|_|_| |_|\___|
                                            _|  _ \  ___ _ __ | | ___  _   _ 
                                           (_) | | |/ _ \ '_ \| |/ _ \| | | |
                                            _| |_| |  __/ |_) | | (_) | |_| |
                                           (_)____/ \___| .__/|_|\___/ \__, |
                                                        |_|            |___/
-----

Trying to figure out how to deploy StreamMachine without having to fork your 
own version of the package?  StreamMachine-deploy is an example of how to 
configure your own deployment as a wrapper around StreamMachine.

## Deployment

Deployment uses a combination of capistrano and forever.  

## Testing Locally

1) Clone the repository

2) Customize config/test.json to match your stream settings

3) `npm install`

4) `node ./startup.js . test`

## Deployment

1) Customize config/production.json to match your site values

2) Customize config/deploy.rb to meet your deployment requirements

3) `cap deploy`

4) Set up process monitoring on the server to fire up startup.js:

    node ./startup.js . production
    
## Who?

StreamMachine-deploy is written by [Eric Richardson](http://ericrichardson.com).