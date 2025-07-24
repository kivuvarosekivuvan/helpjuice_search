module Api
  class AnalyticsController < ApplicationController

    def popular
      recs = Rails.cache.fetch("popular_queries", expires_in: 5.seconds) do
        SearchLog
          .select("LOWER(query) AS query, COUNT(*) AS count")
          .group("LOWER(query)")
          .order(Arel.sql("COUNT(*) DESC"))
          .limit(10)
          .map { |r| { query: r.query, count: r.count.to_i } }
      end
      render json: recs
    end

   def suggest
      q = params[:q].to_s.strip.downcase
      return render json: [] if q.length < 2

      recs = Rails.cache.fetch("suggest_#{q}", expires_in: 20.seconds) do
        SearchLog
          .select("LOWER(query) AS query, COUNT(*) AS count")
          .where("LOWER(query) LIKE ?", "#{q}%")
          .group("LOWER(query)")
          .order(Arel.sql("COUNT(*) DESC"))
          .limit(5)
          .map { |r| { query: r.query, count: r.count.to_i } }
      end

      render json: recs
    end
  end
end
