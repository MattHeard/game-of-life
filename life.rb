#! /usr/bin/env ruby

require 'ncurses'

class Life
  def initialise_screen
    Ncurses.initscr
  end

  def print_hello_world
    Ncurses.mvaddstr(4, 19, "Hello, world!");
  end

  def refresh
    Ncurses.refresh
  end

  def close_screen
    Ncurses.endwin
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Life.new
  game.initialise_screen
  game.print_hello_world
  game.refresh
  sleep(2.5)
  game.close_screen
end
