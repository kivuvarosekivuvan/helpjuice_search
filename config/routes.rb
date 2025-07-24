
Rails.application.routes.draw do
  namespace :api do
    get  'analytics/popular', to: 'analytics#popular'
    get  'analytics/suggest', to: 'analytics#suggest'
    post 'search',             to: 'search#create'
  end
end


def suggest
  prefix = params[:q].to_s.strip.downcase
  results = SearchLog
    .where('LOWER(query) LIKE ?', "#{prefix}%")
    .group(:query)
    .order('COUNT_all DESC')
    .limit(10)
    .count

  render json: results.map { |query,count| { query: query, count: count } }
end


