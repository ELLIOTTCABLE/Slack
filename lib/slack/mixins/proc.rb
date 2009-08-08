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
        raise ::Speck::Exception::NoEnvironment unless ::Speck.current
        
        file, line, _ = Kernel::caller.first.split(':')
        source = File.open(file).readlines[line.to_i - 1]
        source.strip!
        source = source.partition(".check_exception")
        
        ::Speck::Check.new(source.first, exception.to_s) {
          begin
            self.call
            false
          rescue exception
            true
          end
        } .tap {|check| ::Speck.current.checks << check }
      end
      
    end
  end
end
