Glitter::Application.routes.draw do

  resources :users, :projects
  resource :session, only: [:new, :create, :destroy]


  get 'projects/:id/commits' => 'projects#commits'
  get 'projects/:id/commit/:tree_id' => 'projects#projectcommit'
  get 'projects/:id/masterbranch/:image_name' => 'projects#masterbranch', :image_name => /[^\/]*/
  get 'projects/:id/masterbranch/:image_name/history' => 'projects#file_history', :image_name => /[^\/]*/
  get 'glimages/:id/history' => 'glimages#history'
  get 'glimages/:id/blob/:blob_id' => 'glimages#blob'

  resources :glitterposts 

  resources :projects do
    member do
        get 'projects/:id/invite.xml' => 'projects#invite'
        get 'projects/:id/fork' => 'projects#fork'
        get 'projects/:id/forkyou' => 'projects#forkyou'
        post :file_upload
        post :file_update
    end
  end

  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy', via: :delete

  get 'dashboard/' => 'dashboard#index', :as => :dashboard

  root :to => 'sessions#new'

end
