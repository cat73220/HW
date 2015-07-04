#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

#
# monitoring monthly comics list
#

# for opening URL
require 'open-uri'

# for parsing HTML
require 'nokogiri'

# for parsing the candidates list
require 'json'

json = open("candidates.json", "r:utf-8").read
candidates_json = JSON.parse(json)

uri = "http://www.bookservice.jp/layout/bs/common/html/schedule/comic_top.html"

ARGV.each { |opt|
  uri = opt if /^http:\/\/.*/ =~ opt
}

rawpage = open(uri)

doc = Nokogiri::HTML.parse(rawpage, nil, "utf-8")

nodesets = doc.css('tr')
candidates = [[],[]]
ns_i = 0
nodesets.each do |nodeset|
  next if nodeset.nil?
  tblset = Nokogiri::HTML.parse(nodeset.inner_html, nil, "utf-8")

  thset = tblset.css('th')
  if thset.size > 0
    i = 0
    thset.each do |th|
      next if th.nil?
      candidates_json[ns_i].each do |candidate|
        #puts "#{th.text}:#{candidate}"
        if candidate[0] == th.text
          candidates[ns_i].push i => candidate[1]
        end
      end
      #print i, ":[", th.text, "],"
      i = i + 1
    end
    #puts "\n"
    #p candidates[ns_i]
    ns_i = ns_i + 1
  end

  tdset = tblset.css('td')
  next if tdset.size <= 0

=begin
  i = 0
  tdset.each do |td|
    next if td.nil?
    print i, ":[", td.text, "],"
    i = i + 1
  end
  puts "\n"
=end

  candidates[ns_i-1].each do |candidate|
    #puts "c=#{candidate} vs td=#{tdset.text}"
    candidate.each_pair do |k, v|
      #puts "key=#{k} value=#{v}"
      next if tdset[k].nil?
      #puts "tdset[#{k}].text=#{tdset[k].text} : v=#{v} ?=#{(/#{v}/ =~ tdset[k].text).nil?}"
      next if (tdset[k].text =~ /#{v}/).nil?
      puts "#{tdset[1].text} #{tdset[3].text} #{tdset[4].text}"
    end
  end

end

