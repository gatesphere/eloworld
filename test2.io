#!/usr/bin/env io

// eloworld - test2
// Jacob Peck

3 repeat(
  World addAgent(Agent with(0.5, 0.5))
)

20 repeat(
  World draw tick
  writeln
  in := File standardInput readLine
)
