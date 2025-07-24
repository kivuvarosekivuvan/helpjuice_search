# lib/tasks/prune_search_logs.rake
namespace :search_logs do
  desc "Delete any SearchLog that has a newer log for the same session_key within 1 second"
  task prune_incomplete: :environment do
    batch_size = 1_000
    SearchLog.find_in_batches(batch_size: batch_size) do |batch|
      batch.each do |log|
        # does there exist a “newer” log for this same session within 1s?
        if SearchLog.where(session_key: log.session_key)
                    .where("created_at > ? AND created_at <= ?", log.created_at, log.created_at + 1.second)
                    .where.not(id: log.id)
                    .exists?
          log.destroy
        end
      end
    end
    puts "✅ Done pruning incomplete logs"
  end
end
