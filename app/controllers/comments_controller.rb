class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find_by slug: params[:post_id]
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
   
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
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
     
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote was counted.'
        else
          flash[:error] = 'You can only vote on a post once.'
        end
        redirect_to :back
      end
      format.js
    end
  end

end