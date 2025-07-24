class AddSessionKeyToSearchLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :search_logs, :session_key, :string
    add_index :search_logs, :session_key
  end
end
