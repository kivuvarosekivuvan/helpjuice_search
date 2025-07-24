class SearchController < ApplicationController
  def create
    raw_query = params[:q].to_s
    ip = request.remote_ip

    # Log search (service is handling filtering)
    SearchLoggerService.new(ip, raw_query).log!

    # For now, return placeholder results
    results = Article.where('title ILIKE ?', "%\#{raw_query}%").limit(10)
    render json: { results: results }
  end
end