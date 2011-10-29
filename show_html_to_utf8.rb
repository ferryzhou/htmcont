require 'open-uri'
require 'zlib'

a = open(ARGV[0])
p a.charset
p a.meta

def get_charset(text)
  charset_str = 'charset='
  ind = text.index(charset_str)
  if ind.nil?; return 'iso-8859-1'; end
  start = ind + charset_str.length#; p start.to_s
  ind2 = text.index('"', start)#; p ind2.to_s
  if ind2 == start #start with "
    ind3 = text.index('"', start+1);
    return text[(ind2+1)...ind3]
  else
    return text[start...ind2]
  end
end

def uncompress(string, encoding)
      case encoding
        when 'gzip'
          i=Zlib::GzipReader.new(StringIO.new(string))
          content=i.read
        when 'deflate'
          i=Zlib::Inflate.new
          content=i.inflate(string)
        else
          raise "Unknown encoding - #{encoding}"
      end
end

text = a.read

enc = a.meta['content-encoding']
if enc == 'gzip' || enc == 'inflate'
  text = uncompress(text, enc)
end
#p text
p get_charset(text)
