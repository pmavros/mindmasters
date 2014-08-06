Walker w;
ArrayList<Door> doors;
Floor floor;

float powerA, powerB;
float powerAMax, powerBMax;

float scaler = 600;

void setup()
{  
  setupOSC();
  
    
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
  doors.add(new Door(new PVector(width/4, 1.3*height)));
  
  doors.add(new Door(new PVector(width/2, height*0.8)));
  
  doors.add(new Door(new PVector(3*width/4, 1.3*height)));
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
    
    win();
    
    //NEW BIT
    for(Door d: doors)
    {
        //println(powerA);
        if(d.teamA)
        {
            d.p.y = d.p0.y - statesValuesA[0]*500;
            floor.control.get(2).y =floor.start.get(2).y + statesValuesA[0]*scaler;
        }
        else
        {
            d.p.y = d.p0.y - statesValuesB[0]*100;
            floor.control.get(0).y =floor.start.get(0).y - statesValuesB[0]*scaler;
            floor.control.get(3).y =floor.start.get(3).y - statesValuesB[0]*scaler;
  
        }
    }
}


void win()
{
    if(w.p.x>width)
    {
        colorMode(HSB);
        fill(frameCount%255, 255, 255);
        textSize(100);
        text("YOU ARE A WINNER", 10, height/2);
    }
}

/*
  Include generic key control here
  Default to controlling/being controlled by the first channel
*/

void keyPressed() {
  if (key == 'a') {
    println(powerA + " " + powerAMax);
    if (powerA < powerAMax) {
      
      powerA++;
    }
    statesValuesA[0] += 0.1;
  } 
  else if (key == 'A') {
    if (powerA > 0) {
      powerA--;
    }
    statesValuesA[0] -= 0.1;
  }
  
  if (key == 'b') {
    if (powerB < powerBMax) {
      powerB++;
    }
    statesValuesB[0] += 0.1;
  } 
  else if (key == 'B') {
    if (powerB > 0) {
      powerB--;
    }
    statesValuesB[0] -= 0.1;
  }
  
}

