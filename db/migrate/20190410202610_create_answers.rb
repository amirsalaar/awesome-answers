class CreateAnswers < ActiveRecord::Migration[5.2]
  #  This file was generated with the command:
  # > rails g model answer body:text question:references
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, foreign_key: true

      # The above creates a 'question_id' column
      # of type 'big_int'. It also sets a foreign_key
      # constraint to enforce the association to
      # the questions table at the database level.
      # The question_id field will refer to the
      # id of a question in the questions table.
      # It is said that the answer 'belongs_to'
      # the question.

      t.timestamps
    end
  end
end
