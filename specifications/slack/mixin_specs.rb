require_relative '../speck_helper'

require 'slack_specs'

require 'slack/mixins'
Slack::Battery[Slack] << Speck.new(Slack::Mixins)
