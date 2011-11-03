require 'rubygems'
require 'open-uri'
require './readability'

#source = open("test_data/readability/qq_gb2312.txt").read
source = open('http://www.donews.com/net/201106/490947.shtm').read
a = Readability::Document.new(source)
p a.html.encoding
p a.content
