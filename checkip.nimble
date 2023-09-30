import std/strformat

# Package
version       = "0.5.0"
author        = "Andre Burgaud"
description   = "Check public IP address"
license       = "MIT"
srcDir        = "src"
binDir        = "build"
bin           = @["checkip"]

# Dependencies
requires "nim >= 2.0.0"
requires "ndns >= 0.1.2"

task check_version, "Display the application version":
    ## Validate that the version in fthe nimble file
    ## is the same as the version in the justfile
    ## It is executed by just during the release of a distribution
    echo fmt"Nimble version  : {version}"
    let lines = readLines("justfile", 5)
    for line in lines:
        if line.startswith("VERSION"):
            let justVersion = multiReplace(line.split("=")[1].strip(), ("\"", ""))
            echo fmt"Justfile version: {justVersion}"
            doAssert version == justVersion, "Versions don't match between nimble file and justfile"
            return