module Input_File
	def load_file
		File.new("sample_input.txt").readlines()
	end
end

class Twitter
	include Input_File
	attr_reader :info, :connections
	def initialize
		@info = {}
		@connections = {}
	end

	def retrieve_info
		self.load_file.each do |line|
			@info[line.scan(/^(.*?):/)[0][0].to_sym] = []
		end
		self.load_file.each do |line|
			line.scan(/(?<=@)\w+/).each do |ment|
				@info[line.scan(/^(.*?):/)[0][0].to_sym] << ment.to_s
			end
		end
	end

	def get_first_order_connections
		@info.each do |user|
			@connections[user[0].to_sym] = {}
			@connections[user[0].to_sym][:first] = []
			user[1].each do |x|
				if @info[x.to_sym].include?(user[0].to_s)
					@connections[user[0].to_sym][:first] << x.to_s
				end
			end
		end
	end

	def get_second_order_connections
		@connections.each do |user|
			@connections[user[0].to_sym][:second] = []
			user[1][:first].each do |sec|
				@connections[sec.to_sym][:first].each do |second|
					if user[0].to_s != second.to_s && !@connections[user[0]][:second].include?(second.to_s) && !@connections[user[0]][:first].include?(second.to_s)
						@connections[user[0].to_sym][:second] << second
					end
				end
			end
		end
	end

	def get_third_order_connections
		@connections.each do |user|
			@connections[user[0].to_sym][:third] = []
			user[1][:second].each do |sec|
				@connections[sec.to_sym][:second].each do |second|
					if user[0].to_s != second.to_s && !@connections[user[0]][:third].include?(second.to_s) && !@connections[user[0]][:second].include?(second.to_s)&& !@connections[user[0]][:first].include?(second.to_s)
						@connections[user[0].to_sym][:third] << second
					end
				end
			end
		end
	end

	def write_in_file
		File.truncate('output.txt', 0)
		open('output.txt', 'a') do |f|
			@connections.each do |name|
				f << name[0].to_s + "\n"
				@connections[name[0].to_sym].each do |level|
					if level[1] != []
						f << level[1].join(", ") + "\n"
					end
				end
				f << "\n"
			end
		end
	end
end

twitter1 = Twitter.new
twitter1.retrieve_info
twitter1.get_first_order_connections
twitter1.get_second_order_connections
twitter1.get_third_order_connections
twitter1.write_in_file
