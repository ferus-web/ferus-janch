# Package

version       = "0.1.0"
author        = "xTrayambak"
description   = "Handy tool for inspecting the Ferus IPC layer"
license       = "MIT"
srcDir        = "src"
bin           = @["ferus_janch"]


# Dependencies

requires "nim >= 1.6.12"
requires "jsony"
requires "netty"
requires "cligen"
requires "chronicles"