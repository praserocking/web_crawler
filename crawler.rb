require 'open-uri'
require 'nokogiri'
require 'uri'
require 'set'
require 'openssl'
require_relative 'file_handler'
require_relative 'filters'

class Crawler
	def initialize(url,count = 0)
		@dump_file = Filehandler.new("dump_data/#{URI(url).hostname}.txt")
		@visited_links = []
		@url = url
		@count = count
		@links = Set.new
	end
	def crawl
		while true
			
			break if @count != 0 and @visited_links.length == @count
			
			begin
				doc = Nokogiri::HTML(open(@url, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
			rescue => e
				puts "Something wrong!"
				puts e.message
				break
			end 
			
			links = doc.xpath("//a/@href")
			
			valid_links = Filters.exclude_invalid_links(links,@url)
			
			@links.merge(valid_links)
			puts @links.to_a
			
			@visited_links << @url
			@url = @links.first
			@links.delete(@url)
			
			while @visited_links.include? @url
				@url = @links.first
				@links.delete(@url)
			end
		end
		@links.merge(@visited_links).each do |i|
			@dump_file.write_url(i)
		end
	end
end
