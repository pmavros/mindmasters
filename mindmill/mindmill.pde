/**
 * Windmill 
 * 
 * Press buttons up or down to increase or decrease the speed of the wind. 
 */

PVector origin;
int powerA, powerB, speed;
int powerAMax = 10, powerBMax =10;
int speedMax = 20;
int millHeight = 100;
int bladeLength = 40;
float powerDiff;
float angle, rotSpeed;

windMill mill, mill2;

void setup () {
  size(500, 400);
  stroke(255);
  background(0);

  // origin = (30, 30);
  frameRate(15);
  mill = new windMill(0, 0, 100, 40);
}

void draw() {
  //println(origin);
  background(5);

  updateText();
  teams();
  mill.display();
}

void teams() {
  float a = powerA;
  float b = powerB;
  powerDiff = abs(a-b);
     
  pushMatrix();
  translate(20,200);
  text("a", 0,0);
  text("b",22,0);
  noStroke();
  fill(255,0,0);
  rect(0,100-powerA*10,20,powerA*10);
  fill(0,255,0);
  rect(22,100-powerB*10,20,powerB*10);
  
  for (int i=0; i<5; i++) { 
    int y = 20*i;
    strokeWeight(1);
    stroke(200);
    line(40, y, 48, y);
  }
  popMatrix();
}

void updateText() {
  speed = (int) (rotSpeed*20);
  fill(255);
  noStroke();
  textAlign(LEFT, TOP);
  text(speed+" knots", 20, 20);
  textAlign(LEFT, BOTTOM);
  //text("the windmill");
  text("The MindMills \npress 'a' or 'b' and 'SHIFT' + 'a' or 'b' to control the power of each team. \nWhen powers converge of the mill", 20, height - 20);
}

void keyPressed() {
  if (key == 'a') {
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
}



class windMill {
  int xo;
  int yo;
  int millHeight;
  int bladeLength;
  windMill(int x, int y, int m, int b) {
    xo = x;
    yo = y;
    millHeight = m;
    bladeLength = b;
  }
  void display() {
    translate(width / 2, height / 2);
    strokeWeight(4);
    float convergence = map(powerDiff,0,10,10,0);
    rotSpeed = convergence *0.1;
    
    

    angle = angle + rotSpeed;

    println(angle);
    pushMatrix();
    stroke(200);
    strokeWeight(2);
    line(xo, yo + millHeight, xo, yo);
    ellipse(xo, yo, 5, 5);

    rotate(angle);
  strokeWeight(4);
    // draw the three blades
    for (int i = 0; i<3;i++) {
      //print(i);
      pushMatrix();
      rotate(radians(120*i));
      stroke(255 - 50*i);
      line(0, 0, 0, -50);
      popMatrix();
    }
    popMatrix();
  }

  void blade() {
    //    rotate();
    line(xo, yo - millHeight, xo, yo);
  }
}

