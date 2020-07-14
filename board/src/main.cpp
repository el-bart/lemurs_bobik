#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>
#include "Buttons.hpp"
#include "Engines.hpp"

enum class Dir
{
  Fwd,
  Rev
};

template<typename E>
void turn_engine(E& e, const Dir dir)
{
  switch(dir)
  {
    case Dir::Fwd: e.step_forward(); break;
    case Dir::Rev: e.step_backward(); break;
  }
}

Engines::Left left;
Engines::Right right;

void turn_steps(const Dir left_dir, const Dir right_dir)
{
  turn_engine(left, left_dir);
  turn_engine(right,right_dir);
  Engines::step_delay();
  left.off();
  right.off();
}


int main(void)
{
  Buttons::init();

  //Watchdog wdt;

  while(true)
  {
    if( Buttons::up_pressed() )
    {
      turn_steps(Dir::Fwd, Dir::Fwd);
      continue;
    }
    if( Buttons::down_pressed() )
    {
      turn_steps(Dir::Rev, Dir::Rev);
      continue;
    }
    if( Buttons::left_pressed() )
    {
      turn_steps(Dir::Fwd, Dir::Rev);
      continue;
    }
    if( Buttons::right_pressed() )
    {
      turn_steps(Dir::Rev, Dir::Fwd);
      continue;
    }

    if( Buttons::start_pressed() )
    {
      turn_steps(Dir::Fwd, Dir::Fwd);
      turn_steps(Dir::Rev, Dir::Rev);
      continue;
    }
  }

}
