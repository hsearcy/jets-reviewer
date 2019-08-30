require 'aws-sdk-cognitoidentityprovider'

class AuthController < ApplicationController

  def register
    puts params
    resp = client.sign_up({
      client_id: ENV['COGNITO_CLIENT_ID'], # required
      secret_hash: ENV['COGNITO_CLIENT_SECRET'],
      username: params["username"], # required
      password: params["password"], # required
      user_attributes: [
        {
          name: "AttributeNameType", # required
          value: "AttributeValueType",
        },
      ],
      validation_data: [
        {
          name: "AttributeNameType", # required
          value: "AttributeValueType",
        },
      ],
      analytics_metadata: {
        analytics_endpoint_id: "StringType",
      },
      user_context_data: {
        encoded_data: "StringType",
      },
    })
  end
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

end
