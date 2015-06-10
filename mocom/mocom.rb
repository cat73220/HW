#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# coding: utf-8

#
# monitoring selling comics monthly
#

# for opening URL
require 'open-uri'

# for parsing HTML
require 'nokogiri'

uri = "http://www.bookservice.jp/layout/bs/common/html/schedule/comic_top.html"
rawpage = open(uri)

doc = Nokogiri::HTML.parse(rawpage, nil, "utf-8")

nodesets = doc.css('tr')

nodesets.each do |nodeset|
  next if nodeset.nil?
  trset = Nokogiri::HTML.parse(nodeset.inner_html, nil, "utf-8")
  tdset = trset.css('td')
  next if tdset.size <= 0
  i = 0
  tdset.each do |td|
    next if td.nil?
    print i, ":[", td.text, "],"
    i = i + 1
  end
  puts "\n"
end

