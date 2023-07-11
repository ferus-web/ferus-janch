# ferus-janch

ferus-janch is a tool for inspecting and debugging the Ferus IPC pipeline.
"janch" means "inspect" in Hindi.

# current features
You can send JSON, that's about it. That's how Ferus and the child processes talk, and you'll have to manually write JSON to poke into the server (main process). Check out `constants.nim` as they give a good idea of how
to make the server do as you say (for the most part).

I intend to add a fuzzer soon enough too.