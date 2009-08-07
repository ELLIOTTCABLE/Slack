module Slack
  module Mixins
    class Speck
      class Check
        
        ##
        # This method can “invert” a `Check` object, such that it treats success
        # of the original check block (a truthy return value) as failure (a
        # false return value), and vice versa.
        # 
        # This simply wraps the existing block in a new block that calls and
        # inverts the return value.
        def !
          old_block, @block = @block, -> { !old_block.call }
          return self
        end
        Speck.new Check.instance_method :! do
          ! ->{ (!Check.new(->{false})).execute }
            .check_exception Speck::Exception::CheckFailed
          (!Check.new(->{false})).check {|c| c.execute.pass? }
        end
        
      end
    end
  end
end
