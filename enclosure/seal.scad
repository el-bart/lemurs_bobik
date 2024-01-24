include<detail/config.scad>
use<m3d/fn.scad>


module seal_base_()
{
  // external ring
  difference()
  {
    $fn = fn(3*360);
    circle(d = cylinder_d);
    circle(d = cylinder_d - 2 * wall);
  }
  // supports and screw slots
  for(rot=[0, 90])
    for(d=[-1, 1])
      rotate([0,0,rot])
        translate((cylinder_d/2-7)*[d, 0, 0])
          translate(10/2*[-1,-1,0])
            difference()
            {
              square(10*[1, 1]);
              // slot for M3 threaded inserts
              translate(10/2*[1, 1])
                circle(d=4.6, $fn=fn(30));
            }
}

module seal()
{
  linear_extrude(seal_h)
    seal_base_();
}


seal();
