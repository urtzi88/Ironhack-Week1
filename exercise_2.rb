require 'date'
class Blog
	def initialize
		@container = []
	end
	def add_post(post)
		@container << post
	end
	def publish_front_page
		sorted_container = @container.sort {|a, b| b.date <=> a.date}
		sorted_container.each do |post|
			puts post.title
			puts "*********"
			puts post.text
			puts "------------------"
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
blog.publish_front_page