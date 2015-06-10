#!/usr/bin/ruby
# -*- coding: utf-8 -*-

#
# monitoring selling comics monthly
#

# for opening URL
require 'open-uri'

page = open("http://www.bookservice.jp/layout/bs/common/html/schedule/comic_top.html").read
p page.to_s

=begin
#
# rexml streamparseは読み込むhtmlの途中にエラーがあった時の例外処理が複雑になりそうな気配がある。
# なので、調査停止
#

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
=end
