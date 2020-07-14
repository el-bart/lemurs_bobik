#pragma once
#include "config.hpp"
#include "Direction.hpp"
#include "Buttons.hpp"
#include "Watchdog.hpp"

namespace detail
{

inline void wait_for_all_buttons_released()
{
  while( Buttons::any_pressed() )
  {
    _delay_ms(10);
    Watchdog::reset();
  }
}


Direction read_next_direction()
{
  while(true)
  {
    Watchdog::reset();
    if( Buttons::forward_pressed() )
    {
      wait_for_all_buttons_released();
      return Direction::Forward;
    }
    if( Buttons::backward_pressed() )
    {
      wait_for_all_buttons_released();
      return Direction::Backward;
    }
    if( Buttons::left_pressed() )
    {
      wait_for_all_buttons_released();
      return Direction::Left;
    }
    if( Buttons::right_pressed() )
    {
      wait_for_all_buttons_released();
      return Direction::Right;
    }
    if( Buttons::start_pressed() )
    {
      wait_for_all_buttons_released();
      return Direction::Stop;
    }
  }
}

}


template<uint8_t N>
void read_program(Direction (&dirs)[N])
{
  for(auto i=0; i<N-1; ++i)
  {
    const auto dir = detail::read_next_direction();
    dirs[i] = dir;
    if(dir == Direction::Stop)
      return;
  }
  dirs[N-1] = Direction::Stop;
}
