module Slack
  module Mixins
    module Proc
      
      ##
      # This method creates a new `Speck::Check` initialized to pass if the
      # receiver can be executed without `exception` being raised, or fail if
      # the receiver raises `exception` when raised.
      # 
      # The passed exception object will be `rescue`d from within the block,
      # but any other exception raised by the block will not be caught.
      def check_exception exception = Exception
        ::Speck::Check.new(->{self}) {|p|
          begin
            p.call
            false
          rescue exception
            true
          end
        } .tap {|check| ::Speck.current.checks << check if ::Speck.current }
      end
      
    end
  end
end
