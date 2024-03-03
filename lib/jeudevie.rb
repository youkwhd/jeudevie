require "jeudevie/cell"
require "jeudevie/grid"

class << Jeudevie
  @grid = nil

  def init()
    @grid = Jeudevie::Grid::new(5, 5)
    @grid.set_cell(0, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(1, 2, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 0, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 2, Jeudevie::Cell::ALIVE)
  end

  def simulate()
    Jeudevie::init()

    loop do
      Jeudevie::_print()
      Jeudevie::update()
      print "\n"

      sleep 0.5
    end
  end

  def update()
    _grid = Jeudevie::Grid::new(@grid.cols(), @grid.rows())

    for i in (0..._grid.cols()) do
      for j in (0..._grid.rows()) do
        alive_count = @grid.alive_neighbors_count(i, j)

        case @grid.get_cell(i, j)
        when Jeudevie::Cell::ALIVE
          if alive_count < 2
            _grid.set_cell(i, j, Jeudevie::Cell::DEAD)
          end

          if alive_count == 2 or alive_count == 3
            _grid.set_cell(i, j, Jeudevie::Cell::ALIVE)
          end

          if alive_count > 3
            _grid.set_cell(i, j, Jeudevie::Cell::DEAD)
          end
        when Jeudevie::Cell::DEAD
          if alive_count == 3
            _grid.set_cell(i, j, Jeudevie::Cell::ALIVE)
          end
        end
      end
    end

    @grid = _grid 
  end

  def _print()
    @grid.print()
  end
end
