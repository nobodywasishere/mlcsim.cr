class MLCSim::Matrix

  getter array : Array(Array(Int32))

  def initialize(bits : Int32, cells : Int32, size : Int32)
    @array = Array.new(size) {
      Array.new(cells) {
        Random.rand(2**bits - 1)
      }
    }
  end

  def inject_faults(error_map : Array(Array(Float64))) : Int32
    error_count = 0
    (0...@array.size).each do |i|
      (0...@array[0].size).each do |j|
        val = @array[i][j]
        new_val = val

        err_prob_l = error_map[val][0]
        err_prob_h = error_map[val][1]

        rand = Random.rand()

        if rand < err_prob_l
          new_val -= 1
        elsif err_prob_l < rand && rand < err_prob_l + err_prob_h
          new_val += 1
        end

        if val != new_val
          error_count += 1
          @array[i][j] = new_val
        end
      end
    end
    error_count
  end
end
