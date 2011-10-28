require 'open-uri'

a = open(ARGV[0])
p a.charset
