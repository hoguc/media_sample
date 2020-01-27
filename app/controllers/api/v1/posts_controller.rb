class Api::V1::PostsController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    @posts = Post.all
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  def show
    @post = Post.find(params[:id])
    render 'show', formats: [:json], handlers: [:jbuilder]
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      head :create
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.fetch(:post, {}).permit(
      :title, :content, :image
    )
  end
end
