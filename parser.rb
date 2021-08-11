#!/usr/bin/env ruby
require_relative 'lib/webserver_log_parser'

WebserverLogParser.load
WebserverLogParser.run(ARGV)
