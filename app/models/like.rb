class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :question_id, uniqueness: { scope: :user_id }

  # id | question_id | user_id
  # 1  | 20          | 3    <- Valid
  # 2  | 13          | 9    <- Valid
  # 3  | 33          | 10   <- Valid
  # 4  | 33          | 11   <- Valid
  # 5  | 32          | 11   <- Valid
  # 6  | 33          | 11   <- Invalid
  # 7  | 20          | 3    <- Invalid

end
