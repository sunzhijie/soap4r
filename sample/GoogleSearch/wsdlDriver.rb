require 'uconv'
require 'soap/wsdlDriver'

searchWord = ARGV.shift
# You must get key from http://www.google.com/apis/ to use Google Web APIs.
key = File.open(File.expand_path("~/.google_key")).read.chomp

GOOGLE_WSDL = 'http://api.google.com/GoogleSearch.wsdl'
#GOOGLE_WSDL = 'GoogleSearch.wsdl'

def html2rd(str)
  str.gsub(%r(<b>(.*?)</b>), '((*\\1*))').strip
end


google = SOAP::WSDLDriverFactory.new(GOOGLE_WSDL).createDriver
#google.setWireDumpDev(STDERR)
result = google.doGoogleSearch( key, searchWord, 0, 10, false, "", false, "",
  'utf-8', 'utf-8' )
result.resultElements.each do |ele|
  puts "== #{html2rd(ele.title)}: #{ele.URL}"
  puts html2rd(ele.snippet)
  puts
end
