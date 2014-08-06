PVector goalR, goalG;
ArrayList<AgentsGreen> agentsgreen;
ArrayList<AgentsRed> agentsred;
int x;
int ppx, ppy, kkx, kky, si;
color pixel, gre, re, pixel2;
String win;


void setup()
{
 setupOSC();
 
  frameRate(30);
  textAlign(CENTER);
  size(500, 500);
  agentsgreen = new ArrayList<AgentsGreen>();
  agentsred = new ArrayList<AgentsRed>();
  x=0;
  re= color(255, 102, 102);
  gre= color(0, 153, 76);
  for(int i = 0; i<30; i++)
  {
    goalG = new PVector(width-25, random(height));
    goalR = new PVector(25, random(height));
    agentsgreen.add(new AgentsGreen());
    agentsred.add(new AgentsRed());
  }
}

void draw()
{
  winCheck();
  if (frameCount<100)
  {
    instructions();
  }
  else
  { 
    if ((frameCount<250)&&(frameCount%20==0))
    {
        for(int i = 0; i<10; i++)
       {
        goalG = new PVector(width-25, random(height));
        goalR = new PVector(25, random(height));
        agentsgreen.add(new AgentsGreen());
        agentsred.add(new AgentsRed());
       }
    }
    background(224, 224, 224);
    panel();
  
    if (x<0) //because red is drawn last, it is drawn on top
    {
      addgreen();
      addred();
    }
    else
    {
      addred();
      addgreen();
    }
    rules();
  }
  
  ending();


}


void winCheck()
{
  if (statesValuesA[0]>statesValuesB[0]) x=x+1;
  else x=x-1;
}


void keyPressed()
{
   //if (key=='r') x=x+1;
  // if (key=='p') x=x-1;
   if (key=='0') 
   {
     setup();
     loop();
   }
}

