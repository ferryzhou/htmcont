require 'rubygems'
require 'open-uri'
require './readability'

#source = open("test_data/readability/qq_gb2312.txt").read
#source = open('http://www.donews.com/net/201106/490947.shtm').read
url = 'http://www.eeworld.com.cn/xfdz/2012/0112/article_9523.html'; #test absolute image source
source = open(url).read
a = Readability::Document.new(source, :page_url => url)
p a.html.encoding
p a.content
