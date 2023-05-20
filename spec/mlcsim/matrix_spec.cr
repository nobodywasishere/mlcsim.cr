require "../spec_helper"

describe MLCSim::Matrix do
  it "creates a matrix of a given size" do
    matrix = MLCSim::Matrix.new(2, 3, 4)
    matrix.array.size.should eq(4)
    matrix.array.first.size.should eq(3)
  end

  it "injects faults" do
    matrix = MLCSim::Matrix.new(2, 3, 4)
    original = matrix.array.clone
    faults = matrix.inject_faults([
      [0.0, 0.5],
      [0.5, 0.5],
      [0.5, 0.0],
    ])

    errs = 0
    (0...matrix.array.size).each do |i|
      (0...matrix.array.first.size).each do |j|
        errs += 1 if matrix.array[i][j] != original[i][j]
      end
    end
    errs.should eq(faults)
  end
end
