module tooth_(h)
{
  $fs=0.01;
  $fn=0;
  difference()
  {
    union()
    {
      translate([0, 0.4, 0])
        cylinder(r=0.8/2, h=h);
      translate([-0.4, -0.1, 0])
        cube([0.8, 0.5, h]);
    }
    translate([-0.4, -1, 0])
      cube([0.8, 1, h]);
  }
}

module gear_(h)
{
  r=22.1544;
  pi=3.1415926535897932385;
  l=2*pi*r;
  n=l/(0.8*2);
  echo("R=", r);
  echo("N=", n);
  echo("ratio=", n/16);
  cylinder(r=r, h=h, $fn=200);
  for(i=[0:n-1])
    rotate(i*[0, 0, 360/n])
      translate([0, r, 0])
        tooth_(h);
}

module wheel()
{
  h=6;
  difference()
  {
    union()
    {
      cylinder(h=h, r=40, $fs=0.1, $fn=1*360);
      translate([0, 0, h])
        gear_(h);
    }
    cylinder(r=4.3/2, h=2*h+1, $fn=1*360);
  }
}

for(i=[0:1])
  translate(i*[0, 80+5, 0])
    wheel();
