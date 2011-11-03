require 'rubygems'
require 'open-uri'
require 'cgi'
require './readability'
require './utils'

module Htmcont
# cache the full texts
# given a link, first see whether the text has been downloaded to the local directory
# if exist, read it and return; else read the url, save and return
# 
class FulltextRetriever

def initialize(cache_dir)
	@cache_dir = cache_dir
	@html_dir = File.join(@cache_dir, 'html')
	@text_dir = File.join(@cache_dir, 'text')
	mkdir_if_not_exist(@html_dir)
	mkdir_if_not_exist(@text_dir)
end

def get(link)
	text = read_local_text(link)
	return text unless text.nil?
	text = extract(link)
	save(link, text)
	return text
end

:private
# should all record errors
# 1. html retrieving error
# 2. extraction error, link, reason
def extract(link)
	source = get_html(link)
	doc = Readability::Document.new(source, :debug=>true)#; p doc.html.encoding
	doc.content
end

def save(link, text); save_string_to_file(text, get_text_path(link)); end

def get_text_path(link); File.join(@text_dir, CGI.escape(link)); end
def get_html_path(link); File.join(@html_dir, CGI.escape(link)); end

def read_local_text(link); read_file_content(get_text_path(link)); end
def read_local_html(link); read_file_content(get_html_path(link)); end

def get_html(link)
	puts "reading local #{link} ............"
	text = read_local_html(link)
	if not text.nil? 
	  text.force_encoding('utf-8')
	  return text
	end
	puts "retrieving url #{link} ............"
	utf8_text = get_utf8_html(link)
	save_string_to_file(utf8_text, get_html_path(link))
	return utf8_text
end

def read_file_content(path); File.exist?(path) ? File.new(path, 'r').read : nil; end

end

end
