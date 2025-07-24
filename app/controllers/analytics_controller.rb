class AnalyticsController < ApplicationController
  def popular
    top = SearchLog.group(:query)
                  .order('count_all DESC')
                  .count
                  .first(10)
    render json: top.map { |q, count| { query: q, count: count } }
  end
end