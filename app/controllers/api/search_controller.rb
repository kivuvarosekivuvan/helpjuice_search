module Api
  class SearchController < ApplicationController

    def create
      ip   = request.remote_ip
      text = params[:q].to_s.strip

      # Avoiding to log noise
      return render json: { results: [] } if text.length < 3

      # building a per‑user/session key here
      session_key = "#{ip}:#{session.id}"

      # Trying to see if there’s a “pending” log in the last 2 seconds
      recent = SearchLog
        .where(session_key: session_key)
        .where('created_at > ?', 2.seconds.ago)
        .first

      if recent
        # still typing? → update the existing record
        recent.update!(query: text)
      else
        # typing paused? → user likely “finished” this query
        SearchLog.create!(
          session_key: session_key,
          ip_address:  ip,
          query:       text
        )
      end

      # returning whatever Article.search does
      render json: { results: Article.search(text) }
    end
  end
end
