void panel()
{
   pushMatrix();
   pushStyle();
   noStroke();
   fill(33,154,126, 80);
   translate(0, height-40);
   rect(0, 0, width, 40);
   if (x<0) win=TeamB; else win=TeamA;
   textAlign(CENTER);
   if (x<0) 
   {
     fill(re); 
     rect(width/2+x, 20, 0-x, 20);
   }
   else 
   {
     fill(gre);
     rect(width/2, 20, x, 20);
   }
   text(win+" team is winning", width/2, 15);
  popStyle();
  popMatrix();
}
