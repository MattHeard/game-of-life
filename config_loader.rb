require 'pp'

class ConfigLoader
  attr_reader :config

  def load(filename)
    config_strings = File.readlines(filename).map(&:chars)
    @config = config_strings.map do |line|
      line[0...-1].map { |cell| (cell == " ") ? 0 : 1 }
    end

    self
  end

  def width
    @config.inject(0) do |width, line|
      width = line.size if (line.size > width)
      width
    end
  end

  def height
    @config.size
  end

  def left_padding(grid_width)
    (grid_width - width) / 2
  end

  def top_padding(grid_height)
    (grid_height - height) / 2
  end
end
