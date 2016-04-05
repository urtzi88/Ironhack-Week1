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

blog = Blog.new
blog.add_post Post.new("Post Title 1", "05/04/2016", "Post Text 1")
blog.add_post Post.new("Post Title 2", "04/04/2016", "Post Text 2")
blog.add_post Post.new("Post Title 3", "03/04/2016", "Post Text 3")
blog.publish_front_page