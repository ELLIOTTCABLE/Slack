require_relative '../../../speck_helper'

require 'slack/mixin_specs'

require 'slack/mixins/speck/check'
Slack::Battery[Slack][Slack::Mixins] << Speck.new(Slack, Slack::Mixins, Slack::Mixins::Speck::Check) do
  
  Speck.new Slack::Mixins::Speck::Check.instance_method(:!) do
    ! ->{ (! Speck::Check.new {false}).execute }
      .check_exception Speck::Exception::CheckFailed
    (! Speck::Check.new {false}).check {|c| c.execute.passed? }
  end
  
end
