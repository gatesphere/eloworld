#!/usr/bin/env io

// eloworld - test3 (runs continuously)
// Jacob Peck

doFile("common.io")

5 repeat(low)
5 repeat(med)
5 repeat(high)

i := 0

loop(
  i = i + 1
  World draw tick
  writeln
  World summarize
  writeln
  if(i % 100 == 0,
    low
    med
    high
  )
)