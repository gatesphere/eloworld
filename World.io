// eloworld - World module
// Jacob Peck

World := Object clone do(
  height := 20
  width := 50
  agentList := list
  outVector := nil
  tickCount := 0
  
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
    self tickCount = self tickCount + 1
    self agentList foreach(agent,
      agent act(self tickCount)
    )
    self
  )
  
  summarize := method(
    results := Map clone
    self agentList foreach(agent,
      r := agent ranking
      curr := results at(r)
      if(curr != nil,
        results atPut(r, curr + 1)
        ,
        results atPut(r, 1)
      )
    )
    writeln("count of rank A agents: " .. results at("A"))
    writeln("count of rank B agents: " .. results at("B"))
    writeln("count of rank C agents: " .. results at("C"))
    writeln("count of rank D agents: " .. results at("D"))
    writeln("count of rank E agents: " .. results at("E"))
    writeln("count of rank F agents: " .. results at("F"))
  )
)
