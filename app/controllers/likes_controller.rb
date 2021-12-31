class LikesController < ApplicationController
	skip_before_action :login_required, only: [:create, :destroy]
	def create
		like = current_user.likes.create(post_id: params[:post_id])
		redirect_to posts_path
	end
	def destroy
		like = current_user.likes.find_by(id: params[:id]).destroy
		redirect_to posts_path
	end
	def index
		@likes = current_user.likes
	end
end
