class Floor
{
    ArrayList<PVector> control, start;
    
    Floor()
    {
        start = new ArrayList<PVector>();
        start.add(new PVector(0, height*0.5));
        start.add(new PVector(width*0.3, height*0.8));
        start.add(new PVector(width*0.6, height*0.4));
        start.add(new PVector(width, 0.7*height));
        
        control = new ArrayList<PVector>();
        for(PVector p:start)
        {
            control.add(p.get());
        }
    }
    
    void display()
    {
       
        stroke(255);
        for(int i = 0; i<control.size()-1; i++)
        {
            line(control.get(i).x, control.get(i).y, control.get(i+1).x, control.get(i+1).y);
        }
    }
}
