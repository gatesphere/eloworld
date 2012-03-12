// eloworld - Agent module
// Jacob Peck

Agent := Object clone do(
  position := nil // x,y position within World
  elo ::= nil // initial ELO rating of 1000
  skill ::= nil // actual skill
  whim ::= nil // how likely to accept a challenge
  target := nil
  numgames := 0
  previouslyPlayed ::= nil
  
  init := method(
    self position = list(0,0)
    self elo = 1000
    self skill = 0
    self whim = 0
    self target = nil
    self numgames = 0
    self previouslyPlayed = list
  )
  
  setPosition := method(x, y,
    if(x > World width - 1, x = World width - 1)
    if(x < 0, x = 0)
    if(y > World height - 1, y = World height - 1)
    if(y < 0, y = 0)
    self position = list(x, y)
    self
  )
  
  with := method(skill, whim, elo,
    self clone setElo(elo) setSkill(skill) setWhim(whim) setPosition(Random value(0, World width - 1) round, Random value(0, World height - 1) round)
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
    k := 0
    if(r == "F", k = 32)
    if(r == "E", k = 24)
    if(r == "D", k = 16)
    if(r == "C", k = 8)
    if(r == "B", k = 4)
    if(r == "A", k = 2)
    if(self numgames < 30, k = 64)
    //writeln("k-value: " .. k)
    k
  )
  
  updateScore := method(performance_score, opponent_elo, opponent, turn,
    expected_score := (1 / (1 + 10 pow((opponent_elo - self elo)/400)))
    delta_elo := self kvalue * (performance_score - expected_score)
    self elo = self elo + delta_elo
    self numgames = self numgames + 1
    self previouslyPlayed append(list(opponent, turn))
  )
  
  asString := method(
    self ranking
  )
  
  act := method(turn,
    self move(turn)
    self game(turn)
  )
  
  move := method(turn,
    target := self seekOpponent(turn)
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
  
  seekOpponent := method(turn, // find target with highest ELO within differential
    played := list
    self previouslyPlayed foreach(record,
      if(turn - record second > 5,
        continue
        ,
        played append(record)
      )
    )
    self previouslyPlayed = played
    World agentList foreach(agent,
      if(agent == self, continue)
      if(self withinDifferential(agent elo),
        if(self target == nil or self target elo < agent elo,
          go := true
          self previouslyPlayed foreach(record,
            if(record first == agent, go = false)
          )
          if(go, self target = agent)
        )
      )
    )
    if(self target == nil,
      return self position,
      return self randomPosition
    )
  )
  
  randomPosition := method(
    return list(Random value(0, World width - 1) round, Random value(0, World height - 1))
  )
  
  withinDifferential := method(other,
    delta := self elo - other
    delta abs < self differential
  )
  
  differential := method(
    r := self ranking
    d := 0
    if(r == "F", d = 1000)
    if(r == "E", d = 800)
    if(r == "D", d = 600)
    if(r == "C", d = 400)
    if(r == "B", d = 200)
    if(r == "A", d = 100)
    d
  )
  
  game := method(turn,
    success := self proposeGame(self target)
    if(success,
      Game play(self, self target, turn)
    )
    self target = nil
  )
  
  proposeGame := method(opponent,
    if(opponent == nil, return false)
    if(self position == opponent position,
      return opponent acceptGame(self)
      ,
      return false
    )
  )
  
  acceptGame := method(opponent,
    if(withinDifferential(opponent elo),
      return true
      ,
      return (Random value(0, 1) >= self whim)
    )
  )
)
