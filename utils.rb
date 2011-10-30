require 'fileutils'
#require 'ftools'
require 'iconv'
require 'zlib'

def trim(str); str.strip! || str; end

def mkdir_if_not_exist(path); FileUtils.mkdir_p(path) unless File.exist?(path); end
	
def save_string_to_file(str, p); f = File.open(p, "w");	f.puts(str); f.close; end

def utf8_to_gbk(utf8_str); Iconv.iconv('GBK', 'utf-8', utf8_str).join; end

def gbk_to_utf8(str); Iconv.iconv('utf-8', 'GBK', str).join; end

def copy_files(src_dir, dst_dir, patterns)
	patterns.each { |pattern|
		Dir.glob(File.join(src_dir, pattern)) { |name| File.copy(name, dst_dir)}
	}
end

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

def get_utf8_html(link)
  a = open(link); p "header charset: #{a.charset}"
  text = a.read; p "text encoding: #{text.encoding.to_s}"
  cs = get_charset(text); p "charset: #{cs}"
  #utf8_text = text.force_encoding(cs).encode('UTF-8')
  #html = utf8_text
  enc = a.meta['content-encoding']
  if enc == 'gzip' || enc == 'inflate'
    text = uncompress(text, enc)
  end
  html = text
  if "iso-8859-1".casecmp(cs) == 0 || "utf-8".casecmp(text.encoding.to_s) !=0
    if "utf-8".casecmp(cs) != 0
	  p 'wrong charset, change'
	  html = text.force_encoding('GBK').encode('UTF-8')
    end
  end
  html = html.force_encoding('utf-8')
  html.sub(cs, 'UTF-8')
end
