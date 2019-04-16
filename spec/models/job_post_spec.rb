require 'rails_helper'

# To run your tests with rspec, do:
# > rspec

# To get detailed information about running the tests, do:
# > rspec -f d
RSpec.describe JobPost, type: :model do

  # To get a list of all possible matchers for tests
  # go to:
  # https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers

  def job_post
    # @job_post ||= JobPost.new(
    #   title: "Awesome Job",
    #   description: "Some valid job description"
    # )
    @job_post ||= FactoryBot.build(:job_post)
  end
  # The "describe" is used to group related tests
  # together. It is primarily used as an organizational
  # tool. All of the grouped tests should be written
  # inside the block of the method.
  describe "validates" do
    it("requires a title") do
      # GIVEN
      # An instance of a JobPost (without a title)
      jp = job_post
      jp.title = nil

      # WHEN
      # Validations are triggered (or WHEN we attempt to save the JobPost)
      job_post.valid?

       # THEN
       # There's an error related to title in
       # the errors object.
       # The following will pass the test if the
       # errors.messages hash has a key named :title.
       # This only occurs if a 'title' validation fails.


       # Use the "expect" method instead of "assert_*"
       # to write assertions. It takes a single
       # argument which is actual value or the one to
       # be tested. We call the "to" method on the
       # object returns with a matcher to perform the
       # verification of the value.
       expect(job_post.errors.messages).to(have_key(:title))
    end

    it 'requires a unique title' do
      # GIVEN: one job post in the db and one instance
      # of job post with the same title:
      persisted_jp = FactoryBot.create(
        :job_post,
        title: "Full Stack Developer"
      )

      jp = FactoryBot.build(
        :job_post,
        title: persisted_jp.title
      )
      # WHEN
      jp.valid?
      # THEN
      expect(jp.errors.messages).to(have_key(:title))
      expect(jp.errors.messages[:title]).to(include("has already been taken"))
    end
  end

  # As per ruby docs, methods that are described with
  # a '.' are class methods. Those that are described
  # with a '#' in front are instance methods
  describe ".search" do
    it("returns only job posts containing the search term, regardless of case") do
      # GIVEN
      # 3 job posts in database
      job_post_a = FactoryBot.create(
        :job_post,
        title: "Software Engineer"
      )
      job_post_b = FactoryBot.create(
        :job_post,
        title: "Programmer"
      )
      job_post_c = FactoryBot.create(
        :job_post,
        title: "software architect"
      )
      # WHEN
      # We search for 'software'
      results = JobPost.search('software')

      # THEN
      # JobPost A & C are returned
      expect(results).to(eq([job_post_a, job_post_c]))
    end
  end

end
