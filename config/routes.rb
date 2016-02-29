Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
     authenticated :user do
       root 'profiles#edit', as: :authenticated_root
     end
  unauthenticated do
       root 'devise/sessions#new', as: :unauthenticated_root
     end
   end
  
  get '/resumes/leach_template_show/:id' => 'resumes#leach_template_show'
  get '/resumes/:id' => 'resumes#show'
  get '/resumes/down_load_pdf/:id' => 'resumes#down_load_pdf', as: :pdf_down_load
  get '/resumes/walsh_template_show/:id' => 'resumes#walsh_template_show'
  # root 'profiles#edit'

  match '/feedbacks',     to: 'feedbacks#new',             via: 'get'
  resources "feedbacks", only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :students
      resources :experiences
      resources :experience_details
      resources :educations
      resources :education_details
      resources :professional_skills
      resources :personal_skills
      resources :references
    end
  end

  resources :personal_informations
  resources :profiles
  resources :experiences
  resources :educations
  resources :professional_skills
  resources :personal_skills
  resources :references
  resources :users
  resources :students
  # resources :resumes
  
  # The get request below must always be last
  get '/:full_name' => 'profiles#show'
end