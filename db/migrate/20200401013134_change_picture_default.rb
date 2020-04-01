class ChangePictureDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :reviews, :picture, nil
  end
end
