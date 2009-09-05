module Slack
  module Mixins
    module Boolean
      
      def check
        if block_given?
          super
        else
          ::Speck::Check.new { self.nil? ? false : self }
        end
      end
      
    end
  end
end
