class AddUserRefToTimeCards < ActiveRecord::Migration[7.0]
  def change
    add_reference :time_cards, :user, null: false, foreign_key: true
  end
end
