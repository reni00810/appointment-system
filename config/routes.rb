Rails.application.routes.draw do
  devise_for :doctors, controllers: {
    sessions: 'doctors/doctor_devise/sessions',
    passwords: 'doctors/doctor_devise/passwords',
    registrations: 'doctors/doctor_devise/registrations'
  }
  devise_for :patients, controllers: {
    sessions: 'patients/patient_devise/sessions',
    passwords: 'patients/patient_devise/passwords',
    registrations: 'patients/patient_devise/registrations'
  }
  namespace :doctors, path: 'doctor' do
    get 'dashboard', to: 'dashboard#index'
    resources :profile, only: %i[index update]
    resources :appointments, only: %i[index show] do
      member do
        get 'confirm'
        get 'reject'
      end
    end
  end

  namespace :patients, path: 'patient' do
    get 'dashboard', to: 'dashboard#index'
    resources :profile, only: %i[index update]
    resources :appointments
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
