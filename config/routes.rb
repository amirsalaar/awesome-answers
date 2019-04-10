Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources method will generate all CRUD routes
  # following RESTful conventions for a resource.
  # It will assume there is a controller named after
  # the first argument pluralized and PascalCased
  # (i.e. :question => QuestionsController )
  resources :questions do
    # Routes written inside of a block passed
    # to a 'resources' method will be pre-fixed
    # by a path corresponding to the passed in symbol.
    # In this case all nested routes will be
    # prefixed with '/questions/:question_id/'
    resources :answers, only: [:create, :destroy]

  end
  # get('/questions/new', to: 'questions#new', as: :new_question)
  # post('/questions', to: 'questions#create', as: :questions)
  # get('/questions/:id', to: 'questions#show', as: :question)
  # # question_path(<id>), question_url(<id>)
  # get('/questions/:id/edit', to: 'questions#edit', as: :edit_question)
  # # edit_question_path(<id>), edit_question_url(<id>)
  # patch("/questions/:id", to: "questions#update")
  # delete('/questions/:id', to: 'questions#destroy')
  # get('/questions', to: 'questions#index')

  post('/contacts', { to: 'contact#create' })
  get('/contacts/new', { to: 'contact#new' })

  # this defines a `route` rule that says when we recieve a `GET` request with
  # URL `/`, handle it using the `WelcomeController` with `index` action
  # inside that controller
  # the `as` option is used for helper url/path, it overrides or generates
  # helper method that you can use in your views or controllers
  get('/', { to: 'welcome#index', as: 'root' })

end
