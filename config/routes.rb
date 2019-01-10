Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "pages#home"
  post "create/" => "pages#create_and_join_meeting"
  post "deleteRecording/" => "recordings#delete_recording"
end
