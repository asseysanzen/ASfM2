class Users::CommentsController < ApplicationController

  before_action :authenticate_user!

	def create
   		@post = Post.find(params[:post_id])
   		@comment = Comment.new(comment_params)
   		@comment.user_id = current_user.id
   		@comment.post_id = @post.id
  		unless @comment.save
    		#redirect_back(fallback_location: root_path)
  		#else
  			render :show
  		end
 	end

	def destroy
   		@comment = Comment.find(params[:id])
      @post = @comment.post
   		@comment.destroy
   		#redirect_back(fallback_location: root_path)
 	end

	private

 	def comment_params
 		params.require(:comment).permit(:post_comment)
 	end

end
