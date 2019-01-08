Rails.application.routes.draw do
  get "/" => "pages#home"
  get "create/" => "pages#create_and_join_meeting"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
