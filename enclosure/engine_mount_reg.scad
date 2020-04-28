$fn=80;

difference()
{
  hull()
  {
    for(dx=[0,25])
      translate([dx,0,0])
        cylinder(r=8, h=5);
  }
  
  union()
  {
    hull()
    {
      for(dx=[15,25])
        translate([dx,0,-1])
          cylinder(r=3.3, h=5+2*1);
    }
    translate([0,0,-1])
      cylinder(r=3.3, h=5+2*1);
  }
}
