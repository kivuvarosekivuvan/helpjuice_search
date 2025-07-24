class SearchLoggerService
  DEBOUNCE_WINDOW = 0.5 # seconds

  def initialize(ip, raw_query)
    @ip = ip
    @query = raw_query.strip
  end

  def log!
    return if @query.empty?

    # Avoiding duplicates: only log if different from last within window
    recent = SearchLog.where(ip_address: @ip).recent(DEBOUNCE_WINDOW)
    last = recent.order(created_at: :desc).first

    if last.nil? || last.query != @query
      SearchLog.create!(ip_address: @ip, query: @query)
    end
  end
end