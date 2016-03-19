/**
 * Mindmill 
 * 
 * Panos Mavros urbancortex.org
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

/*Which channel to use
  There are FOUR available:
  0:excitement
  1:frustration
  2:engagement
  3:meditation
*/
int channel=3;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddressList myNetAddressList = new NetAddressList();


/* listeningPort is the port the server is listening for incoming messages */
int myListeningPort = 31000;
/* the broadcast port is the port the clients should listen for incoming messages from the server*/
int myBroadcastPort = 12000;

String myConnectPattern = "/server/connect";
String myDisconnectPattern = "/server/disconnect";

float excitement, frustration, engagement, meditation = 0;

PImage logo_casa;
String statesNames [] = {
  "excitement", "frustration", "engagement", "meditation"
};
Float statesValuesA [] = {
  0.0, 0.0, 0.0, 0.0
};
Float statesValuesB [] = {
  0.0, 0.0, 0.0, 0.0
};

Boolean teamStatusA = true, teamStatusB = true;


// chart colours by variable
color r = color(255, 0, 0);    // red for excitement
color b = color(0, 150, 255);    // blue for frustration
color o = color(255, 200, 0);  // orange for engagement
color g = color(0, 255, 0);    // green for meditation
color colors [] = {
  r, b, o, g
};



void setup () {
  
   size(500, 400);
  stroke(255);
  background(0);
  frameRate(15);
  
   oscP5 = new OscP5(this, myListeningPort);

  new MyTeamListener("Team A", 32000);
  new MyTeamListener("Team B", 33000);


  frameRate(25);
  size(400, 400);

  
 
  logo_casa = loadImage("CASA_logo_white.png");
  logo_casa.resize(int(logo_casa.width*0.1), int(logo_casa.height*0.1));
  mill = new windMill(0, 0, 100, 40);
  
}

void draw() {
  //println(origin);
  background(0);
  
    background(0);
  image(logo_casa, width-50, 25);

  image(logo_casa, width-50, 25);

  updateText();
  teams();
  lineChart();
  barCharts();
  mill.speed();
  mill.display();
 
}







void teams() {
  
  //println(statesValuesA);
  
  powerA = statesValuesA[channel];
  powerB= statesValuesB[channel];
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
  
 

 
  
   textAlign(LEFT, TOP);
  textSize(15);
  
  fill(255);
  if(teamStatusA){
    text("team A", 125, 25);
  }
  if(teamStatusB){
    text("team B", 225, 25);
  }

  
   for (int i = 0; i<4; i++) {     
    fill(colors[i]);
    text(statesNames[i], 25, 25*(i+2));  
    if (teamStatusA) {
      text(statesValuesA[i], 125, 25*(i+2));
    }
    if (teamStatusB) {
      text(statesValuesB[i], 225, 25*(i+2));
    }
  }
  
  
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
 // println(powerB);
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

/**
 * MindMasters is an interactive game installation for emotiv.
 * Authors:
 * Panos Mavros (urbancortex.org)
 *
 *
 
 * Adapted from the oscP5broadcaster example by andreas schlegel
 * info about using OSCP5: http://www.sojamo.de/oscP5
 */

void oscEvent(OscMessage theOscMessage) {

  /* check if the address pattern fits any of our patterns */
  if (theOscMessage.addrPattern().equals(myConnectPattern)) {
    connect(theOscMessage.netAddress().address());
  } else if (theOscMessage.addrPattern().equals(myDisconnectPattern)) {
    disconnect(theOscMessage.netAddress().address());
  }
  /**
   * if pattern matching was not successful, then broadcast the incoming
   * message to all addresses in the netAddresList. 
   */
  else {

    //readEmotiv(OscMessage theOscMessage);
    //oscP5.send(theOscMessage, myNetAddressList);
  }
}


void readEmotiv(String teamName, OscMessage theOscMessage) {
  if (teamName == "Team A") {
    fillArray(statesValuesA, theOscMessage);
  } else if (teamName == "Team B") {
    fillArray(statesValuesB, theOscMessage);
  }
}

void fillArray (Float [] array, OscMessage theOscMessage) {
  // replace this with /EXC
  if (theOscMessage.addrPattern().equals("/EXC")) {   
    array[0] = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.addrPattern().equals("/FRU")) {
    array[1] = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.addrPattern().equals("/ENG")) {
    array[2] = theOscMessage.get(0).floatValue();
  } else if (theOscMessage.addrPattern().equals("/MED")) {
    array[3] = theOscMessage.get(0).floatValue();
  }
}



private void connect(String theIPaddress) {
  if (!myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
    myNetAddressList.add(new NetAddress(theIPaddress, myBroadcastPort));
    println("### adding "+theIPaddress+" to the list.");
  } else {
    println("### "+theIPaddress+" is already connected.");
  }
  println("### currently there are "+myNetAddressList.list().size()+" remote locations connected.");
}


private void disconnect(String theIPaddress) {
  if (myNetAddressList.contains(theIPaddress, myBroadcastPort)) {
    myNetAddressList.remove(theIPaddress, myBroadcastPort);
    println("### removing "+theIPaddress+" from the list.");
  } else {
    println("### "+theIPaddress+" is not connected.");
  }
  println("### currently there are "+myNetAddressList.list().size());
}

class MyTeamListener {
  String name;
  int port;
  OscP5 osc;
  MyTeamListener(String theName, int thePort) {
    name = theName;
    port = thePort;
    osc = new OscP5(this, port);
  }

  public void oscEvent(OscMessage theOscMessage) {
    println("received a message from server"+ name+" on port "+port);
    println(theOscMessage.addrPattern());
    /* check if the address pattern fits any of our patterns */

    if (theOscMessage.addrPattern().equals(myConnectPattern)) {
      connect(theOscMessage.netAddress().address());
    } else if (theOscMessage.addrPattern().equals(myDisconnectPattern)) {
      disconnect(theOscMessage.netAddress().address());
    } else if (theOscMessage.addrPattern().equals("COUNTER")) {
      println(theOscMessage.get(o).intValue());
    }
    {
      readEmotiv(name, theOscMessage);
    }
  }
}


