class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.belongs_to :organization, index: true
      t.string :name
      t.string :slug
      t.integer :post_count
      t.integer :stock_count

      t.timestamps
    end
  end
end
