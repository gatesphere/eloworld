#!/usr/bin/env io

// eloworld - test6 (runs continuously, no draw)
// Jacob Peck

doFile("common.io")

15 repeat(setRandom)

i := 0

loop(
  if(i % 100 == 0,
    writeln("Summary at " .. i .. " generations:")
    World summarize
    World writeln
  )
  i = i + 1
  World tick
  if(i % 1000 == 0,
    setRandom
  )
)