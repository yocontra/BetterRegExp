module.exports = u =
  flags:
    g: "global"
    i: "ignoreCase"
    m: "multiline"
    #x: "extended" # es6
    #y: "sticky" # firefox only

  validateFlag: (flag) ->
    throw "Invalid flag: Must be a string" unless typeof flag is "string"
    throw "Invalid flag: #{flag}" unless u.flags[f] for f in flag
    return true

  getFlags: (regex) -> (k for k,v of u.flags when regex[v] is true).join ''
  escape: (str) -> String(str).replace /([\\/'*+?|()\[\]{}.^$])/g,'\\$1'
  uppercase: (str) -> "#{str.charAt(0).toUpperCase()}#{str[1..]}"