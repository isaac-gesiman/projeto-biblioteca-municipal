Rails.application.routes.draw do
  get "home/index"
  get "/login", to: "sessoes#new", as: :login
  post "/login", to: "sessoes#create"
  delete "/logout", to: "sessoes#destroy", as: :logout

  get "/nova-senha", to: "bibliotecarios#nova_senha", as: :nova_senha
  patch "/nova-senha", to: "bibliotecarios#atualizar_senha"

  get "/painel", to: "bibliotecarios#painel", as: :painel_bibliotecario
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/esqueci-senha", to: "recuperacoes_senha#new", as: :esqueci_senha
  post "/esqueci-senha", to: "recuperacoes_senha#create"

  get "/redefinir-senha/:token", to: "recuperacoes_senha#edit", as: :redefinir_senha
  patch "/redefinir-senha/:token", to: "recuperacoes_senha#update"

  get "/usuario/login", to: "sessoes_usuarios#new", as: :login_usuario
  post "/usuario/login", to: "sessoes_usuarios#create"
  delete "/usuario/logout", to: "sessoes_usuarios#destroy", as: :logout_usuario

  get "/usuario/nova-senha", to: "usuarios#nova_senha", as: :nova_senha_usuario
  patch "/usuario/nova-senha", to: "usuarios#atualizar_senha"

  get "/usuario/painel", to: "usuarios#painel", as: :painel_usuario

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
 root "home#index"

  resources :usuarios, only: [:new, :create]
  resources :bibliotecarios, only: [:new, :create]
  resources :categorias, only: [:new, :create]
  resources :livros, only: [:new, :create]
  resources :emprestimos, only: [:index, :new, :create] do
  member do
    patch :devolver
  end
end
  patch "/emprestimos/:id/renovar",
        to: "emprestimos#renovar",
        as: :renovar_emprestimo
end
