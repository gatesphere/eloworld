#!/usr/bin/env io

// eloworld - test4 (runs continuously, no draw)
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
    World addAgent(Agent with(Random value(0.8, 1.0), 0.5, Random value(1800, 2800)))
  )
)

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