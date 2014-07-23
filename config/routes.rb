Bbbtesting::Application.routes.draw do
  
  devise_for :users

  resources :homes

  bigbluebutton_routes :default, :controllers => {
    :servers => 'custom_bigbluebutton_servers',
    :rooms => 'custom_bigbluebutton_rooms',
    :recordings => 'custom_bigbluebutton_recordings'
  }
  
 #root :to => 'bigbluebutton/rooms#index'
 
  root :to => 'homes#index'
#  FIXME: Temporary, this should probably be done by bigbluebutton_rails
#  match '/webconf/:id', :to => 'custom_bigbluebutton_rooms#invite_userid', :as => "join_webconf"
end