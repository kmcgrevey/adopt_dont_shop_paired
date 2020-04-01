class ChangeImageDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :reviews, :picture, "https://www.bigi.id/media/catalog/product/placeholder/default/default-no-image_2.png"
  end
end
