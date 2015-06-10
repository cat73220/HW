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
rawpage = URI.parse(uri).read

page = Nokogiri::HTML(rawpage,uri, "utf-8");

p page
