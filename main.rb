require_relative 'crawler'

print 'Enter starting URL for crawler: '
url = gets.chomp
print '\nEnter the No. of iterations to break (0 to run forever): '
count = gets.chomp.to_i

a = Crawler.new(url,count)
a.crawl
