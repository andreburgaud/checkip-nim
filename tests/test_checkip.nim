import unittest
import std/strutils
import checkip

test "user agent with https://ifconfig.co/":
    let a = userAgent("https://ifconfig.co/")
    check(a.startsWith("curl"))

test "user agent with https://ifconfig.co":
    let a = userAgent("https://ifconfig.co")
    check(a.startsWith("curl"))

test "user agent with https://checkip.amazonaws.com/":
    let a = userAgent("https://checkip.amazonaws.com/")
    check(a.startsWith(appName()))

test "user agent with https://checkip.amazonaws.com":
    let a = userAgent("https://checkip.amazonaws.com")
    check(a.startsWith(appName()))

test "user agent with https://burgaud.com":
    let a = userAgent("https://burgaud.com")
    check(a.startsWith(appName()))

test "user agent with empty url":
    let a = userAgent("")
    check(a.startsWith(appName()))

test "appName":
    check(appName() == "test_checkip")

