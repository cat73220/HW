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
$candidates_json = JSON.parse(json)
$search_from_past = false

base_uri = "http://www.bookservice.jp/layout/bs/common/html/schedule/"
uri = base_uri + "comic_top.html"

ARGV.each { |opt|
  if opt == "--search_from_past"
    $search_from_past = true
    next
  end

  uri = opt if /^http:\/\/.*/ =~ opt
}

def for_a_month( uri ) 

  rawpage = open(uri)

  doc = Nokogiri::HTML.parse(rawpage, nil, "utf-8")

  nodesets = doc.css('tr')
  candidates = [[],[]]
  entry = []
  ns_i = 0
  nodesets.each do |nodeset|
    next if nodeset.nil?
    tblset = Nokogiri::HTML.parse(nodeset.inner_html, nil, "utf-8")

    thset = tblset.css('th')
    if thset.size > 0
      i = 0
      thset.each do |th|
        next if th.nil?
        $candidates_json[ns_i].each do |candidate|
          #puts "#{th.text}:#{candidate}"
          if candidate[0] == th.text.strip
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
        print i, ":[", td.text.strip, "],"
        i = i + 1
      end
       puts "\n"
=end

=begin
=end
    candidates[ns_i-1].each do |candidate|
      #puts "c=#{candidate} vs td=#{tdset.text}"
      candidate.each_pair do |k, v|
        #puts "key=#{k} value=#{v}"
        next if tdset[k].nil?
        #puts "tdset[#{k}].text=#{tdset[k].text} : v=#{v} ?=#{(/#{v}/ =~ tdset[k].text).nil?}"
        next if (tdset[k].text.strip =~ /#{v}/).nil?
        next if entry.include? tdset[3].text.strip
        puts "#{tdset[1].text.strip} #{tdset[3].text.strip} #{tdset[4].text.strip}"
        entry.push tdset[3].text.strip
      end
    end
=begin
=end

  end

end

if !$search_from_past
  for_a_month(uri)
  exit
end

# since 201202

searching = Date.new(2012, 2, 1)

# puts "#{since.year + 1} #{Date.today.year - since.year} #{Date.today.month - since.month}"

month_nr = (Date.today.year - searching.year) * 12 + (Date.today.month - searching.month)

#puts "#{month_nr}"

month = 0

while month <= month_nr

  puts "#{searching.year}" if month == 0
  puts "\n#{searching.year}" if searching.month == 1
  for_a_month( sprintf "%s%02d%02dc.html", base_uri, searching.year - 2000, searching.month )

  month = month + 1
  searching = searching.next_month
end

