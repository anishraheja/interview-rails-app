class CreateVersion < ActiveRecord::Migration[7.2]
  def change
    create_table :versions do |t|
      t.json :khanges, null: true
      t.references :versionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
