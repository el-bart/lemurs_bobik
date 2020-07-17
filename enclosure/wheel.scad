use <gears.scad>;

h=6;


module engine_mount_tooth_(h)
{
  $fs=0.01;
  $fn=0;
  difference()
  {
    union()
    {
      translate([0, 0.4, 0])
        cylinder(r=0.8/2, h=h);
      translate([-0.4, -0.1, 0])
        cube([0.8, 0.5, h]);
    }
    translate([-0.4, -1, 0])
      cube([0.8, 1, h]);
  }
}

module engine_mount_(h)
{
  r=9/2-1.2;
  n=16;
  scale((9-0.5)/6.5)
  {
    cylinder(r=r, h=h, $fn=200);
    for(i=[0:n-1])
      rotate(i*[0, 0, 360/n])
        translate([0, r-0.1, 0])
          engine_mount_tooth_(h);
  }
}

module gear_(h, tooth_number)
{
  spur_gear(modul=2,
            tooth_number=tooth_number,
            width=h,
            bore=1,
            pressure_angle=20,
            helix_angle=0,
            optimized=false);
}

module wheel(h)
{
  difference()
  {
    union()
    {
      cylinder(h=h, r=40, $fs=0.1, $fn=100);
      translate([0, 0, h])
        gear_(h, 15);
    }
    cylinder(r=4.3/2, h=2*h+1, $fn=100);
  }
}

for(i=[0:1])
  translate(i*[80+5, 0, 0])
    {
      wheel(h);

      translate([0, 55, 0])
        difference()
        {
          gear_(h, 11);
          engine_mount_(h);
        }
    }
