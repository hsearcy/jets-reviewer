# require 'aws-sdk-cognitoidentityprovider'
require 'openssl'
require 'base64'

class AuthController < ApplicationController
  def register
    puts params
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
    puts resp.inspect
  end


  private
  
  def create_hash(username)
    hashdata = params["username"] + ENV['COGNITO_CLIENT_ID']
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV['COGNITO_CLIENT_SECRET'], hashdata)).strip()
  end
end
