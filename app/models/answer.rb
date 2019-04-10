class Answer < ApplicationRecord

  # Rails guide on Associations:
  # https://guides.rubyonrails.org/association_basics.html

  # By default, 'belongs_to' will create a validation
  # such as:
  # validates :question_id, presence: true
  # It can be disabled, by passing the option
  # 'optional: true' to the belongs_to method
  # e.g. belongs_to :question, optional: true

  # In an association between two models , the model
  # that has the 'belongs_to' method call is always
  # the one whose table contains the foreign_key column
  # (i.e. question_id)
  # In this case it refers to a 'question_id' column
  # in the answers table.
    belongs_to :question
  # The following instance methods to the Answer model
  # with the line 'belongs_to :question'

  # question
  # question=(associate)
  # build_question(attributes = {})
  # create_question(attributes = {})
  # create_question!(attributes = {})
  # reload_question

  # The above are instance methods that simplify
  # interaction with the associated question. 

  # a = Answer.last

  # a.question = Question.last

  validates :body, presence: true

end
