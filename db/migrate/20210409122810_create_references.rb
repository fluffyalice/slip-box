class CreateReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :references do |t|
      t.references :user
      t.string :author, null: false
      t.string :title, null: false
      t.integer :year
      t.string :url
      t.text :info
    end
  end
end
