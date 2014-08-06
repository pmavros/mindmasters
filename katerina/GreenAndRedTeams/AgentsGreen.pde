class AgentsGreen
{
 
  //Parameters that YOU CAN CHANGE
  //size of the team's players
  int gs=20;
  
  
  PVector p, v, u;
  float px, py;
  
  AgentsGreen()
  {
    p = new PVector(random(2, 55), random(height/5, 4*height/5));
    v = PVector.sub(goalG, p);
    v.normalize();

  }

  void display()
  {
    pushStyle();
     stroke(255);
     fill(gre);
     ellipse(p.x, p.y, gs, gs);
    popStyle();
    
  }

  void move()
  {    
    p.add(v);
  }
  
  boolean isFinished()
  {
      boolean done = false;
      if(p.x>(width-10)) done = true;
      return done;
  }
  
  float positionx()
  {
    px=p.x;
    return px;
  }
  
    float positiony()
  {
    py=p.y;
    return py;
  }
  
}

