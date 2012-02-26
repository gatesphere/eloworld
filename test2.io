#!/usr/bin/env io

// eloworld - test2
// Jacob Peck

doFile("common.io")

low low med med high high

loop(
  World draw tick
  writeln
  World summarize
  writeln
  in := File standardInput readLine
  if(in == "h",
    high
  )
  if(in == "m",
    med
  )
  if(in == "l",
    low
  )
  if(in == "q",
    break
  )
)
