module stepper_mock()
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


stepper_mock();
