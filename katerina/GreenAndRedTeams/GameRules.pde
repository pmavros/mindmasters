void rules()
{
   //removing or adding GREEN agents
   
    for(int i = 0; i<agentsgreen.size(); i++)
    {  
      ppx=int(agentsgreen.get(i).positionx());
      ppy=int(agentsgreen.get(i).positiony());
      pixel=get(ppx, ppy);
      if (pixel==re)
      {
        agentsgreen.remove(i); 
        goalR = new PVector(25, random(height)); //new random goals
        agentsred.add(new AgentsRed()); 
      }
      else if (agentsgreen.get(i).isFinished()==true) agentsgreen.remove(i);
     // println(agentsgreen.size());
    }
  
  
  //removing or adding RED agents
    for(int i = 0; i<agentsred.size(); i++)
   {     
    kkx=int(agentsred.get(i).positionx());
    kky=int(agentsred.get(i).positiony());  
    pixel2=get(kkx, kky);
    if (pixel2==gre) //this means that x>0, because green is drawn last, so it's on top
        {
          agentsred.remove(i);
          goalG = new PVector(width-25, random(height));
          agentsgreen.add(new AgentsGreen());
        }
    else if (agentsred.get(i).isFinished()==true) agentsred.remove(i);  
   } 
  // println(agentsred.size());
}
