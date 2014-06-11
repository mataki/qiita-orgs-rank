class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :slug
      t.integer :post_count
      t.integer :stock_count

      t.timestamps
    end
  end
end
