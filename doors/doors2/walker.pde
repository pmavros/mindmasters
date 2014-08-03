class Walker
{
    PVector p,v;
    float h;
    
    Walker()
    {
        p = new PVector(11, height);
        v = new PVector(1,0);
        h = 50;
    }
    
    void floorCollide(Floor f)
    {
        int index = 0;
        for(int i = 0; i<f.control.size()-1; i++)
        {
            if(f.control.get(i).x<p.x && f.control.get(i+1).x>p.x) index = i;
        }
        
        p.y = map(p.x, f.control.get(index).x, f.control.get(index+1).x, f.control.get(index).y, f.control.get(index+1).y);
    }
    
    void collide(ArrayList<Door> ds)
    {
        floorCollide(floor);
        
      
        for(Door d:ds)
        {
          
            if(abs(p.x-d.p.x)<10)
            {
                //println(p.y-h + " " + d.p.y);
                if((d.p.y > (p.y - h) && (d.p.y - d.doorHeight) < p.y) )
                {
                    v.x = -v.x;
                }
            }
        }
        
         if(p.x<10)
            {
                v.x = -v.x;
            }
    }
    
    void move()
    {
        p.add(v);
    }
    void display()
    {
      
        fill(0);
        pushMatrix();
          translate(p.x, p.y);
          line(0,-h*0.4, 0, -0.8*h);
          ellipse(0, -0.9*h, h/5, h/5);
          
          
          pushMatrix();
            translate(0,-h*0.7);
            
            scale(v.x,1);
            pushMatrix();
            rotate(PI/2);
            rotate(PI*0.25*sin(frameCount*0.1));
            line(0, 0, 0.25*h, 0);
            line(0.25*h, -h*0.2, 0.25*h, 0);
            popMatrix();
            
            pushMatrix();
            rotate(PI/2);
            rotate(-PI*0.25*sin(frameCount*0.1));
            line(0, 0, 0.25*h, 0);
            line(0.25*h, -h*0.2, 0.25*h, 0);
            popMatrix();
            
          popMatrix();
          
          pushMatrix();
            translate(0, -0.4*h);
            scale(v.x,1);
            pushMatrix();
            rotate(PI*0.2);
            rotate(PI*0.25*sin(frameCount*0.1));
            line(0, 0, 0.15*h, 0.15*h);
            line(0.15*h, 0.15*h, 0.15*h, 0.4*h);
            popMatrix();
            
            pushMatrix();
            rotate(PI*0.1);
            rotate(-PI*0.25*sin(frameCount*0.1));
            line(0, 0, 0.15*h, 0.15*h);
            line(0.15*h, 0.15*h, 0.15*h, 0.4*h);
            popMatrix();
            
          popMatrix();
          
        popMatrix();
    }
    
    
}
