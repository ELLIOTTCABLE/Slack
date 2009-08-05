require 'slack/core_ext/object'
::Object.send :include, Slack::Mixins::Object

require 'slack/core_ext/proc'
::Proc.send :include, Slack::Mixins::Proc
