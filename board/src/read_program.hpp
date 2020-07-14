#pragma once
#include "config.hpp"
#include "Direction.hpp"
#include "Watchdog.hpp"

namespace detail
{

inline void wait_for_all_buttons_released(Watchdog& wdg)
{
  while( Buttons::any_pressed() )
  {
    _delay_ms(10);
    wdg.reset();
  }
}


Direction read_next_direction(Watchdog& wdg)
{
  while(true)
  {
    wdg.reset();
    if( Buttons::forward_pressed() )
    {
      wait_for_all_buttons_released(wdg);
      return Direction::Forward;
    }
    if( Buttons::backward_pressed() )
    {
      wait_for_all_buttons_released(wdg);
      return Direction::Backward;
    }
    if( Buttons::left_pressed() )
    {
      wait_for_all_buttons_released(wdg);
      return Direction::Left;
    }
    if( Buttons::right_pressed() )
    {
      wait_for_all_buttons_released(wdg);
      return Direction::Right;
    }
    if( Buttons::start_pressed() )
    {
      wait_for_all_buttons_released(wdg);
      return Direction::Stop;
    }
  }
}

}


template<uint8_t N>
void read_program(Direction (&dirs)[N], Watchdog& wdg)
{
  for(auto i=0; i<N-1; ++i)
  {
    const auto dir = detail::read_next_direction(wdg);
    dirs[i] = dir;
    if(dir == Direction::Stop)
      return;
  }
  dirs[N-1] = Direction::Stop;
}
