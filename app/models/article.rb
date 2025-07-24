class Article < ApplicationRecord
  # trying a very simple SQL search
  def self.search(term)
    where("title ILIKE :q OR body ILIKE :q", q: "%#{term}%")
  end
end
