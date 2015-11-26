Rails.application.routes.draw do

  get 'casos-de-exito' => 'static_pages#casos', as: 'casos'

  get 'contacto' => 'static_pages#contacto', as: 'contacto'
 
  get 'distribuidores' => 'static_pages#distribuidores', as: 'distribuidores'

  get 'comprar' => 'static_pages#comprar', as: 'comprar'
  post 'locate_me' => 'static_pages#locate_me'
  root 'static_pages#landing'

  #Mail
  # => Post mail...
  post '/enviar_contacto' => 'static_pages#enviar_contacto', as: 'enviar_contacto'
  post '/enviar_distribuidor' => 'static_pages#enviar_distribuidor', as: 'enviar_distribuidor'


  #Admin
  get 'admin' => 'admin#index'
  scope 'admin', path_names: { new: 'nuevo', edit: 'editar' } do

    devise_for :users, :controllers => {:sessions => "sessions"} , path: "auth", path_names: { sign_in: 'login', sign_out: 'logout' }

    get 'contacto' => 'admin#contact', as: 'contact'
    patch 'contacto' => 'admin#contact'
    delete 'contacto' => 'admin#pref_del'


    resources :users, path: 'usuarios', except: :show
    resources :cases, path: 'casos-de-exito'
    resources :dealers, path: 'distribuidores', except: :show

  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
