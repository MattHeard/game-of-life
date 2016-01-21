#! /usr/bin/env ruby

require 'ncurses'

class Life
  attr_reader :grid
  PICTURE = [" ", "█"]
  UNKNOWN_VALUE_PICTURE = "?"

  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i - 2
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i - 2

  def initialise_grid
    @grid = WINDOW_HEIGHT.times.map { |row| Array.new(WINDOW_WIDTH, 0) }
    @grid[WINDOW_HEIGHT / 2][WINDOW_WIDTH / 2] = 1
  end

  def display_grid
    @grid.each_with_index { |row, index| display_row(index, row) }
  end

  def initialise_screen
    Ncurses.initscr
  end

  def refresh_screen
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
  game.refresh_screen
  sleep(2)
  game.close_screen
end
