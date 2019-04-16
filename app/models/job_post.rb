class JobPost < ApplicationRecord
    validates :title, presence: true, uniqueness: true

end
  