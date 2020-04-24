use<wheel.scad>

wall=4;

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
}

main_hull();
