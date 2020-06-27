class Users::CommentsController < ApplicationController

  #管理者がコメントを削除できるようにbefore_action :authenticate_user!は無し

	def create
   		@post = Post.find(params[:post_id])
   		@comment = Comment.new(comment_params)
   		@comment.user_id = current_user.id
   		@comment.post_id = @post.id
  		unless @comment.save
  			render :show
  		end
 	end

	def destroy
   		@comment = Comment.find(params[:id])
      @post = @comment.post
   		@comment.destroy
 	end

	private

 	def comment_params
 		params.require(:comment).permit(:post_comment)
 	end

end
