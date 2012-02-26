// eloworld - common module
// Jacob Peck

agent := method(skill, whim, elo,
  Agent with(skill, whim, elo)
)

lowAgent := method(
  agent(Random value(0, 0.2), Random value(0, 1), Random value(200, 1000))
)

medAgent := method(
  agent(Random value(0.2, 0.6), Random value(0, 1), Random value(1000, 1800))
)

highAgent := method(
  agent(Random value(0.6, 1.0), Random value(0, 1), Random value(1800, 2600))
)

low := method(
  5 repeat(
    World addAgent(lowAgent)
  )
)

med := method(
  5 repeat(
    World addAgent(medAgent)
  )
)

high := method(
  5 repeat(
    World addAgent(highAgent)
  )
)
