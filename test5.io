#!/usr/bin/env io

// eloworld - test5 (runs continuously)
// Jacob Peck

doFile("common.io")

15 repeat(setRandom)

i := 0

loop(
  i = i + 1
  World draw tick
  writeln
  World summarize
  writeln
  if(i % 100 == 0,
    setRandom
  )
)