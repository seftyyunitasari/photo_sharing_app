module PostsHelper
	def action_url
		if action_name == 'new' || action_name == 'create'
			confirm_posts_path
		elsif action_name == 'edit'
			post_path
		end
	end
end
