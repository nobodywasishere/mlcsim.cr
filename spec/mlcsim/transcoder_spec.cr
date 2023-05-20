require "../spec_helper"

describe MLCSim::Transcoder do
  context "when transcoding" do
    it "encodes a value into cells" do
      transcoder = MLCSim::Transcoder.new([[0, 1], [2, 3]])
      transcoder.encode(0).should eq([0, 0])
      transcoder.encode(1).should eq([1, 0])
      transcoder.encode(2).should eq([2, 0])
      transcoder.encode(3).should eq([3, 0])
      transcoder.encode(4).should eq([0, 1])
      transcoder.encode(5).should eq([1, 1])
      transcoder.encode(6).should eq([2, 1])
      transcoder.encode(7).should eq([3, 1])
      transcoder.encode(8).should eq([0, 2])
      transcoder.encode(9).should eq([1, 2])
      transcoder.encode(10).should eq([2, 2])
      transcoder.encode(11).should eq([3, 2])
      transcoder.encode(12).should eq([0, 3])
      transcoder.encode(13).should eq([1, 3])
      transcoder.encode(14).should eq([2, 3])
      transcoder.encode(15).should eq([3, 3])
    end

    it "returns nil if value too big" do
      transcoder = MLCSim::Transcoder.new([[0, 1], [2, 3]])
      transcoder.encode(16).should eq(nil)
      transcoder.encode(17).should eq(nil)
      transcoder.encode(18).should eq(nil)
    end

    it "decodes cells into a value" do
      transcoder = MLCSim::Transcoder.new([[0, 1], [2, 3]])
      transcoder.decode([0, 0]).should eq(0)
      transcoder.decode([1, 0]).should eq(1)
      transcoder.decode([2, 0]).should eq(2)
      transcoder.decode([3, 0]).should eq(3)
      transcoder.decode([0, 1]).should eq(4)
      transcoder.decode([1, 1]).should eq(5)
      transcoder.decode([2, 1]).should eq(6)
      transcoder.decode([3, 1]).should eq(7)
      transcoder.decode([0, 2]).should eq(8)
      transcoder.decode([1, 2]).should eq(9)
      transcoder.decode([2, 2]).should eq(10)
      transcoder.decode([3, 2]).should eq(11)
      transcoder.decode([0, 3]).should eq(12)
      transcoder.decode([1, 3]).should eq(13)
      transcoder.decode([2, 3]).should eq(14)
      transcoder.decode([3, 3]).should eq(15)
    end

    it "returns nil if cells too big" do
      transcoder = MLCSim::Transcoder.new([[0, 1], [2, 3]])
      transcoder.decode([0, 4]).should eq(nil)
      transcoder.decode([4, 0]).should eq(nil)
      transcoder.decode([4, 4]).should eq(nil)
    end
  end
end
