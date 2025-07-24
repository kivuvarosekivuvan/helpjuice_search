class AddLowerQueryIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :search_logs,
      "LOWER(query)",
      name: "index_search_logs_on_lower_query"
  end
end