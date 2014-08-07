/**
 * oscP5broadcastClient by andreas schlegel
 * an osc broadcast client.
 * an example for broadcast server is located in the oscP5broadcaster exmaple.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

String IP = "169.254.22.43";

int counter;

OscP5 oscP5;

/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation1, myBroadcastLocation2; 

void setup() {
  size(400,400);
  frameRate(25);
  
  /* create a new instance of oscP5. 
   * 12000 is the port number you are listening for incoming osc messages.
   */
  //oscP5 = new OscP5(this,12000);
  //oscP5 = new OscP5(this,7400);
  
   new MyEmotivListener(7400);
   //new MyStatusListener(12000);
  
  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
   */
  
  /* the address of the osc broadcast server */
  //myBroadcastLocation1 = new NetAddress("128.40.47.103",31000);
//  myBroadcastLocation1 = new NetAddress("169.254.123.80",31000);
//   myBroadcastLocation2 = new NetAddress("169.254.123.80",32000);
//  
  myBroadcastLocation1 = new NetAddress(IP,31000);
  myBroadcastLocation2 = new NetAddress(IP,32000);
  
  
  counter = 0;
  
// OscMessage m = new OscMessage("/server/connect",new Object[0]);
//      oscP5.flush(m,myBroadcastLocation);  
}


void draw() {
  background(0);
}


void mousePressed() {
  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage("/test");
  /* add a value (an integer) to the OscMessage */
  myOscMessage.add(100);
  /* send the OscMessage to a remote location specified in myNetAddress */
  //oscP5.flush(myOscMessage, myBroadcastLocation1);
  oscP5.flush(myOscMessage, myBroadcastLocation2);
}


void keyPressed() {
  OscMessage m;
  switch(key) {
    case('c'):
      /* connect to the broadcaster */
      m = new OscMessage("/server/connect",new Object[0]);
      //oscP5.flush(m,myBroadcastLocation1);  
      oscP5.flush(m,myBroadcastLocation2);  

      break;
    case('d'):
      /* disconnect from the broadcaster */
      m = new OscMessage("/server/disconnect",new Object[0]);
      oscP5.flush(m,myBroadcastLocation1);  
      break;

  }  
}


///* incoming osc message are forwarded to the oscEvent method. */
//void oscEvent(OscMessage theOscMessage) {
//  /* get and print the address pattern and the typetag of the received OscMessage */
//  //  println("### received an osc message with addrpattern "+theOscMessage.addrPattern()+" and typetag "+theOscMessage.typetag());
//  //  theOscMessage.print();
//  println(theOscMessage.net);
//}

void sendOsc (String addressPattern, float messageAttribute) {
   OscMessage m = new OscMessage(addressPattern);
   m.add(messageAttribute);
   oscP5.flush(m, myBroadcastLocation2);
}

class MyEmotivListener {
  int port;
  OscP5 osc;
  MyEmotivListener(int thePort) {
    port = thePort;
    osc = new OscP5(this,port);
  }
  
  public void oscEvent(OscMessage theOscMessage) {
    counter++;
    sendOsc("/COUNTER",counter);
    
    //println("received a message from emotiv on port "+port+" "+theOscMessage);
    
    if(false){
    // do nothing
    } else if (theOscMessage.checkAddrPattern("/AFF/Engaged/Bored") == true ) {
       sendOsc("/ENG",theOscMessage.get(0).floatValue());
    } else if (theOscMessage.checkAddrPattern("/AFF/Excitement") == true ) {
       sendOsc("/EXC",theOscMessage.get(0).floatValue());
    } else if (theOscMessage.checkAddrPattern("/AFF/Frustration") == true ) {
       sendOsc("/FRU",theOscMessage.get(0).floatValue());
    } else if (theOscMessage.checkAddrPattern("/AFF/Meditation") == true ) {
       sendOsc("/MED",theOscMessage.get(0).floatValue());
    } else if (theOscMessage.checkAddrPattern("/EXP/BLINK") == true ) {
       sendOsc("/BLI",theOscMessage.get(0).floatValue());
    }

  }

}

class MyStatusListener {
  int port;
  OscP5 osc;
  MyStatusListener(int thePort) {
    port = thePort;
    osc = new OscP5(this,port);
  }
  
  public void oscEvent(OscMessage theOscMessage) {
    println("received a message from server on port "+port);
  }

}
