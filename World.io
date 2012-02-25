// eloworld - World module
// Jacob Peck

World := Object clone do(
  height := 20
  width := 50
  agentList := list
  outVector := nil
  
  init := method(
    self outVector = list
    for(i, 1, self height,
      blah := list
      for(j, 1, self width,
        blah append(".")
      )
      self outVector append(blah)
    )
    self
  )  
  
  clone := method(self)
  
  draw := method(
    self updateOutVector
    self outVector foreach(i,x,
      writeln(x join)
    )
    self
  )
  
  atPutOutVector := method(pos, v,
    self outVector at(pos second) atPut(pos first, v)
  )
  
  updateOutVector := method(
    self init
    self agentList foreach(agent,
      self atPutOutVector(agent position, agent)
    )
  )
  
  addAgent := method(agent,
    self agentList append(agent)
    self
  )
  
  tick := method(
    self agentList foreach(agent,
      agent act
    )
    self
  )
)
