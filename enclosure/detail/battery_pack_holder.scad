eps = 0.01;

module battery_pack_mock()
{
  size = [50, 100, 50];
  translate([-size.x/2, 0, 0])
    cube(size);
}

module battery_pack_holder()
{
  size = [4, 30, 10];
  velcro_slot = [size.x+2*eps, 35, 5];
  module mount_side()
  {
    module body()
    {
      translate([0, size.z, 0])
        intersection()
        {
          hull()
            for(dy=[0, size.y])
              translate([-size.x/2, dy, 0])
                rotate([0, 90, 0])
                  cylinder(r=size.z, h=size.x);
          translate(-2*[size.x, size.y, 0])
            cube(4*size);
        }
    }

    module slot(dh)
    {
      vs = velcro_slot;
      translate([0, (size.y+2*size.z)/2, -dh])
        translate(-0.5*[vs.x, vs.y, 0])
          cube(vs + [0, 0, dh]);
    }

    difference()
    {
      body();
      slot(dh=eps);
    }
  }

  for(dy=[0, 55])
    for(dir=[-1,+1])
      translate([dir*(50+10)/2, dy, 0])
        mount_side();

  %battery_pack_mock();
}

battery_pack_holder();
