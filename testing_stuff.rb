require 'nokogiri'
require 'open-uri'

query = 'Luke Skywalker'
query.gsub!(' ','_')

url = "http://en.wikipedia.org/wiki/#{query}"

begin
	data = Nokogiri::HTML(open(url))
rescue OpenURI::HTTPError
	#do something to handle error
else
	@title = data.at_css('#firstHeading').text
	@description = data.at_css('table~p').text
	@image = data.at_css('.image img')[:src]
	@image.slice!(0,2)
end

puts url
puts @description
puts @image

