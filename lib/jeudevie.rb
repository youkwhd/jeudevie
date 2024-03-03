require "jeudevie/cell"
require "jeudevie/grid"
require "jeudevie/game"

class << Jeudevie
  @grid = nil

  def init()
    @grid = Jeudevie::Grid::new(10, 10)
    @grid.set_cell(1, 0, Jeudevie::Cell::ALIVE)
    @grid.set_cell(1, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(1, 2, Jeudevie::Cell::ALIVE)
  end

  def simulate()
    Jeudevie::init()

    loop do
      Jeudevie::update()
      sleep 0.5
    end
  end

  def update()
    @grid.print()
  end
end
