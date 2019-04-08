Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  post('/contacts', { to: 'contact#create' })
  get('/contacts/new', { to: 'contact#new' })

  # this defines a `route` rule that says when we recieve a `GET` request with 
  # URL `/`, handle it using the `WelcomeController` with `index` action 
  # inside that controller
  # the `as` option is used for helper url/path, it overrides or generates
  # helper method that you can use in your views or controllers
  get('/', { to: 'welcome#index', as: 'root' })

end
