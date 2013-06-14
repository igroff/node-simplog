# simplog

The simplest useful log module imaginable. 

#### Installation
    npm install git+https://github.com/intimonkey/node-simplog.git

#### Usage
Supports error, info, warn, debug and a handy event method.  It's
written in coffee script and you should be too (that was deliberate).

    log.error "this is an error"
    log.info  "this is informational"
    log.warn  "this is a warning"
    log.debug "this is a debug message and will only show up if process.env.DEBUG is truthy"
    log.event "this will log with the type [EVENT] and will only show up if process.env.DEBUG is truthy"

#### Formatting
It's even possible to use string formatting with it, like:

    log.info "that %s looked like %j", object_name, object

Under the covers it's just using node's util.format and supports what
you would expect.


