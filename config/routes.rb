Rails.application.routes.draw do
  scope "/api" do
    namespace :v1 do
      shallow do
        resources :games do
          resources :plays
        end
      end
    end
  end
end
