class CreateTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :types do |t|
      t.references :user
      t.string :type_name, null: false
      t.string :colour_code, null: false
    end
  end
end
