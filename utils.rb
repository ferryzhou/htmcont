require 'fileutils'
require 'ftools'
require 'iconv'

def trim(str); str.strip! || str; end

def mkdir_if_not_exist(path); FileUtils.mkdir_p(path) unless File.exist?(path); end
	
def save_string_to_file(str, p); f = File.open(p, "w");	f.puts(str); f.close; end

def utf8_to_gb2312(utf8_str); Iconv.iconv('GBK', 'utf-8', utf8_str).join; end

def gb2312_to_utf8(str); Iconv.iconv('utf-8', 'GBK', str).join; end

def copy_files(src_dir, dst_dir, patterns)
	patterns.each { |pattern|
		Dir.glob(File.join(src_dir, pattern)) { |name| File.copy(name, dst_dir)}
	}
end
