// eloworld - Game module
// Jacob Peck

// this version is a Zero Sum game

Game := Object clone do(
  drawTolerance := 0.1
  
  withinTolerance := method(a, b,
    if((a - b) abs <= self drawTolerance, return true, return false)
  )
  
  play := method(a, b,    
    a_score := a skill + Random value(0,1 - a skill)
    b_score := b skill + Random value(0,1 - b skill)
    a_elo := a elo
    b_elo := b elo
    writeln("A[" .. a ranking .. "] (elo): " .. a_elo .. " (skill): " .. a skill .. " (performance): " .. a_score)
    writeln("B[" .. b ranking .. "] (elo): " .. b_elo .. " (skill): " .. b skill .. " (performance): " .. b_score)
    a_out := 0
    b_out := 0
    if(self withinTolerance(a_score, b_score),
      writeln("draw!")
      a_out = .5
      b_out = .5
      ,
      if(a_score > b_score,
        writeln("A wins.")
        a_out = 1
        b_out = 0
        ,
        writeln("B wins")
        a_out = 0
        b_out = 1
      )
    )
    a updateScore(a_out, b_elo);
    b updateScore(b_out, a_elo);
  )
)
