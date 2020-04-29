module battery_pack()
{
  cube([63.1, 57.9, 16.25]);
  translate([63.1-13-5, 57.9, 0])
    cube([5, 5, 5]);
}


module control_board()
{
  difference()
  {
    cube([80.1, 52.5, 2]);
    translate([(80.1-74.5)/2, (52.5-46.2)/2, 0])
      for(dx=[0, 74.5])
        for(dy=[0,46.2])
          translate([dx, dy, -1])
            cylinder(r=3.5/2, h=2+1+1, $fn=10);
  }
}


module button_()
{
  cube([12, 12, 4]);
  translate([12/2, 12/2, 4])
    cylinder(r=7/2, h=1);
}

module buttons_board()
{
  difference()
  {
    union()
    {
      cube([86.10, 42, 1]);
      translate([0,0,1])
      {
        // "left"
        translate([2.5, 15, 0])
          button_();
        // "up"
        translate([20.5, 29, 0])
          button_();
        // "down"
        translate([20.5, 1.5, 0])
          button_();
        // "right"
        translate([40, 15, 0])
          button_();
        // "start"
        translate([71, 15, 0])
          button_();
      }
    }
    translate([(86.1-78.5)/2, (42-34.8)/2, 0])
      for(dx=[0, 78.5])
        for(dy=[0, 34.8])
          translate([dx, dy, -1])
            cylinder(r=3.5/2, h=1+1+1, $fn=10);
  }
}

%translate([0, 60, 0])
  battery_pack();
%translate([0, 130, 0])
  control_board();
%buttons_board();
