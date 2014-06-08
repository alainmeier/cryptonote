Cryptonote::Application.routes.draw do
  constraints subdomain: 'www' do
    get ':any', to: redirect(subdomain: nil, path: '/%{any}'), any: /.*/
  end

  root 'messages#new'

  resources :messages, only: [:show, :create, :destroy]
end
