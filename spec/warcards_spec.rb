require_relative './spec_helper'

module Cardgame
  describe Warcards do
    it "must be an instance of Warcards" do
      Warcards.new.must_be_instance_of Warcards
    end
  end

end