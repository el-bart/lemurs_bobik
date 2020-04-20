module tooth_(h)
{
  $fs=0.01;
  $fn=0;
  difference()
  {
    union()
    {
      translate([0, 0.2, 0])
        cylinder(r=0.8/2, h=h);
      translate([-0.4, 0, 0])
        cube([0.8, 0.2, h]);
    }
    translate([-0.4, -1, 0])
      cube([0.8, 1, h]);
  }
}

module gear_()
{
  h=6;
  r=22.1544;
  pi=3.1415926535897932385;
  l=2*pi*r;
  n=l/(0.8*2);
  echo("XXXXXXXXXXXX: ", n);
  cylinder(r=r, h=h, $fs=0.1, $fn=100);
  for(i=[0:n-1])
    rotate(i*[0, 0, 360/n])
      translate([0, r, 0])
        tooth_(h);
}

module wheel()
{
  cylinder(h=5, r=40);
  translate([0, 0, 5])
    gear_();
}

//wheel();
gear_();
