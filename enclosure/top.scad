use<electronics_mocks.scad>
use<bottom.scad>

wall=4;

module cap_block_()
{
  // external ring
  rotate_extrude($fn=0.1*360) // TODO: 1x
    translate([340/2-wall, 0, 0])
      difference()
      {
        circle(r=wall);
        #rotate([0, 0, 180])
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

module main_cap()
{
  difference()
  {
    cap_block_();
    cap_holes_();
  }
}


//main_cap();
cap_holes_();
//%translate([0,0,-75])
//  main_hull();
