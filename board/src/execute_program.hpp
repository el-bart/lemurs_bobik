#pragma once
#include "config.hpp"
#include "Direction.hpp"
#include "Buttons.hpp"
#include "Engines.hpp"
#include "Watchdog.hpp"

namespace detail
{

inline void inter_dir_delay(Watchdog& wdg)
{
  for(auto i=0; i<5; ++i)
  {
    _delay_ms(100);
    wdg.reset();
  }
}

inline void step_delay() { _delay_ms(30); }

template<typename FL, typename FR>
void execute_action(Watchdog& wdg, FL&& left, FR&& right, const uint16_t steps)
{
  for(auto i=0l; i<steps; ++i)
  {
    left();
    right();
    step_delay();
    wdg.reset();
  }
}

template<typename FL, typename FR>
void execute_turn(Watchdog& wdg, FL&& left, FR&& right)
{
  constexpr auto steps_per_turn = 30l;
  execute_action(wdg, left, right, steps_per_turn);
}

template<typename FL, typename FR>
void execute_drive(Watchdog& wdg, FL&& left, FR&& right)
{
  constexpr auto steps_per_drive_len = 100l;
  execute_action(wdg, left, right, steps_per_drive_len);
}

template<typename E1, typename E2>
void execute_step(const Direction dir, Watchdog& wdg, E1& left, E2& right)
{
  switch(dir)
  {
    case Direction::Forward:  execute_drive( wdg, [&] { left.step_forward();  }, [&] { right.step_forward();  } ); return;
    case Direction::Backward: execute_drive( wdg, [&] { left.step_backward(); }, [&] { right.step_backward(); } ); return;
    case Direction::Left:     execute_turn ( wdg, [&] { left.step_backward(); }, [&] { right.step_forward();  } ); return;
    case Direction::Right:    execute_turn ( wdg, [&] { left.step_forward();  }, [&] { right.step_backward(); } ); return;
    case Direction::Stop:
         left.off();
         right.off();
         wdg.reset();
         return;
  }
}

}


template<uint8_t N>
void execute_program(const Direction (&dirs)[N], Watchdog& wdg)
{
  Engines::Left left;
  Engines::Right right;

  auto first_run = true;
  for(auto& dir: dirs)
  {
    if(dir == Direction::Stop)
      return;

    if(first_run)
      first_run = false;
    else
      detail::inter_dir_delay(wdg);

    detail::execute_step(dir, wdg, left, right);
  }
}
