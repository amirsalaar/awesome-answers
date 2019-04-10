# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]

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
  end

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def edit
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
    question_params = params.require(:question).permit(:title, :body)

  end

  def find_question
    @question = Question.find(params[:id])
  end

end
