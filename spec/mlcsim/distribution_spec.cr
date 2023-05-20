require "../spec_helper"

describe MLCSim::Distribution do
  describe "#normal_midpoint" do
    it "successfully finds the midpoint between 0.4 and 0.8 for different stdevs" do
      MLCSim::Distribution.normal_midpoint(0.4, 0.8, 1.0, 1.0).round(15).should eq(0.6)
      MLCSim::Distribution.normal_midpoint(0.4, 0.8, 0.5, 0.5).round(15).should eq(0.6)
      MLCSim::Distribution.normal_midpoint(0.4, 0.8, 0.2, 0.2).round(15).should eq(0.6)
      MLCSim::Distribution.normal_midpoint(0.4, 0.8, 0.1, 0.1).round(15).should eq(0.6)
    end

    it "successfully finds the same midpoint for different means" do
      MLCSim::Distribution.normal_midpoint(0.4, 0.6, 0.1, 0.1).round(15).should eq(0.5)
      MLCSim::Distribution.normal_midpoint(0.3, 0.7, 0.1, 0.1).round(15).should eq(0.5)
      MLCSim::Distribution.normal_midpoint(0.2, 0.8, 0.1, 0.1).round(15).should eq(0.5)
      MLCSim::Distribution.normal_midpoint(0.1, 0.9, 0.1, 0.1).round(15).should eq(0.5)
      MLCSim::Distribution.normal_midpoint(0.0, 1.0, 0.1, 0.1).round(15).should eq(0.5)
    end

    it "returns a midpoint of mean_a and mean_b are equivalent" do
      MLCSim::Distribution.normal_midpoint(0.0, 0.0, 0.1, 0.1).should eq(0.0)
      MLCSim::Distribution.normal_midpoint(0.1, 0.1, 0.1, 0.1).should eq(0.1)
      MLCSim::Distribution.normal_midpoint(0.2, 0.2, 0.1, 0.1).should eq(0.2)
      MLCSim::Distribution.normal_midpoint(0.3, 0.3, 0.1, 0.1).should eq(0.3)
      MLCSim::Distribution.normal_midpoint(0.4, 0.4, 0.1, 0.1).should eq(0.4)
      MLCSim::Distribution.normal_midpoint(0.5, 0.5, 0.1, 0.1).should eq(0.5)
    end
  end
end
