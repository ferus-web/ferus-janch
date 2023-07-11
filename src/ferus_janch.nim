import cligen, clientimpl, std/[strutils, rdstdin, strformat, json], jsony, netty

proc cleanup*(ipcClient: IPCClient) =
  echo fmt"Exiting; notifying server."
  ipcClient.kill()

  # Is this even necessary?
  discard ipcClient

proc onRecv(jsonNode: JSONNode) =
  echo fmt"[SERVER]: {jsonNode.getStr()}"

proc main(port: int = 8080, brokerSignature: string = "FERUS-JANCH") =
  echo fmt"Starting IPC client (port={port}; brokerSignature={brokerSignature})"

  var 
    ipcClient = newIPCClient(brokerSignature, port)
    running = true

  echo fmt"Begin handshake, fingers crossed."
  ipcClient.handshake()
  ipcClient.addReceiver(
    onRecv
  )



  while running:
    ipcClient.heartbeat()
    let commandToSend = readLineFromStdin("JSON to send [type quit to exit]: ").toLowerAscii()
    if commandToSend == "quit":
      echo fmt"Manual exit initiated."
      cleanup(ipcClient)
      running = false
      quit 0
    else:
      # We're directly using the netty reactor as the base IPC client only supports sending tables, not json-encoded
      # strings themselves.
      ipcClient.reactor.send(ipcClient.conn, commandToSend)

when isMainModule:
  dispatch main