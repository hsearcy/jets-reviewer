class AddImgSrcToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :image_source, :string
  end
end
