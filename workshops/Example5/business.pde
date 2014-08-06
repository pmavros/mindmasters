ArrayList<Boxo> boxae;
PVector g;

void setup()
{
  size(500, 500);
  smooth();
  rectMode(CENTER);
  frameRate(30);
  
  boxae =  new ArrayList<Boxo>();
}

void draw()
{
  background(255);
  g = new PVector(0, gravity/10);
  for(Boxo b:boxae)
  {
      b.display();
  }
  
  if(boxae.size()>20) boxae.remove(0);
  

  
}

class Boxo
{
    PVector p, s, v;
    
    Boxo(float x, float y)
    {
        p = new PVector(x,y);
        s = new PVector(rectangleWidth, rectangleHeight);
        v = new PVector(random(-5,5 ), -10);
    }
    
    void display()
    {
       v.add(g);
       p.add(v);
       fill(red, green, blue, 100);
       
       pushMatrix();
         translate(p.x, p.y);
         rotate(frameCount*spinspeed/100);
         rect(0,0, s.x, s.y); 
       popMatrix();
        
    }
}

void mousePressed()
{
     boxae.add(new Boxo(mouseX, mouseY));
}

void keyPressed()
{
    if(keyCode==DOWN) gravity+=1;
    if(keyCode==UP) gravity-=1;
    if(keyCode==LEFT) spinspeed--;
    if(keyCode==RIGHT) spinspeed++;
}
