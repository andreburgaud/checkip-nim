import parseopt, std/strformat, httpclient, strutils
import usage

const
  DEFAULT_CHECKIP_URL = "https://checkip.amazonaws.com"

proc userAgent*(url: string): string =
  ## Create a user agent string. To use ifconfig.co, need to create 
  ## a pseudo useragent so that the server returns only the IP address.
  const NimblePkgVersion {.strdefine.} = "Unknown"
  case url:
    of "https://ifconfig.co/", "https://ifconfig.co":
      return fmt"curl/{NimblePkgVersion}"
  fmt"{appName()}/{NimblePkgVersion}"

proc main =
  ## Application entrypoint
  var checkUrl = DEFAULT_CHECKIP_URL
  var isVerbose = false

  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      printUsage(); return
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": printUsage(); return
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
