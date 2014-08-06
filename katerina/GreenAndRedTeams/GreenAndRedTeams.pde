//Parameters that YOU CAN CHANGE

//NAMES of the teams
String TeamA="Team A"
String TeamB="Team B"

//COLOR of your teams
//color of Team A
color gre= color(0, 153, 76);

//color of Team B
color re= color(255, 102, 102);

//Inital number of "players" generated
int initial=10;

//The size of the window
int wsize=500;

/*Which channel to use
  There are FOUR available:
  0:excitement
  1:frustration
  2:engagement
  3:meditation
*/
int channel=2;

//Declaring the variables
PVector goalR, goalG;
ArrayList<AgentsGreen> agentsgreen;
ArrayList<AgentsRed> agentsred;
float x;
int ppx, ppy, kkx, kky, si;
color pixel, pixel2;
String win;


void setup()
{
  setupOSC();
  frameRate(30);
  textAlign(CENTER);
  size(wsize, wsize);
  agentsgreen = new ArrayList<AgentsGreen>();
  agentsred = new ArrayList<AgentsRed>();
  x=0;

  
  //loading the first set of agents
  //you can determine how many are generated in the beginning 
  for(int i = 0; i<initial; i++)
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
  //in the beginning, show the instructions
  if (frameCount<100)
  {
    instructions();
  }
  else
  { 
    //every 20 frames, load one more agent
    //you can change the "one" to as many as you want
    //when it reaches 250 frames, it stops generating more agents
    if ((frameCount<250)&&(frameCount%20==0))
    {
        for(int i = 0; i<1; i++)
       {
        goalG = new PVector(width-25, random(height));
        goalR = new PVector(25, random(height));
        agentsgreen.add(new AgentsGreen());
        agentsred.add(new AgentsRed());
       }
    }
    background(224, 224, 224);
    panel();
  
    if (x<0) //because red is drawn last, it is drawn on top (thus, it wins)
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


//if one team's values is bigger than the other team's values, 
//that team prevails, and makes the agents of the other team disappear
//when an agent of one team "eats" an agent of the other team, a new one is added to the winning team.

void winCheck()
{
  if (statesValuesA[channel]>statesValuesB[channel]) x=x+0.1;
  else x=x-0.1;
}

//press 0 to restart the game
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

