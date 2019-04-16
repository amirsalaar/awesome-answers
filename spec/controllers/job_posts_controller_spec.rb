require 'rails_helper'

RSpec.describe JobPostsController, type: :controller do
  describe "#new" do
    it "renders a new template" do
      # GIVEN
      # Defaults

      # WHEN
      # Making a GET request to the new action

      # When testing controllers, use methods named after
      # HTTP verbs (e.g. get, post, patch, put, delete) to
      # simulate HTTP requests to your controller actions
      # Example:
      get(:new) # Simulates a GET to JobPostsController's new action

      # THEN
      # The `response` contains the rendered template of `new`

      # The `response` object is available inside any controller
      # test. `flash` & `session` objects are also available inside
      # of your controller tests.
      expect(response).to(render_template(:new))
    end

    it "sets an instance variable of a new job post" do
      get(:new)

      # assigns(:job_post)
      # Returns the value of the instance variable named
      # after the symbol argument (e.g. :job_post -> @job_post)
      # Only available with the gem "rails-controller-testing"

      expect(assigns(:job_post)).to(be_a_new(JobPost))
      # The above match will verify that the expected value is
      # a new instance of the JobPost model
    end
  end

  describe "#create" do
    # `context` is functionally the same as `describe`, but we
    # use it in its stead to separate branching code.
    context "with valid parameters" do
      it "creates a new job post" do
        # GIVEN
        # Zero JobPost in the db
        count_before = JobPost.count

        # WHEN
        # We make a post to create with valid job post params
        post(:create, params: { job_post: FactoryBot.attributes_for(:job_post) })

        # THEN
        # There is one more Job Post in the db
        count_after = JobPost.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the show page of that post" do
        post(:create, params: { job_post: FactoryBot.attributes_for(:job_post) })

        job_post = JobPost.last
        expect(response).to(redirect_to(job_post_url(job_post.id)))
      end
    end

    context "with invalid parameters" do
        def invalid_request
          post(
            :create,
            params: {
              job_post: FactoryBot.attributes_for(:job_post, title: nil)
            }
          )
        end
  
        it "doesn't create a job post" do
          count_before = JobPost.count
          invalid_request
          count_after = JobPost.count
  
          expect(count_after).to(eq(count_before))
        end
  
        it "renders the new template" do
            invalid_request
    
            expect(response).to(render_template(:new))
        end

        it "assigns an invalid job post as an instance var." do
            invalid_request
    
            expect(assigns(:job_post)).to(be_a(JobPost))
            # be_a checks that the expected value is instance
            # of the given class
            expect(assigns(:job_post).valid?).to(be(false))
        end
    end

    describe "#show" do
        it "renders the show template" do
          # GIVEN
          # A job post in the db
          job_post = FactoryBot.create(:job_post)
          
          # WHEN
          # A GET to /posts/:id
          get(:show, params: { id: job_post.id })
          
          # THEN
          # The response contains the rendered show template
          expect(response).to(render_template(:show))
        end
        
        it "assigns an instance var. for the shown job post" do
          job_post = FactoryBot.create(:job_post)
    
          get(:show, params: { id: job_post.id })
    
          expect(assigns(:job_post)).to eq(job_post)
        end
      end  
  end
end
