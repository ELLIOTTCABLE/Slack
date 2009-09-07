module Slack
  module Mixins
    module Speck
      module Check
        
        ##
        # This method can “invert” a `Check` object, such that it treats success
        # of the original check block (a truthy return value) as failure (a
        # false return value), and vice versa.
        # 
        # This simply wraps the existing block in a new block that calls and
        # inverts the return value.
        def !
          old_expectation, @expectation = @expectation, ->{
            b = old_expectation.arity == 0 ?
              ->{old_expectation.call} :
              ->{old_expectation[@target.call]}
            @status = b.call ? false : true
          }
          return self
        end
        
      end
    end
  end
end
