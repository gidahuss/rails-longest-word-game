Rails.application.routes.draw do

  root to: 'player#game'


  get 'player/game'

  get 'player/score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
