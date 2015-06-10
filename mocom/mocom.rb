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
p 'text['+nodeset.text.chomp+']'
p 'innter_text['+nodeset.inner_text.chomp+']'
end
