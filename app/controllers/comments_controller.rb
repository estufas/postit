class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    #@comment.user_id = current_user
   
    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      @post.reload
      #prevents breaking if comments field is left blank
      render 'posts/show'
    end   
  end
  
  def vote
    comment = Comment.find(params[:id])
    Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted."
  end
end
