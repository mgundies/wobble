Rails.application.routes.draw do
  # get 'facilities/new' => 'facilties#new'
    root :to => 'pages#welcome'
  # get "/facilities/:id/rosterstart/:rosterstart" => "facilities#rosterstart", :as => :roster_path
    get '/signup' => 'users#new'
    get '/login' => 'session#new'
    post '/login' => 'session#create'
    delete '/login' => 'session#destroy'
    # get '/users/edit' => 'users#edit'
    # get '/facilities/roster' => 'facilities#roster'
  get '/journals/:id/edit' => 'journals#edit'

  post '/' => 'pages#create'
  post 'facilities/setdate'
  resources :users
  resources :journals
  resources :facilities
  resources :session
  resources :shifts
  resources :pages


end


# Prefix Verb   URI     Pattern                    Controller#Action
#          root GET    /                              pages#welcome
#        signup GET    /signup(.:format)              users#new
#         login GET    /login(.:format)               session#new
#               POST   /login(.:format)               session#create
#               DELETE /login(.:format)               session#destroy
#         users GET    /users(.:format)               users#index
#               POST   /users(.:format)               users#create
#      new_user GET    /users/new(.:format)           users#new
#     edit_user GET    /users/:id/edit(.:format)      users#edit
#          user GET    /users/:id(.:format)           users#show
#               PATCH  /users/:id(.:format)           users#update
#               PUT    /users/:id(.:format)           users#update
#               DELETE /users/:id(.:format)           users#destroy
#      journals GET    /journals(.:format)            journals#index
#               POST   /journals(.:format)            journals#create
#   new_journal GET    /journals/new(.:format)        journals#new
#  edit_journal GET    /journals/:id/edit(.:format)   journals#edit
#       journal GET    /journals/:id(.:format)        journals#show
#               PATCH  /journals/:id(.:format)        journals#update
#               PUT    /journals/:id(.:format)        journals#update
#               DELETE /journals/:id(.:format)        journals#destroy

#    facilities GET    /facilities(.:format)          facilities#index
#               POST   /facilities(.:format)          facilities#create
#  new_facility GET    /facilities/new(.:format)      facilities#new
# edit_facility GET    /facilities/:id/edit(.:format) facilities#edit
#      facility GET    /facilities/:id(.:format)      facilities#show
#               PATCH  /facilities/:id(.:format)      facilities#update
#               PUT    /facilities/:id(.:format)      facilities#update
#               DELETE /facilities/:id(.:format)      facilities#destroy

# session_index GET    /session(.:format)             session#index
#               POST   /session(.:format)             session#create
#   new_session GET    /session/new(.:format)         session#new
#  edit_session GET    /session/:id/edit(.:format)    session#edit
#       session GET    /session/:id(.:format)         session#show
#               PATCH  /session/:id(.:format)         session#update
#               PUT    /session/:id(.:format)         session#update
#               DELETE /session/:id(.:format)         session#destroy
#        shifts GET    /shifts(.:format)              shifts#index
#               POST   /shifts(.:format)              shifts#create
#     new_shift GET    /shifts/new(.:format)          shifts#new
#    edit_shift GET    /shifts/:id/edit(.:format)     shifts#edit
#         shift GET    /shifts/:id(.:format)          shifts#show
#               PATCH  /shifts/:id(.:format)          shifts#update
#               PUT    /shifts/:id(.:format)          shifts#update
              # DELETE /shifts/:id(.:format)          shifts#destroy
              # get '/planets/:id/edit' => 'planets#edit', :as => 'planet_edit'\
              # match "/facilities/:year/:month/:day" :as => :post_date
              # get "facilities/(:date)" => "facilities#index",
              #     :constraints => { :date => /\d{4}-\d{2}-\d{2}/ },
              #     :as => "events_date"]]

              #      facility GET    /facilities/:id(.:format)      facilities#show
            # match 'facilities/:id/:rosterdate' => 'facilities#show', :via => [:get], :as => 'get_seo'
