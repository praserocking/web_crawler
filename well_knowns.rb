class WellKnowns
	def initialize
		extensions = ['htm','html','php','aspx','asp','jsp','pl','axd']
		miscellaneous_links = ['/','#','javascript:void(0)']
		@exclude_links = []
		@exclude_links = extensions.map{|i| "index.#{i}"}
		@exclude_links = @exclude_links + extensions.map{|i| "default.#{i}"}
		@exclude_links = extensions.map{|i| "/index.#{i}"}
		@exclude_links = @exclude_links + extensions.map{|i| "/default.#{i}"}
		@exclude_links = @exclude_links + miscellaneous_links
	end
	def exclude_links
		@exclude_links
	end
	def prefixes
		@prefixes
	end
end
