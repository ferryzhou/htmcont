require 'rubygems'
require 'open-uri'
require_relative 'readability'

module Htmcont

def trim_title(raw_title)
  ind = raw_title.index(/[_-]/)
  ind.nil? ? raw_title : raw_title[0...ind].strip
end

def extract_with_readability(url)
  u = open(url)
  source = u.read

  options = {:tags => %w[div p img a], :attributes => %w[src], :remove_empty_nodes => false, :url => url}
  options[:encoding] = u.charset if (u.charset && "iso-8859-1".casecmp(u.charset) != 0)

  doc = Readability::Document.new(source, options)
  
  { :content => doc.content, :title => trim_title(doc.title) }
end

# sample http://tech.cn.yahoo.com/ypen/20121225/1511385.html
# extract multiple pages if any
def extract_yahoo_tech(url)
  html = Nokogiri::HTML(open(url).read)
  title = html.css(".title").css("h1").text
  a = html.css(".text")
  a.css("span").each do |elem|
    elem.remove
  end

  {:content => a.to_html, :title => title }
end

end # Htmcont
