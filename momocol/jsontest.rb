#!/usr/bin/ruby
# coding: utf-8
#
# JSON解釈検証
#
require 'json'

json_s = open("candidates.json","r:utf-8").read
json = JSON.parse(json_s)
puts "0:#{json[0]["著者"]}"
puts "1:#{json[1]["書名"]}"
