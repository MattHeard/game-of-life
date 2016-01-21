require 'ncurses'

class Screen
  def prepare
    Ncurses.initscr
  end
end
