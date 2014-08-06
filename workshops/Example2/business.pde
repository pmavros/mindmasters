size(500, 500);
background(255);
rectMode(CENTER);

fill(red, green, blue);
rect(centreX, centreY, rectangleHeight, rectangleWidth);

fill(255-red, 255-green, 255-blue);
ellipse(centreX, centreY, rectangleHeight, rectangleWidth);

line(0,0,centreX, centreY);
