#!/usr/bin/env io

// eloworld - test4 (runs continuously, no draw)
// Jacob Peck

doFile("common.io")

5 repeat(low)
5 repeat(med)
5 repeat(high)

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
    low
    med
    high
  )
)