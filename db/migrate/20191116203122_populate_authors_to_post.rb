class PopulateAuthorsToPost < ActiveRecord::Migration[5.2]
  def change
    Post.find_each do |post|
      post.author = "hfarris"
      post.save!
    end
  end
end
