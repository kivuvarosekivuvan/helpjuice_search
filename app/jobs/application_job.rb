class AggregateSearchStatsJob < ApplicationJob
  queue_as :default

  def perform
    # e.g., summarizing logs into a Summary table
  end
end
