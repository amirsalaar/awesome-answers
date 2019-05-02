# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

  def new
    @question = Question.new
  end

  def create
    # # The 'params' object available in controllers
    # # is composed of the query string, url params,
    # # and the body of a form
    # # (e.g. req.query + req.params + req.body)
    #
    # # A good trick to see if your routes are working
    # # and you're getting the data that you want, is to
    # # render the params as JSON. This is like doing
    # # res.send(req.body) in Express

    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      # The redirect_to method is used for telling the
      # browser to make a new request.
      # The redirect_to method is typically used with
      # with a named route helper.
      redirect_to question_path(@question.id)
    else
      render :new
    end
  end
  
  def show
    # For the form_with helper
    @answer = Answer.new
    # For the list of answers
    @answers = @question.answers.order(created_at: :desc)
    @like = @question.likes.find_by(user: current_user)

    respond_to do |format|
      format.html { render }
      format.json { render json: @question }
    end
  end

  def index
    if params[:tag].present?
      @tag = Tag.find_or_initialize_by(name: params[:tag])
      # or
      # @tag = Tag.find_by(name: params[:tag])
      @questions = @tag.questions.order(created_at: :desc)
    else
      @questions = Question.all.order(created_at: :desc)
    end
  end

  def edit
    # if !can?(:edit, @question)
    #   redirect_to root_path, alert: 'Not Authorized'
    # end
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question.id)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path
  end

  private

  def question_params
    # Use 'require' on the params object to retrieve
    # the nested hash of a key usually corresponding to
    # the name-value pairs of a form

    # Then use permit to specify all input names that
    # are allowable (as symbols).
    # params.require(:question).permit(:title, :body, tag_ids: [])
    params.require(:question).permit(:title, :body, :tag_names)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def authorize
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @question)
  end
end
