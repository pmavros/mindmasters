/**
 * MindMasters is an interactive game installation for emotiv.
 * Authors:
 * Panos Mavros (urbancortex.org)
 *
 *
 
 * Adapted from the oscP5broadcaster example by andreas schlegel
 * info about using OSCP5: http://www.sojamo.de/oscP5
 */
 
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
String statesNames [] = {"excitement", "frustration", "engagement", "meditation"};
Float statesValuesA [] = {0.0,0.0,0.0,0.0};
Float statesValuesB [] = {0.0,0.0,0.0,0.0};

Boolean teamStatusA = true, teamStatusB = true;


// chart colours by variable
color r = color(255, 0, 0);    // red for excitement
color b = color(0, 150, 255);    // blue for frustration
color o = color(255, 200, 0);  // orange for engagement
color g = color(0, 255, 0);    // green for meditation
color colors [] = {r, b,o, g};




void setup() {
  oscP5 = new OscP5(this, myListeningPort);
  
  new MyTeamListener("Team A", 32000);
  new MyTeamListener("Team B", 33000);

  
  frameRate(25);
  size(400, 400);

  logo_casa = loadImage("CASA_logo_white.png");
  logo_casa.resize(int(logo_casa.width*0.1), int(logo_casa.height*0.1));
}

void draw() {
  background(0);
  updateText();  
  image(logo_casa, width-50, 25);
}

void oscEvent(OscMessage theOscMessage) {
  
  /* check if the address pattern fits any of our patterns */
  if (theOscMessage.addrPattern().equals(myConnectPattern)) {
    connect(theOscMessage.netAddress().address());
  }
  else if (theOscMessage.addrPattern().equals(myDisconnectPattern)) {
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

void updateText(){
  textAlign(LEFT, TOP);
  textSize(15);
  
  fill(255);
  if(teamStatusA){
    text("team A", 125, 25);
  }
  if(teamStatusB){
    text("team B", 225, 25);
  }
  for (int i = 0; i<4;i++){     
    fill(colors[i]);
    text(statesNames[i], 25, 25*(i+2));  
    if(teamStatusA){
      text(statesValuesA[i], 125, 25*(i+2));
    }
    if(teamStatusB){
      text(statesValuesB[i], 225, 25*(i+2));
    }     
  }
}

void readEmotiv(String teamName, OscMessage theOscMessage){
  if (teamName == "Team A"){
     fillArray(statesValuesA, theOscMessage);
  } else if (teamName == "Team B") {
    fillArray(statesValuesB,theOscMessage);
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
  MyTeamListener(String theName,int thePort) {
    name = theName;
    port = thePort;
    osc = new OscP5(this,port);
  }
  
  public void oscEvent(OscMessage theOscMessage) {
    println("received a message from server"+ name+" on port "+port);
    println(theOscMessage.addrPattern());
    /* check if the address pattern fits any of our patterns */
  
  if (theOscMessage.addrPattern().equals(myConnectPattern)) {
    connect(theOscMessage.netAddress().address());
  }
  else if (theOscMessage.addrPattern().equals(myDisconnectPattern)) {
    disconnect(theOscMessage.netAddress().address());
  }
  else if (theOscMessage.addrPattern().equals("COUNTER")) {
    println(theOscMessage.get(o).intValue());
  }{
     readEmotiv(name, theOscMessage);
     
  }
  }  
}
