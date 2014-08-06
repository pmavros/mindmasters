void ending()
{
 pushStyle(); 
  textSize(30);
  fill(0);
  if (agentsred.size()==0) 
  {
   background(gre);
   text(TeamA+"wins", width/2, height/2);
   noLoop(); 
  }
  else
  if (agentsgreen.size()==0) 
  {
   background(re);
   text(TeamB+"wins", width/2, height/2);
   noLoop(); 
  }
 popStyle();
}
