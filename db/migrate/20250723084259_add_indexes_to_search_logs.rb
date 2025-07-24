class AddIndexesToSearchLogs < ActiveRecord::Migration[6.1]
  def change
    add_index :search_logs, [:session_key, :created_at]
    add_index :search_logs, :query
  end
end
