#! /usr/bin/env ruby

require 'pp'
require 'ncurses'

require_relative 'grid'
require_relative 'screen'

class Life
  PICTURE = [" ", "█"]
  UNKNOWN_VALUE_PICTURE = "?"

  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i

  def initialize
    @screen = Screen.new
    @grid = Grid.new
    initialise_screen
  end

  def exit
    @screen.close
  end

  def run_once
    step_forward
    display_grid
    wait
  end

  def show_initial_configuration
    display_grid
    wait
  end

  # TODO Figure out how to refactor this into Screen without breaking ncurses
  def draw_row(index, row)
    Ncurses.mvaddstr(index, 0, row.map { |cell| picture(cell) }.join)
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

  private

  def wait
    sleep(0.2)
  end

  def display_grid
    @grid.display(self)
    @screen.refresh
  end

  def step_forward
    @grid.step_forward(self)
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
        @grid.matrix[(r + row_offset) % height][(c + column_offset) % width]
      end
    end
  end

  def height
    @grid.height
  end

  def width
    @grid.width
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
