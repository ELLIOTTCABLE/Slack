module Slack
  module Mixins
    module Boolean
      
      def check
        if block_given?
          super
        else
          raise ::Speck::Exception::NoEnvironment unless ::Speck.current
          
          ::Speck::Check.new { self.nil? ? false : self }
            .tap {|check| ::Speck.current.checks << check }
        end
      end
      
    end
  end
end
