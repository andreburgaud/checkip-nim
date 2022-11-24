import os, parseopt, std/strformat, httpclient, strutils, terminal

const
  DEFAULT_CHECKIP_URL = "https://checkip.amazonaws.com"

proc appName*: string =
  ## Extract the program name from the command line
  splitFile(getAppFilename())[1]

proc printInfo(msg: string) =
  ## Print information styled text to the terminal (typically yellow)
  styledEcho fgYellow, styleBright, msg

proc printSuccess(msg: string) =
  ## Print success styled text to the terminal (typically green)
  styledEcho fgGreen, styleBright, msg

proc writeHelp =
  ## Print the usage
  printInfo "Usage: $1" % appName()

proc userAgent*(url: string): string =
  ## Create a user agent string. To use ifconfig.co, need to create 
  ## a pseudo useragent so that the server returns only the IP address.
  const NimblePkgVersion {.strdefine.} = "Unknown"
  case url:
    of "https://ifconfig.co/", "https://ifconfig.co":
      return fmt"curl/{NimblePkgVersion}"
  fmt"{appName()}/{NimblePkgVersion}"

proc writeVersion =
  ## Print the version
  const NimblePkgVersion {.strdefine.} = "Unknown"
  printInfo "$1 $2" % [appName(), NimblePkgVersion]

proc main =
  ## Application entrypoint
  var checkUrl = DEFAULT_CHECKIP_URL
  var isVerbose = false

  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      writeHelp(); return
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": writeHelp(); return
      of "version", "V": writeVersion(); return
      of "verbose", "v": isVerbose = true
      of "url", "u": checkUrl = val
    of cmdEnd: assert(false)

  if isVerbose:
    echo fmt"Check URL : {checkUrl}"
    echo fmt"User Agent: {userAgent(checkUrl)}"
  
  var client = newHttpClient(userAgent = userAgent(checkUrl), timeout = 1000)
  let ip = client.getContent checkUrl
  printSuccess strip(ip)

when isMainModule:
  main()
