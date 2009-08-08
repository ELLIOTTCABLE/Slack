require 'speck'

require 'slack/mixins'

##
# Methods in `Slack` are provided with the purpose of making it simpler (and
# sexier!) to create `Speck::Check`s.
module Slack
  Version = 0
  
  
end

class Speck
  class Exception < StandardError
    # Raised any time checks are defined by Slack methods outside of a `Speck`
    NoEnvironment = Class.new self
  end
end
