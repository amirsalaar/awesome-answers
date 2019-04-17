require 'rails_helper'

# To get more detailed from rspec use the format option:
# rspec -f d

RSpec.describe JobPostsController, type: :controller do

  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  describe "#new" do
    context "without signed in user" do
      it "redirects the user to session new" do
        get(:new)
        expect(response).to redirect_to(new_session_path)
      end
      it "sets a danger flash message" do
        get :new
        expect(flash[:danger]).to be
      end
    end

    context "with signed in user" do
      # Use 'before' to tun a block of code before
      # all tests inside of a block. In this case,
      # the following block will be run before the
      # two tests inside this context's block.
      before do
        # sign in current_user
        session[:user_id] = current_user.id
      end

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
end


  describe "#create" do
    def valid_request
      post(:create, params: { job_post: FactoryBot.attributes_for(:job_post) })
    end

    context "without signed in user" do
      it "redirects to the new session path" do
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end
    context "with signed in user" do
      before do
        session[:user_id] = current_user.id
      end
      # `context` is functionally the same as `describe`, but we
      # use it in its stead to separate branching code.
      context "with valid parameters" do
        it "creates a new job post" do
          # GIVEN
          # Zero JobPost in the db
          count_before = JobPost.count

          # WHEN
          # We make a post to create with valid job post params
          valid_request

          # THEN
          # There is one more Job Post in the db
          count_after = JobPost.count
          expect(count_after).to eq(count_before + 1)
        end

        it "redirects to the show page of that post" do
          valid_request

          job_post = JobPost.last
          expect(response).to(redirect_to(job_post_url(job_post.id)))
        end

        it "associates the current user to the created job post" do
          valid_request
          job_post = JobPost.last
          expect(job_post.user).to eq(current_user)
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

  describe "#destroy" do
      context "without a signed in user" do
          it "redirects to the new session path" do
              job_post = FactoryBot.create(:job_post)
              delete(:destroy, params: {id: job_post.id})
              expect(response).to redirect_to new_session_path
          end
          
      end

      context "with a signed in user" do
        before do
            session[:user_id] = current_user.id
        end

        context "as non-owner" do
            it "doesnt remove the job post" do
                job_post = FactoryBot.create(:job_post)
                delete(:destroy, params: {id: job_post.id})
                expect(JobPost.find_by(id: job_post.id)).to eq((job_post)) 
            end

            it "redirects to the job post show" do
                job_post = FactoryBot.create(:job_post)
                delete(:destroy, params: { id: job_post.id })
                expect(response).to redirect_to job_post_path(job_post.id)
            end
            
            it "flashes a danger message" do
                job_post = FactoryBot.create(:job_post)
                delete(:destroy, params: { id: job_post.id })
                expect(flash[:danger]).to be
            end
            
        end
        
        context "as owner" do
            it "removes a job post from the db" do
                job_post = FactoryBot.create(:job_post, user: current_user)
                delete(:destroy, params: { id: job_post.id })
                expect(JobPost.find_by(id: job_post.id)).to be(nil)
            end

            it "redirects to the home page" do
                job_post = FactoryBot.create(:job_post, user: current_user)
                delete(:destroy, params: { id: job_post.id })
                expect(response).to redirect_to(root_url)
            end
        end
      end
  end
  
end
