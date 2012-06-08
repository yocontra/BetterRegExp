{uppercase, getFlags, validateFlag, flags} = util = require './util'

class BetterRegExp
  constructor: (pattern, flag) -> @setRegExp pattern, flag
  clone: (flag) -> new BetterRegExp @

  # Pass-through to regex
  setRegExp: (pattern, flag="") ->
    validateFlag flag
    if pattern instanceof RegExp
      flag += getFlags pattern
      pattern = pattern.source
    else if pattern instanceof BetterRegExp
      flag += pattern.flags()
      pattern = pattern.regex.source
    pattern ?= @regex.source if @regex?
    throw "Pattern must be string or RegExp" unless typeof pattern is "string"
    @regex = new RegExp pattern, flag
    return @

  toString: -> @regex.toString()
  exec: (args...) -> @regex.exec args...
  test: (args...) -> @regex.test args...

  # Sugar
  flags: -> getFlags @regex
  addFlag: (flag) -> @setFlag @flags()+flag
  setFlag: (flag) -> @setRegExp null, flag
  removeFlag: (flag) -> @setFlag (m for m in @flags() when !(m in flag))
  hasFlag: (flag) -> (m for m in @flags() when !(m in flag)).length isnt -1

for flag, name of flags
  do (flag) ->
    BetterRegExp::["is#{uppercase(name)}"] = -> @hasFlag flag
    BetterRegExp::[name] = BetterRegExp::[flag] = -> @addFlag flag

BetterRegExp.escape = util.escape
BetterRegExp.util = util
module.exports = BetterRegExp