require 'slack/mixins/object'
::Object.send :include, Slack::Mixins::Object

require 'slack/mixins/boolean'
[::TrueClass, ::FalseClass, ::NilClass]
  .each {|c| c.send :include, Slack::Mixins::Boolean }

require 'slack/mixins/proc'
::Proc.send :include, Slack::Mixins::Proc

require 'slack/mixins/speck'
::Speck.send :include, Slack::Mixins::Speck

require 'slack/mixins/speck/check'
::Speck::Check.send :include, Slack::Mixins::Speck::Check
