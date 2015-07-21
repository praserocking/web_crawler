class Filehandler
	def initialize(dump_file_path)
		@dump_file = File.open(dump_file_path,'w')
	end
	def write_url(url)
		@dump_file.puts url
	end
end
