$fn=80;

module engine_mount_reg()
{
  difference()
  {
    hull()
    {
      for(dx=[0,25])
        translate([dx,0,0])
          cylinder(r=7, h=5);
    }

    union()
    {
      hull()
      {
        for(dx=[15,25])
          translate([dx,0,-1])
            cylinder(r=3.3/2, h=5+2*1);
      }
      translate([0,0,-1])
        cylinder(r=3.3/2, h=5+2*1);
    }
  }
}

for(dy=[0:1])
  translate(dy*[0, 16, 0])
    engine_mount_reg();
