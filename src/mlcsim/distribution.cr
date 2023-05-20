require "gsl"

class MLCSim::Distribution
  alias ThresholdMap = Array(Array(Float64))

  def self.generate_error_map(threshold_maps : Hash(String, ThresholdMap), bits : Int32) : Array(Array(Float64))
    if threshold_maps.any? { |map| map.keys != (0...bits).to_a }
      raise Argumenterror.new("Threshold map does not have enough values for #{bits} levels")
    end

    threshold_map = threshold_maps[bits]
    error_map = [[0.0]]
  end

  def self.normal_midpoint(mean_a : Float64, mean_b : Float64, std_a : Float64, std_b : Float64) : Float64

    # No need to find midpoint if they're equivalent
    return mean_a if mean_a == mean_b

    # https://stackoverflow.com/a/32574638/9047818
    a = (1 / (2 * std_a**2)) - (1 / (2 * std_b**2))
    b = (mean_b / (std_b**2)) - (mean_a / (std_a**2))
    c = mean_a**2 / (2 * std_a**2) - mean_b**2 / (2 * std_b**2) - Math.log(std_b / std_a)

    # GSL takes arguments reverse to numpy
    roots = GSL::Poly.new([c, b, a]).solve

    # filter out roots outside of mean_a and mean_b
    min_mean = Math.min(mean_a, mean_b)
    max_mean = Math.max(mean_a, mean_b)
    roots.select { |root| min_mean <= root && root <= max_mean }.first
  end
end
