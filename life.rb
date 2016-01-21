#! /usr/bin/env ruby

require 'pp'
require 'ncurses'

require_relative 'screen'

class Life
  PICTURE = [" ", "█"]
  UNKNOWN_VALUE_PICTURE = "?"

  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i

  def initialize
    @screen = Screen.new
    initialise_grid
    initialise_screen
  end

  def step_forward
    @grid = neighbourhoods.map do |neighbourhood_row|
      neighbourhood_row.map { |neighbourhood| apply_rule(neighbourhood) }
    end
  end

  def display_grid
    @grid.each_with_index { |row, index| display_row(index, row) }
    refresh_screen
  end

  def refresh_screen
    @screen.refresh
  end

  def exit
    @screen.close
  end

  def neighbourhoods
    height.times.map { |r| width.times.map { |c| neighbourhood(r, c) } }
  end

  def apply_rule(neighbourhood)
    neighbours = neighbour_count(neighbourhood)
    centre = centre(neighbourhood)
    return 1 if neighbours == 3
    (centre == 1 && neighbours == 2) ? 1 : 0
  end

  def run_once
    step_forward
    display_grid
    wait
  end

  def wait
    sleep(0.2)
  end

  def show_initial_configuration
    display_grid
    wait
  end

  private

  def initialise_grid
    @grid = WINDOW_HEIGHT.times.map { |row| Array.new(WINDOW_WIDTH, 0) }
    [ [ 0, 0, 0, 0, 0 ],
      [ 0, 0, 1, 1, 0 ],
      [ 0, 1, 1, 0, 0 ],
      [ 0, 0, 1, 0, 0 ],
      [ 0, 0, 0, 0, 0 ] ].each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        r = WINDOW_HEIGHT / 2 - 2 + row_index
        c = WINDOW_WIDTH / 2 - 2 + cell_index
        @grid[r][c] = cell
      end
    end
  end

  def initialise_screen
    @screen.prepare
  end

  def neighbour_count(neighbourhood)
    total = neighbourhood.flatten.inject(0) { |sum, n| sum + n }
    total - centre(neighbourhood)
  end

  def centre(neighbourhood)
    neighbourhood[1][1]
  end

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

  # TODO Figure out how to refactor this into Screen without breaking ncurses
  def display_row(index, row)
    Ncurses.mvaddstr(index, 0, row.map { |cell| picture(cell) }.join)
  end

  def picture(cell)
    PICTURE[cell] || UNKNOWN_VALUE_PICTURE
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Life.new
  game.show_initial_configuration
  1.upto(10_000) { game.run_once }
  game.exit
end
