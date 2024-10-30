require "rspec"
require_relative "../lib/node"

RSpec.describe Node do
  let(:subject) { Node.new(0) }

  describe "@left_node" do
    it "implements a getter" do
      expect(subject).to respond_to :left_node
    end

    it "implements a setter" do
      expect(subject).to respond_to :left_node=
    end
  end

  describe "@right_node" do
    it "implements a getter" do
      expect(subject).to respond_to :right_node
    end

    it "implements a setter" do
      expect(subject).to respond_to :right_node=
    end
  end

  describe "@data" do
    it "implements a getter" do
      expect(subject).to respond_to :data
    end
  end

  describe "#<=>" do
  end
end
