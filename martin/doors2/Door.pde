class Door
{
    PVector p, p0;
    float doorHeight;
    boolean teamA = true;
    
    Door(PVector pin)
    {
       p0 = pin;
       p = p0.get();
       doorHeight = 100;
    }
    
    void display()
    {
        fill(0,0,255);
        if(teamA) fill(255,0,0);
        pushMatrix();
          translate(p.x, p.y);
          rect(-5, -doorHeight, 10, doorHeight);
        popMatrix();
        
    }
}
