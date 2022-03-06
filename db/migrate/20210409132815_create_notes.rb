class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :user
      t.string :title, null:false
      t.text :content, null: false
      t.integer :thread_id, null: false
      t.integer :position, null: false
      t.datetime :last_edit, null: false
      t.belongs_to :reference
      t.belongs_to :type
    end

    create_table :notes_tags, id: false do |t|
      t.belongs_to :note
      t.belongs_to :tag
    end

    create_table :branch_links do |t|
      t.integer :note_id
      t.integer :link_to
    end

    add_index :branch_links, :link_to
    add_index :branch_links, :note_id

  end
end
