require 'uri'
require_relative 'well_knowns'

class Filters
	def self.exclude_invalid_links(links,url)
		constants = WellKnowns.new
		found_links = []
		outliers = []
		links.each do |link|
			if link.content =~ /\A#{URI::regexp(['http', 'https'])}\z/
				found_links << link.content
			else
				outliers << link.content
			end
		end
		found_links = found_links + self.process_outliers(outliers,constants,url)
	end
	def self.process_outliers(outliers,constants,url)
		temp = self.remove_from_root_references(outliers)
		temp = self.exclude_links_removal(temp,constants)
		temp = self.remove_hash_links(temp)
		temp = self.append_to_right_url(temp,url)
	end
	def self.remove_from_root_references(outliers)
		outliers.map{ |outlier| outlier.start_with?("./") ? outlier[2..i.length] : outlier }
	end
	def self.exclude_links_removal(outliers,constants)
		outliers.select{ |outlier| !constants.exclude_links.include?(outlier) }
	end
	def self.remove_hash_links(outliers)
		outliers.select{ |outlier| !outlier.start_with?("#")  }
	end
	def self.append_to_right_url(outliers,url)
		uri_obj = URI(url)
		outliers.map{|outlier| outlier.start_with?("/") ? "#{uri_obj.scheme}://#{uri_obj.host}#{outlier}" : "#{self.remove_file_name_in_url(url)}#{outlier}"}
	end
	def self.remove_file_name_in_url(url)
		temp = url.rpartition("/")
		if temp.last == ""
			temp.join
		else
			temp[0..temp.length-2].join
		end
	end
end
