class IdeasController < ApplicationController

  def index
    @top_ideas = Idea.joins(:likes).group("ideas.id").order("count(likes.id) desc")
    @all_ideas = Idea.all

  end

  def show
    @idea = Idea.find(params[:id])
    @likes = Idea.find(params[:id]).likes
  end

  def create
    @idea = Idea.create(idea_params)
      if @idea.valid?
        redirect_to '/bright_ideas'
      else
        flash[:errors] = @idea.errors.full_messages
        redirect_to '/bright_ideas'
      end
    end

  def destroy
    idea = Idea.find(params[:id])
    idea.destroy
    redirect_to '/bright_ideas'
  end

  def like
  @like = Like.create(like_params)
    if @like.valid?
      flash[:notice] = ['Idea liked']
      redirect_to '/bright_ideas'
    else
      flash[:errors] = @like.errors.full_messages
      redirect_to '/bright_ideas'
    end
  end

  private
  def idea_params
    params.require(:idea).permit(:content, :user_id)
  end

  def like_params
    params.require(:like).permit(:user_id, :idea_id)
  end

end
