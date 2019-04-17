# To generate a factory file for a model, do:
# rails g factory_bot:model job_posts


# FactoryBot.attributes_for(:job_post)
# Returns a plain hash of the parameters required to create
# a JobPost

# FactoryBot.build(:job_post)
# Returns a new un-saved instance of JobPost
# (using the factory)

# All your factories must always generate VALID instances
# of your models. ALWAYS!

FactoryBot.define do
  factory :job_post do
    sequence(:title) { |n| Faker::Job.title + " #{n}" }
    description { Faker::Job.field }
    company_name { Faker::Company.name }
    min_salary { rand(80_000..200_000) }
    max_salary { rand(170_000..400_000) }
    # The line below will create a user (using
    # a user facotry) before creating the job post.
    # Then it will associate that user to the job post.
    # This is necessary to pass the validation added by
    # 'belongs_to :user'
    association(:user, factory: :user)
    # If the factory has the same name as the
    # association, you can shorten this line to:
    # user
  end
end
