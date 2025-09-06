Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  namespace :api do
    namespace :v1 do
      get 'hello', to: 'hello#index'
    end
  end
end



