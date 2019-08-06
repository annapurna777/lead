Rails.application.routes.draw do
  get 'phone_verifications/new'
  get 'phone_verifications/create'
  get 'phone_verifications/challenge'
  get 'phone_verifications/verify'
  get 'leaders/new'
 # get 'leaders/index'
 resources :leaders ,only: [:index] do
  resources :nominees, only: [:index,:create]
 end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get 'sessions/new'
  post 'sessions/create'
  post 'leaders/create'
  get 'sessions/destroy'
  get 'admins/login'
  get 'admins/signup'
  get 'passwords/new'
  get 'passwords/new_password'
  post 'admins/create'
  post 'passwords/forgot', to: 'passwords#forgot'
  patch 'passwords/reset'
  get 'sessions/otp_verification'
  post 'sessions/otp_verify'
  post 'sessions/email_verification'
  get 'sessions/login_method'
  #post 'sessions/phone_verification'
  root 'sessions#new'
  get 'sessions/email_verify'
  patch 'leaders/make_client'
  get 'leaders/show'
  get 'leaders/clients'
  resources :phone_verifications, :only => [:new,:create] do |p|
    collection do
      get 'challenge'
      post 'verify'
      get 'success'
    end
  end
 # post 'admins/phone_verify' => "admins#phone_verify"
  post 'admins/email_verify' => "admins#email_verify"
  get 'login', to: 'sessions#new', as: 'login'
  #get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'dashboard', to: 'sessions#dashboard', as: 'dashboard'
  
  resources :admins, only: :index


end
