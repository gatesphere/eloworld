#!/usr/bin/env io

// eloworld - test3 (runs continuously)
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