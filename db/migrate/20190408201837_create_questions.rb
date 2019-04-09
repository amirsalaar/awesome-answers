class CreateQuestions < ActiveRecord::Migration[5.2]
  # This fule was created when we generated the model
  # question. To generate a model do
  # rails g model <model-name> <...colum-name:type...>

  # To run all your remaining migrations do:
  # > rails db:migrate

  # To look at the status of migrations (whether or not
  # they're active or not):
  # > rails db:migrate:status

  # To reverse the last migration, do:
  # > rails db:rollback
  
  def change
    create_table :questions do |t|
      # Automatically generates an "id" column that
      # autoincrements and acts as our primary key
      t.string :title # This creates a VARCHAR(255) column "title"
      t.text :body # This creates a TEXT column named "body"


      t.timestamps
      # t.timestamps is added by default, although you
      # can remove it.
      # This will create two columns "created_at" and
      # "updated_at" which will auto_update.
      # It is recommended that you keep them.
    end
  end
end
