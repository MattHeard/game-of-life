class Grid
  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i

  attr_accessor :matrix

  def initialize
    @matrix = create_matrix
  end

  def height
    @matrix.size
  end

  def width
    @matrix[0].size
  end

  def display(game)
    @matrix.each_with_index { |row, index| game.draw_row(index, row) }
  end

  private

  def create_matrix
    matrix = WINDOW_HEIGHT.times.map { |row| Array.new(WINDOW_WIDTH, 0) }
    [ [ 0, 0, 0, 0, 0 ],
      [ 0, 0, 1, 1, 0 ],
      [ 0, 1, 1, 0, 0 ],
      [ 0, 0, 1, 0, 0 ],
      [ 0, 0, 0, 0, 0 ] ].each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        r = WINDOW_HEIGHT / 2 - 2 + row_index
        c = WINDOW_WIDTH / 2 - 2 + cell_index
        matrix[r][c] = cell
      end
    end
    matrix
  end
end
