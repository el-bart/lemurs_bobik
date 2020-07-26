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

module main_cap()
{
  cap_block_();
}


main_cap();
//%translate([0,0,-75])
//  main_hull();
