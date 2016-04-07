require 'date'
require 'colorize'
class Blog
	def initialize
		@container = []
	end

	def add_post(post)
		@container << post
	end

	def publish_front_page(sorted_container)
		system("clear")
		sorted_container.each do |post|
			puts post.title
			puts "*********"
			puts post.text
			puts "------------------"
		end
	end

	def pagination
		sorted_container = @container.sort {|a, b| b.date <=> a.date}
		sorted_array = sorted_container.each_slice(3).to_a
		page = 1
		pages = *(1..sorted_array.length)
		while 1
			publish_front_page(sorted_array[page - 1])
			print_page(pages, page)
			page = change_page(pages, page, sorted_array)
		end
	end

	def print_page(pages, page)
		pages.each do |x|
			if x == page
				print x.to_s.colorize(:red)
			else
				print x
			end
		end
		print "\n"
	end
	
	def change_page(pages, page, sorted_array)
		dir = gets.chomp.to_s
		if dir == "next" && page < sorted_array.length
			page += 1
		elsif dir == "prev" && page > 1
			page -= 1
		elsif pages.include?(dir.to_i)
			page = dir.to_i
		else
			page
		end
	end
end

class Post
	attr_reader :title, :date, :text
	def initialize(title, date, text)
		@title = title
		@date = date
		@text = text
	end
end

class Sponsored < Post
	def initialize(title, date, text)
		@title = "*****" + title + "*****"
		super(@title, date, text)
	end
end

blog = Blog.new
blog.add_post Post.new("Post Title 1", Date.new(2016,04,05), "Post Text 1")
blog.add_post Sponsored.new("Post Title 2", Date.new(2016,04,04), "Post Text 2")
blog.add_post Post.new("Post Title 3", Date.new(2016,04,03), "Post Text 3")
blog.add_post Post.new("Post Title 4", Date.new(2016,04,02), "Post Text 4")
blog.add_post Post.new("Post Title 5", Date.new(2016,04,01), "Post Text 5")
blog.add_post Post.new("Post Title 6", Date.new(2016,03,31), "Post Text 6")
blog.add_post Post.new("Post Title 7", Date.new(2016,03,30), "Post Text 7")
blog.add_post Post.new("Post Title 8", Date.new(2016,03,29), "Post Text 8")
blog.pagination
