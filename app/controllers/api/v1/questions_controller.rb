class Api::V1::QuestionsController < Api::ApplicationController
  before_action :authenticate_user!, only: [ :create, :update ]
  before_action :find_question, only: [ :show, :update, :destroy ]

  def index
    questions = Question.order(created_at: :desc)

    render(
      json: questions,
      # This allows us to use serializer to render
      # json of questions in this list to keep the data
      # at the minimum with need
      each_serializer: QuestionCollectionSerializer
    )
  end

  def show
    render(
      json: @question,
      # We need to do this to make sure that rails
      # includes the nested user association 
      # (which is renamed to author in the serializer) 
      # of answers.
      include: [ :author, {answers: [ :author ]} ]
    )
  end
  
  def create
    question = Question.new question_params
    question.user = current_user

    question.save!
    render json: { id: question.id , status: 201 }, status: 201
  end

      # def create
      #   question = Question.new question_params
      #   question.user = current_user

      #   if question.save
      #     render json: { id: question.id }
      #   else
      #     render(
      #       json: { errors: question.errors.messages },
      #       status: 422 # Unprocessable Entity
      #     )
      #   end
      # end
  def update
    @question.update!(question_params)
    render json: { id: @question.id}
  end

  def destroy
    @question.destroy
    render json: { status: 200 }, status: 200
  end

  private
  def find_question
    @question ||= Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
