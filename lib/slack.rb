##
# Methods in `Slack` are provided with the purpose of making it simpler (and
# sexier!) to create `Speck::Check`s.
module Slack
  Version = 0
  
  ##
  # These modules (named after the Class they are intended to be mixed into)
  # provide convenience methods on those classes.
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
      # TODO: Remove the `->{self}` functionality, and implement Mixins::Truthy
      #       for TrueClass/FalseClass/NilClass
      def check &check
        check = ->(_){self} unless block_given?
        
        # TODO: Should we allow specks in the root environment? Could be useful
        #       for quick checks…
        raise Exception::NoEnvironment unless Speck.current
        
        # TODO: Implement documenting the `Check` using a preceding comment,
        #       if present.
        # TODO: Move this into its own methods deeper in the library, and
        # clean it up.
        file, line, _ = Kernel::caller.first.split(':')
        source = File.open(file).readlines[line.to_i - 1]
        source.strip!
        source = source.partition(".check").first
        # TODO: Get rid of the "(…)" around the resulting string.
        # TODO: Implement multi–line source documenting.
        
        Speck::Check.new(->(){ check[self] }, source)
          .tap {|check| Speck.current.checks << check }
      end
    end
    ::Object.send :include, Slack::Mixins::Object
    
    module Proc
      ##
      # This method creates a new `Speck::Check` initialized to pass if the
      # receiver can be executed without `exception` being raised, or fail if
      # the receiver raises `exception` when raised.
      # 
      # The passed exception object will be `rescue`d from within the block,
      # but any other exception raised by the block will not be caught.
      def check_exception exception = Exception
        # TODO: Should we allow specks in the root environment? Could be useful
        #       for quick checks…
        raise Exception::NoEnvironment unless Speck.current
        
        file, line, _ = Kernel::caller.first.split(':')
        source = File.open(file).readlines[line.to_i - 1]
        source.strip!
        source = source.partition(".check_exception").first
        # TODO: Get rid of the "->{…}" around the resulting string.
        
        Speck::Check.new(->(){
          begin
            self.call
          rescue exception
            return true
          end
          return false
        }, source)
          .tap {|check| Speck.current.checks << check }
      end
    end
    ::Proc.send :include, Slack::Mixins::Proc
    
  end
  
end
