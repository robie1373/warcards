module Cardgame
  describe Stack do
    def setup
      @stack = Stack.new
    end

    it "must be able to append cards on the end" do
          original_stack_length = @stack.length
          @stack << Card.new(:suit => :spades, :value => 7)
          @stack.length.must_equal (original_stack_length + 1)
    end

    it "must have a stack of Card objects" do
      @stack << Card.new(:suit => :clubs, :value => 13)
      @stack.first.must_be_instance_of Card
    end

  end
end
