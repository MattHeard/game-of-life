class Grid
  WINDOW_HEIGHT = `/usr/bin/env tput lines`.to_i
  WINDOW_WIDTH = `/usr/bin/env tput cols`.to_i

  attr_accessor :matrix

  def initialize(config_file)
    @config_file = config_file
    create_matrix
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

  def step_forward(game)
    @matrix = neighbourhoods(game).map do |neighbourhood_row|
      neighbourhood_row.map { |neighbourhood| game.apply_rule(neighbourhood) }
    end
  end

  def neighbourhoods(game)
    height.times.map { |r| width.times.map { |c| game.neighbourhood(r, c) } }
  end

  private

  def create_matrix
    @matrix = WINDOW_HEIGHT.times.map { |row| Array.new(WINDOW_WIDTH, 0) }
    insert_config(ConfigLoader.new.load(@config_file))
  end

  def insert_config(config)
    config.config.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        top = config.top_padding(height)
        left = config.left_padding(width)
        @matrix[y + top][x + left] = cell
      end
    end
  end
end
