Cryptonote::Application.routes.draw do
  # Automatically removes and redirects any URL prepended with www.
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'messages#new'

  resources :messages, only: [:show, :create]

  get '/statistics' => 'static_pages#stats', as: :stats

  # Route all errors to custom layout files
  %w( 404 422 500 ).each do |code|
    get code, to: "errors#show", code: code
  end
end
