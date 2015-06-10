#!/usr/bin/ruby

#
# monitoring selling comics monthly
#

# for opening URL
require 'open-uri'

# for parsing html
require 'rexml/parsers/baseparser'
require 'rexml/parsers/streamparser'
require 'rexml/streamlistener'

class Listener
  include REXML::StreamListener

  def initialize
    @events = []
  end

  def text(text)
    @events << "text[#{text}]"
  end

  def tag_start(name, attrs)
    @events << "tag_start[#{name}]"
  end

  attr_reader :events
end

listner = Listener.new

page = open("http://www.bookservice.jp/layout/bs/common/html/schedule/comic_top.html").read

REXML::Parsers::StreamParser.new( page.to_s, listner ).parse
listner.events
