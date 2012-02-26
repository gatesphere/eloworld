#!/usr/bin/env io

// eloworld - test2
// Jacob Peck

low := method(
  5 repeat(
    World addAgent(Agent with(Random value(0, 0.2), 0.5, Random value(200, 1000)))
  )
)

med := method(
  5 repeat(
    World addAgent(Agent with(Random value(0.3, 0.7), 0.5, Random value(1000, 1800)))
  )
)

high := method(
  5 repeat(
    World addAgent(Agent with(Random value(0.8, 1.0), 0.5, Random value(1800, 2500)))
  )
)

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
