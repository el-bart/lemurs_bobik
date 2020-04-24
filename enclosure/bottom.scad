use<wheel.scad>

wall=4;

module engine_()
{
  cylinder(r=42/2, h=23);
  difference()
  {
    hull()
    {
      for(dx=[-1,1])
        translate([dx*(56.5/2-2*5/2), 0, 23-1])
          cylinder(r=5, h=1);
    }
    for(dx=[-1,1])
      translate([dx*(56.5-2*1.8-2*3.5/2)/2, 0, 23-1-1])
        cylinder(r=3.3/2, h=3);
  }
  translate([0, 0, 23])
  {
    cylinder(r=1, h=18.8);
    translate([0, 0, 18.8-5])
      cylinder(r=9/2, h=5);
  }
}


module main_hull()
{
  difference()
  {
    // core
    cylinder(r=340/2, h=65, $fn=400);
    translate(wall*[0,0,1])
      cylinder(r=340/2-wall, h=65, $fn=400);
    // cut-outs for wheels
    for(dx=[-1,1])
      translate([dx*118-10/2, 0, 0])
        translate([0, -80/2, -1])
          cube([10, 80, wall+2]);
  }
  // wheel pivot axis
  difference()
  {
    for(dx=[-1,1])
      translate([dx*(110+2-7), 0, wall])
      {
        for(xside=[0, dx*(20+1)])
          translate([-5/2+xside, -20/2, 0])
            cube([5, 20, 25+10]);
        %translate([dx*16.5, 0, 25+2])
          rotate([0, 90, (dx+1)/2*180])
            wheel();
      }
    translate([-300/2, 0, wall+4.3/2+25])
      rotate([0, 90, 0])
        cylinder(r=4.3/2, h=300, $fn=20);
  }
  // engines mounts
  for(dx=[-1,1])
  {
    translate([dx*(110+2-13)-5/2, -38, wall])
    {
      // bottom mount
      difference()
      {
        cube([5, 20, 15]);
        translate([-5, 20/2, 3.3/2+4])
          rotate([0, 90, 0])
            cylinder(r=3.3/2, h=15, $fn=20);
      }
      // top mount tower
      translate([dx*5, -15, 0])
        difference()
        {
          cube([5, 20, 65-wall]);
          translate([-5, 20/2, 3.3/2+65-wall-10])
            rotate([0,90,0])
              cylinder(r=3.3/2, h=15, $fn=20);
        }
    }
    %translate([dx*(73), -28, 60/2+wall])
      rotate(dx*[0, 90, 0])
        engine_();
  }
}

main_hull();
