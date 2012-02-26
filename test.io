#!/usr/bin/env io

// eloworld - test
// Jacob Peck

doFile("common.io")

a := highAgent
b := lowAgent
//c := Agent with(0.9, 0.6)

2000 repeat(
  Game play(a, b)
  //Game play(a, c)
  //Game play(b, c)
  writeln("New elo--> A: " .. a elo .. " B: " .. b elo .. "\n")
)
