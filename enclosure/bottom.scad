include<detail/config.scad>
use<wheel.scad>
use<top.scad>
use<seal.scad>
use<detail/electronics_mocks.scad>
use<detail/stepper_mock.scad>
use<detail/battery_pack_holder.scad>
use<m3d/fn.scad>


module main_hull()
{
  // main part
  difference()
  {
    // core
    cylinder(r=cylinder_d/2, h=cylinder_h, $fn=fn(3*360));
    translate(wall*[0,0,1])
      cylinder(r=cylinder_d/2-wall, h=cylinder_h, $fn=fn(3*360));
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
        cylinder(r=4.3/2, h=300, $fn=fn(20));
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
            cylinder(r=3.3/2, h=15, $fn=fn(20));
      }
      // top mount tower
      translate([dx*5, -15, 0])
        difference()
        {
          cube([5, 20, 65-wall]);
          translate([-5, 20/2, 3.3/2+65-wall-10])
            rotate([0,90,0])
              cylinder(r=3.3/2, h=15, $fn=fn(20));
        }
    }
    %translate([dx*(73), -28, 60/2+wall])
      rotate(dx*[0, 90, 0])
        stepper_mock();
  }
  // LiPo battery pack mount
  translate([0, -135, wall])
    battery_pack_holder();
  // buttons mount
  translate([-86.1/2, -42/2, wall])
  {
    for(dx=[-1, 86.1-10+1])
      for(dy=[-1, 42-10+1])
        translate([dx, dy, 0])
          difference()
          {
            cube([10, 10, cylinder_h-wall-1]);
            // slot for M3 threaded inserts
            translate([10/2, 10/2, cylinder_h-wall-1-15])
              cylinder(d=4.6, h=15+1, $fn=fn(30));
          }
    translate([30, 15, 0])
      cube([10, 10, cylinder_h-wall-1]);
    %translate([0, 0, cylinder_h-wall-1])
      buttons_board();
  }
  // control board
  translate([-80.1/2, -52.5/2+70, wall])
  {
    for(dx=[-2, 80.1-10+2])
      for(dy=[-2, 52.5-10+2])
        translate([dx, dy, 0])
          difference()
          {
            cube([10, 10, 15]);
            // slot for M3 threaded inserts
            translate([10/2, 10/2, 5])
              cylinder(d=4.6, h=10+1, $fn=fn(30));
          }
    %translate([0, 0, 15])
      control_board();
  }
  // top part screw holders
  for(rot=[0, 90])
    for(d=[-1, 1])
      rotate([0,0,rot])
        translate((cylinder_d/2-7)*[d, 0, 0])
          translate(10/2*[-1,-1,0])
            difference()
            {
              cube([10, 10, cylinder_h]);
              // slot for M3 threaded inserts
              translate([10/2, 10/2, cylinder_h-15])
                cylinder(d=4.6, h=15+1, $fn=fn(30));
            }
  // reinforcements for better rigidity of the bottom
  for(rot=[0, 90])
    rotate([0, 0, 45+rot])
      translate([-wall/2, -cylinder_d/2, wall])
        cube([wall, cylinder_d, wall]);
}


main_hull();

%if(false)
{
  delta = 10;
  translate([0, 0, cylinder_h + delta])
  {
    seal();
    translate([0, 0, seal_h + delta])
      top();
  }
}
