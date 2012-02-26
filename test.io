#!/usr/bin/env io

// eloworld - test
// Jacob Peck

a := Agent with(0.9, 0.6, 1000)
b := Agent with(0.2, 0.6, 1000)
//c := Agent with(0.9, 0.6)

2000 repeat(
  Game play(a, b)
  //Game play(a, c)
  //Game play(b, c)
  writeln("New elo--> A: " .. a elo .. " B: " .. b elo .. "\n")
)
