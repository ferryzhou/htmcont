require 'open-uri'
require './utils'

a = open(ARGV[0])
p a.charset
p a.meta

text = a.read

enc = a.meta['content-encoding']
if enc == 'gzip' || enc == 'inflate'
  text = uncompress(text, enc)
end
#p text
p get_charset(text)
