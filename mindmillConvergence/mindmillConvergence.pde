/**
 * Windmill 
 * 
 * Press buttons up or down to increase or decrease the speed of the wind. 
 */

PVector origin;
float powerA, powerB, speed;
float powerAMax = 1, powerBMax =1;
int speedMax = 20;
int millHeight = 100;
int bladeLength = 40;
float powerDiff;
float angle, rotSpeed;
IntList converge = new IntList();
float convergence;

windMill mill, mill2;

void setup () {
  size(500, 400);
  stroke(255);
  background(0);
  frameRate(15);
  
  mill = new windMill(0, 0, 100, 40);
}

void draw() {
  //println(origin);
  background(0);

  updateText();
  teams();
  lineChart();
  barCharts();
  mill.speed();
  mill.display();
 
}

void teams() {
  // calculate the difference between the state of user A and user B
  powerDiff = abs(powerA-powerB);
  
  // reverse numbers so that smaller difference makes higher speed
  convergence = map(powerDiff, 0,1,1,0);
  
  // add new value to array for the chart
  converge.append((int)(convergence*100));
  if(converge.size()>50){
    converge.remove(1);
  }
  
 barCharts();
}

void updateText() {
  speed = rotSpeed*30;
  
  fill(255);
  noStroke();
  textAlign(LEFT, TOP);
  text((int)speed+" knots", 20, 20);
  textAlign(LEFT, BOTTOM);
  //text("the windmill");
  text("The MindMills \npress 'a' or 'b' and 'SHIFT' + 'a' or 'b' to control the power of each team. \nWhen powers converge of the mill", 20, height - 20);
}

void keyPressed() {
  if (key == 'a') {
    if (powerA < powerAMax) {
      powerA = powerA+0.1;
    }
  } 
  else if (key == 'A') {
    if (powerA > 0.1) {
      powerA = powerA-0.1;
    }
    
  }
  if (key == 'b') {
    if (powerB < powerBMax) {
      powerB = powerB+0.1;
    }
  } 
  else if (key == 'B') {
    if (powerB > 0.1) {
      powerB= powerB-0.1;
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
  
  void speed(){
     rotSpeed = convergence;
    // get a logistic curve to start smoother
    // logSpeed =  (1/1-exp(-logSpeed*10))/10;
   
     angle = angle + rotSpeed;
  }
  
  void display() {

    translate(width / 2, height / 2);
    strokeWeight(4);
    //println(angle);
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
}

void lineChart(){
  
  int limRight= 0;
  int b = 10;
  pushMatrix();
  int chartHeight = 100;
  translate(0,200);
  textAlign(RIGHT, BOTTOM);
  fill(255);
  text("mind convergence", width-20,chartHeight);
 
  for(int i=0; i<converge.size()-1;i++){
    int y0 = chartHeight-converge.get(i);
    int x0 = limRight+b*i;
    int y1 = chartHeight-converge.get(i+1);
    int x1 = limRight+b*(i+1);
   
    //println(i+" "+x0+" "+x1);
    stroke(0,200,0,200);
    line(x0,y0,x1,y1);
  }
  popMatrix();
}

void barCharts(){
  pushMatrix();
  translate(20,200);
  
  strokeWeight(1);
  fill(255,0,0);
  stroke(255,0,0);
  text("a",0,0);
  rect(0,100-powerA*100,20,powerA*100);
  fill(0,200,200);
  stroke(0,200,200);
  text("b",22,0);
  rect(22,100-powerB*100,20,powerB*100);
  
  for (int i=0; i<5; i++) { 
    int y = 20*i;
    strokeWeight(1);
    stroke(200);
    line(45, y, 48, y);
  }
  popMatrix();
}

