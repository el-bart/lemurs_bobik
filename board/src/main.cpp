#include "config.hpp"       // this file must be included as first one!
#include "Watchdog.hpp"
#include <util/delay.h>
#include "Buttons.hpp"
#include "Engines.hpp"
#include "Direction.hpp"
#include "read_program.hpp"
#include "execute_program.hpp"

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


inline void start_delay(Watchdog& wdg)
{
  for(auto i=0; i<5; ++i)
  {
    _delay_ms(100);
    wdg.reset();
  }
}


int main(void)
{
  Buttons::init();
  Direction dirs[32];
  Watchdog wdg;

  while(true)
  {
    wdg.reset();
    read_program(dirs, wdg);
    start_delay(wdg);
    execute_program(dirs, wdg);
  }
}
