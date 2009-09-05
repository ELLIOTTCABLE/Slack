module Slack
  module Mixins
    module Object
      
      ##
      # This method creates a new `Speck::Check` utilizing a passed block.
      # 
      # It expects an expectation (returning `true` or `false`) to be passed.
      # The block will be passed the receiver, so you can run comparators on
      # it, or whatever else you like.
      # 
      # The intention is that this method be used to quickly check that
      # particular methods return values as expected. For instance, the
      # following would be used to check that MyClass#initialize properly
      # assigns its argument to the `thingie` attribute:
      #     
      #     MyClass.new(an_object).check {|my| my.thingie == an_object }
      # --
      # TODO: Speck Object#check
      def check &block
        raise LocalJumpError, 'no block given' unless block_given?
        ::Speck::Check.new(self, &block)
      end
      
    end
  end
end
