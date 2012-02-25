// eloworld - Agent module
// Jacob Peck

Agent := Object clone do(
  position := nil // x,y position within World
  elo ::= nil // initial ELO rating of 1000
  skill ::= nil // actual skill
  whim ::= nil // how likely to accept a challenge
  differential ::= 250
  
  init := method(
    self position = list(0,0)
    self elo = 1000
    self skill = 0
    self whim = 0
  )
  
  setPosition := method(x, y,
    if(x > World width - 1, x = World width - 1)
    if(x < 0, x = 0)
    if(y > World height - 1, y = World height - 1)
    if(y < 0, y = 0)
    self position = list(x, y)
    self
  )
  
  with := method(skill, whim,
    self clone setSkill(Random value(0, skill)) setWhim(Random value(0, whim)) setPosition(Random value(0, World width - 1) round, Random value(0, World height - 1) round)
  )
  
  ranking := method(
    if(self elo <= 500, return "F")
    if(self elo <= 1000, return "E")
    if(self elo <= 1500, return "D")
    if(self elo <= 2000, return "C")
    if(self elo <= 2500, return "B")
    return "A"
  )
  
  kvalue := method(
    r := self ranking
    switch(r,
      "F",
        return 32,
      "E",
        return 24,
      "D",
        return 16,
      "C",
        return 8,
      "B",
        return 4,
      "A",
        return 2
    )
  )
  
  updateScore := method(performance_score, opponent_elo,
    expected_score := (1 / (1 + 10 pow((opponent_elo - self elo)/400)))
    delta_elo := self kvalue * (performance_score - expected_score)
    self elo = self elo + delta_elo
  )
  
  asString := method(
    self ranking
  )
  
  act := method(
    self move
  )
  
  move := method(
    target := self seekOpponent
    targ_x := target first
    targ_y := target second
    
    curr_x := self position first
    curr_y := self position second

    if(targ_x - curr_x < 0,
      curr_x = curr_x - 1,
      if(targ_x - curr_x > 0,
        curr_x = curr_x + 1
      )
    )
    
    if(targ_y - curr_y < 0,
      curr_y = curr_y - 1,
      if(targ_y - curr_y > 0,
        curr_y = curr_y + 1
      )
    )    
    
    self setPosition(curr_x, curr_y)
  )
  
  seekOpponent := method( // find target with highest ELO within differential
    target := nil
    World agentList foreach(agent,
      if(agent == self, continue)
      if(self withinDifferential(agent elo),
        if(target == nil or target elo < agent elo,
          target = agent
        )
      )
    )
    if(target == nil,
      return self position,
      return target position
    )
  )
  
  withinDifferential := method(other,
    delta := self elo - other
    delta abs < self differential
  )
)
