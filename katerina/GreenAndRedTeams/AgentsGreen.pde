class AgentsGreen
{
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
     ellipse(p.x, p.y, 20, 20);
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

