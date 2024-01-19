class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.binary :icon_data
      t.references :user, null: false, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
  end
end
