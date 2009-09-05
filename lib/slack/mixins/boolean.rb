module Slack
  module Mixins
    module Boolean
      
      def check
        if block_given?
          super
        else
          ::Speck::Check.new { self.nil? ? false : self }
            .tap {|check| ::Speck.current.checks << check if ::Speck.current }
        end
      end
      
    end
  end
end
