require "ansi"
require "jeudevie/cell"
require "jeudevie/grid"

class << Jeudevie
  @grid = nil

  def init()
    @grid = Jeudevie::Grid::new(6, 6)

    @grid.set_cell(0, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(1, 2, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 0, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 1, Jeudevie::Cell::ALIVE)
    @grid.set_cell(2, 2, Jeudevie::Cell::ALIVE)
  end

  def simulate()
    Jeudevie::init()
    Jeudevie::__handle_sigint()

    ANSI::Cursor::hide()

    loop do
      Jeudevie::_print()
      Jeudevie::update()

      sleep 0.5
    end
  end

  def update()
    _grid = Jeudevie::Grid::new(@grid.cols, @grid.rows)

    for i in (0..._grid.cols) do
      for j in (0..._grid.rows) do
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
    @grid.println()
    ANSI::Cursor::go_up(@grid.cols)
  end

  def __handle_sigint()
    Signal.trap("INT") {
      ANSI::Cursor::show()

      # -1 for cursor
      ANSI::Cursor::go_down(@grid.cols - 1)

      # -1 for cursor and -1 to get the cursor onto the grid
      ANSI::Cursor::go_right(@grid.rows - 2)

      exit(0)
    }
  end
end
