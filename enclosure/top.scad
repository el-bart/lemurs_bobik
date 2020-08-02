use<electronics_mocks.scad>
use<bottom.scad>

wall=4;

module cap_block_()
{
  // external ring
  rotate_extrude($fn=1*360)
    translate([340/2-wall, 0, 0])
      difference()
      {
        circle(r=wall);
        rotate([0, 0, 180])
          translate([-wall, 0,0])
            square(size=wall*[2,1]);
      }
  // center infill w/o hull()
  cylinder(r=340/2-wall, h=wall);
}


module cap_holes_()
{
  for(rot=[0, 90])
    for(d=[-1, 1])
      rotate([0,0,rot])
        translate((340/2-7)*[d, 0, 0])
          cylinder(r=3.3/2, h=wall+1, $fn=30);
}

module button_hole_()
{
  translate(-1*[1,1,0])
  {
    // button
    cube([12+2*1, 12+2*1, 4+wall]);
    // solderings
    translate(-3*[1,0,0])
      cube([12+2*1+2*3, 12+2*1, 2]);
    // capacitor
    translate([12+2*1+4, (12+2*1-10)/2, 0])
      cube([8-4, 10, 3]);
  }
}

module buttons_holes_()
{
  // board
  translate([-1,-1,0])
    cube([86.1+2*1, 42+2*1, 1]);
  // buttons
  translate([0,0,1])
  {
    // "left"
    translate([2.5, 15, 0])
      button_hole_();
    // "up"
    translate([20.5, 29, 0])
      button_hole_();
    // "down"
    translate([20.5, 1.5, 0])
      button_hole_();
    // "right"
    translate([40, 15, 0])
      button_hole_();
    // "start"
    translate([71+12, 15, 0])
      mirror([1, 0, 0])
        button_hole_();
  }
  // screw head holes
  translate([(86.1-78.5)/2, (42-34.8)/2, 0])
    for(dx=[0, 78.5])
      for(dy=[0, 34.8])
        translate([dx, dy, -1])
          cylinder(r=6/2, h=1+3, $fn=10);
  // cables soldering
  translate([86.1+2*1, 42+2*1, 1] - [40, 13, 0])
    cube([30, 15, 2]);
}

module main_cap()
{
  difference()
  {
    cap_block_();
    cap_holes_();
    translate([-86.10/2, -42/2, -1])
      buttons_holes_();
  }
}


rotate(180*[1,0,0])
  main_cap();
//%translate([0,0,-75]) main_hull();
