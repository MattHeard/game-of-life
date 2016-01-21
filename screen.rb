require 'ncurses'

class Screen
  def prepare
    Ncurses.initscr
  end

  def refresh
    Ncurses.refresh
  end
end
