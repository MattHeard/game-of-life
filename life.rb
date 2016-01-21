#! /usr/bin/env ruby

require 'pp'
require 'ncurses'

class Life
  PICTURE = [" ", "█"]
  UNKNOWN_VALUE_PICTURE = "?"

  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i - 2
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i - 2

  def initialise_grid
    @grid = WINDOW_HEIGHT.times.map { |row| Array.new(WINDOW_WIDTH, 0) }
    @grid[WINDOW_HEIGHT / 2][WINDOW_WIDTH / 2] = 1
  end

  def step_forward
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

  def neighbourhoods
    height.times.map { |r| width.times.map { |c| neighbourhood(r, c) } }
  end

  private

  def neighbourhood(r, c)
    (-1..1).map do |row_offset|
      (-1..1).map do |column_offset|
        @grid[(r + row_offset) % height][(c + column_offset) % width]
      end
    end
  end

  def height
    @grid.size
  end

  def width
    @grid[0].size
  end

  def display_row(index, row)
    Ncurses.mvaddstr(index, 0, row.map { |cell| picture(cell) }.join)
  end

  def picture(cell)
    PICTURE[cell] || UNKNOWN_VALUE_PICTURE
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Life.new
  game.initialise_grid
  pp game.neighbourhoods
  # game.initialise_screen
  # 2.times do |_|
  #   game.step_forward
  #   game.display_grid
  #   game.refresh_screen
  #   sleep(2)
  # end
  # game.close_screen
end
