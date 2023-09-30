import std/[os, strformat, strutils, terminal]

const
  COPYRIGHT = "Copyright (C) 2022-2023 - Andre Burgaud"
  SPACES = 10

proc appName*: string =
  ## Extract the program name from the command line
  splitFile(getAppFilename())[1]

proc printInfo(msg: string) =
  ## Print information styled text to the terminal (typically yellow)
  styledEcho fgYellow, styleBright, msg

proc printSuccess*(msg: string) =
  ## Print success styled text to the terminal (typically green)
  styledEcho fgGreen, styleBright, msg

proc printError*(msg: string) =
  ## Print error styled text to the terminal (typically red)
  styledEcho fgRed, styleBright, msg

proc version: string =
    const NimblePkgVersion {.strdefine.} = "Unknown"
    NimblePkgVersion

proc printHeader =
  ## Display centered information about the application
  let width = terminalWidth()
  styledEcho fgGreen, center(&"{appName()} {version()}", width - 10)
  styledEcho fgGreen, center(COPYRIGHT, width - 10)

proc printUsageOption(shortOpt: string, longOpt: string, description: string) =
  ## For the usage, print a line for a given option
  let displayLongOpt = longOpt & spaces(max(0, SPACES - longOpt.len))
  if shortOpt.len > 0:
    writeStyled &"  {shortOpt}, {displayLongOpt}"
  else:
    writeStyled &"      {displayLongOpt}"
  echo description

proc printDescription =
  ## Display the description for this utility
  #styledEcho fgYellow, styleBright, "Description:"
  echo """The $1 utility displays your external IP address.""" % appName()
  echo()

proc printOptions =
  ## Print all the options descriptions for the usage
  styledEcho fgYellow, styleBright, "Options:"
  printUsageOption("-h", "--help", "Display this help and exit")
  printUsageOption("-v", "--verbose", "Show traces during execution")
  printUsageOption("-V", "--version", "Output version information and exit")
  printUsageOption("", "--dns", "Uses DNS (default)")
  printUsageOption("", "--http", "Uses HTTP")

proc printExamples =
  ## Print all the options descriptions for the usage
  styledEcho fgYellow, styleBright, "Examples:"
  echo """  $1
  $1 --help
  $1 --version
  $1 --http
  $1 --dns""" % appName()

proc printUsage* =
  ## Display usage for this application
  echo()
  printHeader()
  printDescription()
  styledEcho fgYellow, styleBright, "Usage:"
  echo &"  {appName()} [OPTIONS]"
  echo()
  printOptions()
  echo()
  printExamples()
  echo()

proc writeVersion* =
  ## Print the version
  printInfo &"{appName()} {version()}"

