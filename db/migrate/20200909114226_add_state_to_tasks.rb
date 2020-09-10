class AddStateToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :state, :string, default: 'open'
  end
end
