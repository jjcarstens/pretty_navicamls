Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "listings#index"
  resources :listings do
    member do
      put "update_status/:status" => "listings#update_status", :as => "update_status"
    end
  end
end
