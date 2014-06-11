QiitaOrgsRank::Application.routes.draw do
  root to: "organizations#index"

  resources :organizations do
    resources :members
  end
end
