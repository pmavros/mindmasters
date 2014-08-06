class Floor
{
    ArrayList<PVector> control;
    
    Floor()
    {
        control = new ArrayList<PVector>();
        control.add(new PVector(0, height));
        control.add(new PVector(width, height*0.5));
        control.add(new PVector(width+1, height*0.8));
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
