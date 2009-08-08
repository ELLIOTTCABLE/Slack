module Slack
  module Mixins
    module Object
      
      ##
      # This method creates a new `Speck::Check` utilizing a passed block.
      # 
      # It expects a block (returning `true` or `false`) to be passed. The
      # block will be passed the receiver, so you can run comparators on it,
      # or whatever else you like.
      # 
      # The intention is that this method be used to quickly check that
      # particular methods return values as expected. For instance, the
      # following would be used to check that MyClass#initialize properly
      # assigns its argument to the `thingie` attribute:
      #     
      #     MyClass.new(an_object).check {|my| my.thingie == an_object }
      #     
      # The new `Check` instance is automatically documented with the contents
      # of the line of Ruby that produced the receiver of this method.
      # --
      # TODO: Speck Object#check
      def check &check
        raise ::Speck::Exception::NoEnvironment unless ::Speck.current
        raise LocalJumpError, 'no block given' unless block_given?
        
        # TODO: Move this into its own methods deeper in the library, and
        # clean it up.
        file, line, _ = Kernel::caller.first.split(':')
        source = File.open(file).readlines[line.to_i - 1]
        source.strip!
        source = source.partition(".check")
        
        ::Speck::Check.new(source.first, source.last) { check[self] }
          .tap {|check| ::Speck.current.checks << check }
      end
      
    end
  end
end
