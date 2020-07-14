#pragma once
#include "config.hpp"
#include "Direction.hpp"
#include "Buttons.hpp"
#include "Engines.hpp"
#include "Watchdog.hpp"

namespace detail
{

struct EnginesControl
{
  auto execute_step(const Direction dir)
  {
    switch(dir)
    {
      case Direction::Forward:  return execute_drive( [&] { left_.step_forward();  }, [&] { right_.step_forward();  } );
      case Direction::Backward: return execute_drive( [&] { left_.step_backward(); }, [&] { right_.step_backward(); } );
      case Direction::Left:     return execute_turn ( [&] { left_.step_backward(); }, [&] { right_.step_forward();  } );
      case Direction::Right:    return execute_turn ( [&] { left_.step_forward();  }, [&] { right_.step_backward(); } );
      case Direction::Stop:
                                left_.off();
                                right_.off();
                                Watchdog::reset();
                                return false;
    }
    return false; // never reached
  }

private:
  inline void step_delay() const { _delay_ms(30); }

  template<typename FL, typename FR>
  bool execute_action(FL&& left, FR&& right, const uint16_t steps)
  {
    for(auto i=0l; i<steps; ++i)
    {
      left();
      right();
      step_delay();
      // TODO: disable engines here!
      Watchdog::reset();
      if( Buttons::any_pressed() )
        return false;
    }
    return true;
  }

  template<typename FL, typename FR>
  bool execute_turn(FL&& left, FR&& right)
  {
    constexpr auto steps_per_turn = 30l;
    return execute_action(left, right, steps_per_turn);
  }

  template<typename FL, typename FR>
  bool execute_drive(FL&& left, FR&& right)
  {
    constexpr auto steps_per_drive_len = 100l;
    return execute_action(left, right, steps_per_drive_len);
  }

  Engines::Left left_;
  Engines::Right right_;
};


inline void inter_dir_delay()
{
  for(auto i=0; i<5; ++i)
  {
    _delay_ms(100);
    Watchdog::reset();
  }
}

}


template<uint8_t N>
void execute_program(const Direction (&dirs)[N])
{
  detail::EnginesControl ec;

  auto first_run = true;
  for(auto& dir: dirs)
  {
    if(first_run)
      first_run = false;
    else
      detail::inter_dir_delay();

    if( not ec.execute_step(dir) )
      return;
  }
}
