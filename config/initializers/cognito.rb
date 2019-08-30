module Cognito
  def self.initialize!
    client_config =
      # if Rails.env.local? || Rails.env.development? || Rails.env.integration?
      #   {
      #     access_key_id: Rails.application.secrets.aws_access_key_id,
      #     secret_access_key: Rails.application.secrets.aws_access_key_id,
      #     region: 'us-east-1',
      #     endpoint: if Rails.env.local?
      #                 'http://dynamodb:8000'
      #               else
      #                 'http://localhost:8000'
      #       end
      #   }
      # else
        {
          region: 'us-east-1'
        }
      # end
      Aws::CognitoIdentityProvider::Client.new(client_config)
  end

  module_function

  def client
    @@client ||= initialize!
  end
end
