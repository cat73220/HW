#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# coding: utf-8

#
# monitoring selling comics monthly
#

# for opening URL
require 'open-uri'

page = open("http://www.bookservice.jp/layout/bs/common/html/schedule/comic_top.html", "r:utf-8").read

page.each_line { |line|
  line.chomp!
  p line
}



