class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :details
      t.references :assignee_user, null: false,  foreign_key: { to_table: :users }
      t.references :reviewer_user, null: false,  foreign_key: { to_table: :users }
      t.references :created_by_user, null: false, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
