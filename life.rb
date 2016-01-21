#! /usr/bin/env ruby

require 'ncurses'

class Life
  PICTURE = [" ", "█"]
  UNKNOWN_VALUE_PICTURE = "?"

  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i

  def initialise_grid
    @grid = Array.new(WINDOW_HEIGHT, Array.new(WINDOW_WIDTH, 1))
  end

  def display_grid
    @grid.each_with_index { |row, index| display_row(index, row) }
  end

  def initialise_screen
    Ncurses.initscr
  end

  def refresh
    Ncurses.refresh
  end

  def close_screen
    Ncurses.endwin
  end

  private

  def display_row(index, row)
    Ncurses.mvaddstr(index, 0, row.map { |cell| picture(cell) }.join)
  end

  def picture(cell)
    PICTURE[cell] || UNKNOWN_VALUE_PICTURE
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Life.new
  game.initialise_screen
  game.initialise_grid
  game.display_grid
  game.refresh
  sleep(2)
  game.close_screen
end
