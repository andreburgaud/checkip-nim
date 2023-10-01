import std/[httpclient, parseopt, strformat, strutils]
import ndns

import usage

const
  CHECKIP_HTTP = "https://checkip.amazonaws.com"
  CHECKIP_DNS = "208.67.222.222" # Needs to be an IP address

proc httpQuery(isVerbose: bool) =
  ## Check external IP address via HTTP
  if isVerbose:
    echo &">>> Check URL: {CHECKIP_HTTP}"

  var client = newHttpClient(timeout = 1000)
  let ip = client.getContent CHECKIP_HTTP
  printSuccess strip(ip)

proc dnsQuery(isVerbose: bool) =
  ## Check external IP address via DNS
  if isVerbose:
    echo &">>> Check DNS: {CHECKIP_DNS}"

  let client = initDnsClient(ip=CHECKIP_DNS)
  let ips = resolveIpv4(client, domain="myip.opendns.com", timeout=1000)
  if ips.len > 0:
    printSuccess strip(ips[0])
  else:
    printError "No IP address returned"

proc main =
  ## Application entrypoint
  var isVerbose = false
  var isHttp = false
  var isDns = true

  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      printUsage(); return
    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h": printUsage(); return
      of "version", "V": writeVersion(); return
      of "verbose", "v": isVerbose = true
      of "http": isHttp = true; isDns = false
      of "dns": isHttp = false; isDns = true

    of cmdEnd: assert(false)

  if isDns:
    dnsQuery(isVerbose)
    return

  if isHttp:
    httpQuery(isVerbose)

when isMainModule:
  main()
