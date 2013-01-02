require 'rubygems'
require 'open-uri'
require_relative 'htmcont'

#url = 'http://www.donews.com/net/201106/490947.shtm'
#url = 'http://www.eeworld.com.cn/xfdz/2012/0112/article_9523.html'; #test absolute image source
#url = 'http://businessvalue.blog.sohu.com/250191899.html'; #test compressed file
url = 'http://tech.cn.yahoo.com/ypen/20121225/1511385.html' # failed
#url = 'http://tech.163.com/12/1225/11/8JIMS6620009387U.html'
#url = 'http://tech.ifeng.com/magazine/local/detail_2012_12/28/20623035_0.shtml'
#url = 'http://tech.sina.com.cn/i/2012-12-18/15367898820.shtml'

include Htmcont

#a = extract_with_readability(url)
a = extract_yahoo_tech(url)
p a[:content]
p a[:title]

