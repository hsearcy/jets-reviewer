# require 'aws-sdk-cognitoidentityprovider'
require 'openssl'
require 'base64'
require 'jwt'

class AuthController < ApplicationController
  def register
    begin
      resp = Cognito.client.sign_up({
        client_id: ENV['COGNITO_CLIENT_ID'],
        secret_hash: create_hash(params["username"]),
        username: params["username"],
        password: params["password"],
        user_attributes: [
          {
            name: "email",
            value: params["email"],
          },
        ]
      });
      render json: {success: true, data: { email: params["email"]}}
    rescue => exception
      render json: {status: "error", message: exception.message, code: 500}, status: 500
    end
  end

  def login
    begin
      resp = Cognito.client.admin_initiate_auth({
        user_pool_id: ENV["COGNITO_USER_POOL"],
        client_id: ENV['COGNITO_CLIENT_ID'],
        auth_flow: "ADMIN_NO_SRP_AUTH",
        auth_parameters: {
          "USERNAME" => params["username"],
          "PASSWORD" => params["password"],
          "SECRET_HASH" => create_hash(params["username"])
        }
      })
      if (valid_token?(params["username"], resp.authentication_result.id_token))
        render json: {success: true, token: resp.authentication_result.access_token, user: params["username"]}
      else
        throw "ah!"
      end
    rescue => exception
      puts exception.inspect
      render json: {status: "error", message: exception.message, code: 500}, status: 500
    end
  end

  private
  
  def create_hash(username)
    hashdata = params["username"] + ENV['COGNITO_CLIENT_ID']
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV['COGNITO_CLIENT_SECRET'], hashdata)).strip()
  end

  def valid_token?(username, token) 
    decoded = JWT.decode token, nil, false
    decoded = decoded[0]
    decoded["cognito:username"] == username && decoded["exp"] > Time.now.to_i
  end
end
