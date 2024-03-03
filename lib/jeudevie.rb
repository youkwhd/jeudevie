require "jeudevie/cell"
require "jeudevie/grid"

class << Jeudevie
  @grid = nil

  def init()
    @grid = Jeudevie::Grid::new(6, 6)

    # @grid.set_cell(0, 0, Jeudevie::Cell::ALIVE)
    # @grid.set_cell(1, 0, Jeudevie::Cell::ALIVE)
    # @grid.set_cell(2, 0, Jeudevie::Cell::ALIVE)

    @grid.set_cell(2, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(3, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(4, 2, Jeudevie::Cell::ALIVE)

    @grid.set_cell(1, 3, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 4, Jeudevie::Cell::ALIVE)
    @grid.set_cell(3, 4, Jeudevie::Cell::ALIVE)

    # @grid.set_cell(0, 1, Jeudevie::Cell::ALIVE)
    # @grid.set_cell(1, 2, Jeudevie::Cell::ALIVE)
    # @grid.set_cell(2, 0, Jeudevie::Cell::ALIVE)
    # @grid.set_cell(2, 1, Jeudevie::Cell::ALIVE)
    # @grid.set_cell(2, 2, Jeudevie::Cell::ALIVE)
  end

  def simulate()
    Jeudevie::init()

    loop do
      Jeudevie::_print()
      Jeudevie::update()

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
          _grid.set_cell(i, j, alive_count.between?(2, 3) ? Jeudevie::Cell::ALIVE : Jeudevie::Cell::DEAD)
        when Jeudevie::Cell::DEAD
          _grid.set_cell(i, j, alive_count == 3 ? Jeudevie::Cell::ALIVE : Jeudevie::Cell::DEAD)
        end
      end
    end

    @grid = _grid 
  end

  def _print()
    @grid.print()
    print "\x1b[#{@grid.cols()}A"
    print "\x1b[#{@grid.rows()}D"
  end
end
