util    = require 'util'

debugEnabled = () ->
  return window?.debug or (process.env.DEBUG and process.env.DEBUG.toLowerCase() isnt "false")

write = (level, message, formatParams) ->
  return if process.env.DISABLE_LOGGING
  if formatParams
    formatParams.unshift message
    if process.env.NOLOGPID or window?
      util.log "[#{level}] #{util.format.apply util.format, formatParams}"
    else
      util.log "[#{process.pid}] [#{level}] #{util.format.apply util.format, formatParams}"
  else
    if process.env.NOLOGPID or window?
      util.log "[#{level}] #{message}"
    else
      util.log "[#{process.pid}] [#{level}] #{message}"

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
