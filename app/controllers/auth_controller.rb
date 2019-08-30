require 'aws-sdk-cognitoidentityprovider'
require 'openssl'
require 'base64'

class AuthController < ApplicationController
  def register
    client = Aws::CognitoIdentityProvider::Client.new(region: "us-east-1");
    puts params
    hashdata = params["username"] + ENV['COGNITO_CLIENT_ID']
    resp = client.sign_up({
      client_id: ENV['COGNITO_CLIENT_ID'], # required
      secret_hash: Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV['COGNITO_CLIENT_SECRET'], hashdata)).strip(),
      username: params["username"], # required
      password: params["password"], # required
      user_attributes: [
        {
          name: "email", # required
          value: params["email"],
        },
      ]
    });
    puts resp.inspect
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
