class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      # Add an index to columns that you query often
      # It will improve the performance of that query
      # significantly as it grows in size.

      # An index achieves this by creating an
      # ordered list  that gives the database
      # a faster way to search for certain values in that column.
      # As an analogy, think of using an index in a
      # book vs. just flipping through pages. 

      t.string :password_digest

      t.timestamps
    end
    # If you needed to add an index to an existing
    # table:
    # add_index :users, :email, unqiue: true
  end
end
