require_relative 'speck_helper'

require 'slack'
Slack::Battery = Speck::Battery.new

Slack::Battery << Speck.new(Slack)
