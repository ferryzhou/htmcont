require './fulltexts'

fr = FulltextRetriever.new('test_fulltexts')
#puts fr.get('http://tech.qq.com/a/20110321/000279.htm') #gb2312
#puts fr.get('http://china.huanqiu.com/roll/2011-03/1582917.html') #utf-8
#puts fr.get('test_data/readability/qq_gb2312.txt') #gb2312
#p fr.get('http://intl.ce.cn/specials/zxxx/201106/03/t20110603_22461376.shtml?') #exception in this link
#p fr.get('http://tech.jrj.com.cn/2011/06/03184010130769.shtml') #exception in this link
p fr.get(ARGV[0])
