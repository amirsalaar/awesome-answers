class JobPost < ApplicationRecord
    validates :title, presence: true, uniqueness: true

    def self.search(search_term)
        where("title ILIKE ?", "%#{search_term}%")
    end
    
end
  