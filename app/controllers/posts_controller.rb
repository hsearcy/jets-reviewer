class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :delete]

  # GET /posts
  def index
    @posts = Post.all
    puts @posts.to_json
    render json: @posts
  end

  # GET /posts/1
  def show
    puts @post.to_json
    render json: @post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      if request.xhr?
        render json: {success: true, location: url_for("/posts/#{@post.id}")}
      else
        # redirect_to "/posts/#{@post.id}"
        render json: {success: true, location: url_for("/posts/#{@post.id}")}
      end
    else
      # render :new
    end
  end

  # PUT /posts/1
  def update
    if @post.update(post_params)
      if request.xhr?
        render json: {success: true, location: url_for("/posts/#{@post.id}")}
      else
        # redirect_to "/posts/#{@post.id}"
        render json: {success: true, location: url_for("/posts/#{@post.id}")}
      end
    else
      # render :edit
    end
  end

  # DELETE /posts/1
  def delete
    @post.destroy
    if request.xhr?
      render json: {success: true}
    else
      # redirect_to "/posts"
      render json: {success: true}
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image_source, :author)
  end
end
