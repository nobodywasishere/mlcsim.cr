class MLCSim::Transcoder
  @bin_count : Int32 = 0
  @cell_count : Int32 = 0
  @size : Int32 = 0

  def initialize(config : MLCSim::ConfigType)
    @bin_count = config[0].size
    @cell_count = config.size
    @size = @bin_count + @cell_count
    @config = config
  end

  def encode(value : Int32) : Array(Int32) | Nil
    return nil if check_value(value)

    cells = [] of Int32
    @config.each do |cell|
      count = 0
      cell.each_with_index do |bit, index|
        count += bool(value & 2**bit) << index
      end
      cells << count
    end
    cells
  end

  def decode(cells : Array(Int32)) : Int32 | Nil
    return nil if check_cells(cells)
    value = 0
    @config.each_with_index do |cell, d|
      cell.each_with_index do |bit, i|
        value += bool(cells[d] & 2**i) * 2**bit
      end
    end
    value
  end

  private def bool(value : Int32) : Int32
    value > 0 ? 1 : 0
  end

  private def check_value(value : Int32) : Bool
    value > 2**@size - 1
  end

  private def check_cells(cells : Array(Int32)) : Bool
    cells.any? { |cell| cell > 2**@bin_count - 1 }
  end
end
