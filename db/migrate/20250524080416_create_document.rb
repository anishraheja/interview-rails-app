class CreateDocument < ActiveRecord::Migration[7.2]
  def change
    create_table :documents do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :author_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
