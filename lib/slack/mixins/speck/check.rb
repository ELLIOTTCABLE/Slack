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
          old_block, @expectation = @expectation, -> { !old_block.call }
          return self
        end
        ::Speck.new Check.instance_method :! do
          ! ->{ (!::Speck::Check.new {false}).execute }
            .check_exception ::Speck::Exception::CheckFailed
          (!::Speck::Check.new {false}).check {|c| c.execute.pass? }
        end
        
      end
    end
  end
end
