
void setup()
{
  size(500, 500);
  smooth();
  rectMode(CENTER);
  frameRate(30);
}

void draw()
{
  
  translate(centreX, centreY);
  background(255);
  fill(100, 50);
  ellipse(0,0,width, height);
  
  pushMatrix();
    rotate(PI*2*frameCount*spinspeed/1800.0);
    line(0,0,0,-200);
    fill(red, green, blue);
    rect(0, -200, rectangleHeight, rectangleWidth);  
  popMatrix();
  
  pushMatrix();
    rotate(PI*2*frameCount*spinspeed/(60*1800.0));
    line(0,0,0,-150);
    fill(255-red, 255-green, 255-blue, 150);
    ellipse(0, -150, rectangleHeight, rectangleWidth);
  popMatrix();
  
  
  
  
}
