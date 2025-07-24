class SearchLog < ApplicationRecord
    # adding this scope for recent records
    scope :recent, ->(duration) { where('created_at >= ?', Time.current - duration) }

    # Validations (if needed)
    validates :query, presence: true
    validates :ip_address, presence: true
end
