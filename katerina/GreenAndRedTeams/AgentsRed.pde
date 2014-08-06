class AgentsRed
{
  //Parameters that YOU CAN CHANGE
  //size of the team's players
  int rs=20;
  
  
  PVector k, v, u;
  float kx, ky;
  
  AgentsRed()
  {
    k = new PVector(width-random(2, 55), random(height/5, 4*height/5));
    v = PVector.sub(goalR, k);
    v.normalize();
  }

  void display()
  {
    pushStyle();
     stroke(255);
     fill(re);
     ellipse(k.x, k.y, rs, rs);
    popStyle();
    
  }

  void move()
  {
    k.add(v);  
  }
  
  boolean isFinished()
  {
      boolean done = false;
      if(k.x<10) done = true;
      return done;
  }
  
  float positionx()
  {
    kx=k.x;
    return kx;
  }
  
    float positiony()
  {
    ky=k.y;
    return ky;
  }
  
}

