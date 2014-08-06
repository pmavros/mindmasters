ArrayList<Boxo> boxae;

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
 
  for(Boxo b:boxae)
  {
      b.display();
  }
  
  if(boxae.size()>20) boxae.remove(0);
  
  noFill();
  stroke(0,50);
  rect(mouseX, mouseY,rectangleWidth, rectangleHeight);
  
}

class Boxo
{
    PVector p, s, v;
    
    Boxo(float x, float y)
    {
        p = new PVector(x,y);
        s = new PVector(rectangleWidth, rectangleHeight);
    }
    
    void display()
    {
       fill(red, green, blue, 50);
       rect(p.x, p.y, s.x, s.y); 
        
    }
}

void mousePressed()
{
    boxae.add(new Boxo(mouseX, mouseY));
}

void keyPressed()
{
    if(keyCode==UP) rectangleHeight+=5;
    if(keyCode==DOWN) rectangleHeight-=5;
    if(keyCode==LEFT) rectangleWidth-=5;
    if(keyCode==RIGHT) rectangleWidth+=5;
}
