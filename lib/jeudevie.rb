require "jeudevie/cell"
require "jeudevie/grid"

class << Jeudevie
  def simulate()
    grid = Jeudevie::Grid::new(10, 10)

    grid.set_cell(1, 0, Jeudevie::Cell::ALIVE)
    grid.set_cell(1, 1, Jeudevie::Cell::ALIVE)
    grid.set_cell(1, 2, Jeudevie::Cell::ALIVE)
    grid.alive_neighbors_count(1, 1)
    grid.print()
  end
end
