util    = require 'util'

debugEnabled = () ->
  return window?.debug or (process.env.DEBUG and process.env.DEBUG.toLowerCase() isnt "false")

# our default behavior is to use util.log so that we can get a timestamp
logFunction = util.log
# however, if the caller doesn't want a timestamp they can set the following env var
# to 'true'
if process.env.SIMPLOG_NO_TIMESTAMP is "true"
  logFunction = console.log

write = (level, message, formatParams) ->
  return if process.env.DISABLE_LOGGING
  if formatParams
    formatParams.unshift message
    if process.env.NOLOGPID or window?
      logFunction "[#{level}] #{util.format.apply util.format, formatParams}"
    else
      logFunction "[#{process.pid}] [#{level}] #{util.format.apply util.format, formatParams}"
  else
    if process.env.NOLOGPID or window?
      logFunction "[#{level}] #{message}"
    else
      logFunction "[#{process.pid}] [#{level}] #{message}"

log =
  error: (message, others...) -> write "ERROR", message, others
  info:  (message, others...) -> write "INFO", message, others
  warn:  (message, others...) -> write "WARN", message, others
  debug: (message, others...) ->
    if debugEnabled()
      write "DEBUG", message, others
  event: (message, others...) ->
    if debugEnabled()
      write "EVENT", message, others

module.exports = log
