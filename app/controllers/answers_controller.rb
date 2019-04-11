class AnswersController < ApplicationController
    def create
      @question = Question.find(params[:question_id])
      @answer = Answer.new answer_params
      @answer.question = @question
      if @answer.save
        # render json: params
        redirect_to question_path(@question)
      else
        # For the list of answers
        @answers = @question.answers.order(created_at: :desc)
        render 'questions/show'
      end
    end
  
    def destroy
        @answer = Answer.find(params[:id])
        @answer.destroy
        redirect_to question_path(@answer.question)
    end
        # we could also have obtained the id from the url by @question = params[:question_id] but since we want to change our routes later on it is not recommentded
    private
  
    def answer_params
      params.require(:answer).permit(:body)
    end
end
  