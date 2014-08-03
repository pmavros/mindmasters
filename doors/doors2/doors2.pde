Walker w;
ArrayList<Door> doors;
Floor floor;

float powerA, powerB;
float powerAMax, powerBMax;

void setup()
{  
  size(1000,500);
  powerA = 0;
  powerB = 0;
  powerAMax = height;
  powerBMax = height;
  
  w = new Walker();
  stroke(255);
  fill(0);
  addDoors();
  floor = new Floor();
}

void addDoors()
{
  doors = new ArrayList<Door>();
  doors.add(new Door(new PVector(width/4, height)));
  doors.add(new Door(new PVector(width/2, height)));
  doors.add(new Door(new PVector(3*width/4, height)));
  doors.get(1).teamA=false;
  
}

void draw()
{
    background(0);
    w.collide(doors);
    w.move();
    w.display();
    
    for(Door d:doors)
    {  
        d.display();
    }
    
    floor.display();
}

void keyPressed() {
  if (key == 'a') {
    println(powerA + " " + powerAMax);
    if (powerA < powerAMax) {
      
      powerA++;
    }
  } 
  else if (key == 'A') {
    if (powerA > 0) {
      powerA--;
    }
  }
  
  if (key == 'b') {
    if (powerB < powerBMax) {
      powerB++;
    }
  } 
  else if (key == 'B') {
    if (powerB > 0) {
      powerB--;
    }
  }
  
  for(Door d: doors)
  {
      //println(powerA);
      if(d.teamA)
      {
          d.p.y = d.p0.y - powerA*10;
      }
      else
      {
          d.p.y = d.p0.y - powerB*10;
      }
  }
}


