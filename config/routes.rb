Rails.application.routes.draw do
  namespace :api do
    get 'search_address' => 'addresses#search', defaults: { format: :json }
  end
end
