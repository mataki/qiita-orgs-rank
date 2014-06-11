class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :organization, index: true
      t.string :name
      t.string :slug
      t.string :post_count
      t.string :stock_count

      t.timestamps
    end
  end
end
