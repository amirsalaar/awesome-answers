require 'rails_helper'

# To run your tests with rspec, do:
# > rspec

# To get detailed information about running the tests, do:
# > rspec -f d
RSpec.describe JobPost, type: :model do

  # The "describe" is used to group related tests
  # together. It is primarily used as an organizational
  # tool. All of the grouped tests should be written
  # inside the block of the method.
  describe "validates" do
    it("requires a title") do
      # GIVEN
      # An instance of a JobPost (without a title)
      job_post = JobPost.new

      # WHEN
      # Validations are triggered (or WHEN we attempt to save the JobPost)
      job_post.valid?

       # THEN
       # There's an error related to title in
       # the errors object.
       # The following will pass the test if the
       # errors.messages hash has a key named :title.
       # This only occurs if a 'title' validation fails.
       expect(job_post.errors.messages).to(have_key(:title))
    end

    it 'requires a unique title' do
      # GIVEN: one job post in the db and one instance
      # of job post with the same title:
      persisted_jp = JobPost.create(title: "Full Stack Developer")
      jp = JobPost.new(title: persisted_jp.title)
      # WHEN
      jp.valid?
      # THEN
      expect(jp.errors.messages).to(have_key(:title))
      expect(jp.errors.messages[:title]).to(include("has already been taken"))
      # To get a list of all possible matchers for tests
      # go to:
      # https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
    end


  end

end
