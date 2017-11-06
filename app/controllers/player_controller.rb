require 'open-uri'
require 'json'


class PlayerController < ApplicationController


  def game
    @start_time = Time.now
    @grid = generate_grid(9)

  end

  def score
    end_time = Time.now
    @attempt = params[:query]
    @result = run_game(@attempt, params[:grid], Time.parse(params[:start_time]), end_time)
  end

  private

def data_extract(attempt)
  url = 'https://wagon-dictionary.herokuapp.com/' + attempt
  info = open(url).read
  rubinfo = JSON.parse(info)
end

def generate_grid(grid_size)
  # TODO: generate random grid of letters
  grid = []
  for i in (0...grid_size)
    grid[i] = [*'A'..'Z'].sample
  end
  return grid
end

def run_game(attempt, grid, start_time, end_time)
  # TODO: runs the game and return detailed hash of result
  rubinfo = data_extract(attempt)
  if rubinfo['found'] == true
    msg = "Yo, well done!"
    full_score = 1 / (end_time - start_time) + attempt.size
  else
    msg = "Hey, that's not an english word"
    full_score = 0
  end
  a = attempt.upcase.chars.all? { |x| grid.count(x) >= attempt.upcase.chars.count(x) }
  if a == false
    msg = "Hey, it's not in the grid"
    full_score = 0
  end
  return result = { attempt: attempt,
                      score: full_score,
                       time: end_time - start_time,
                    message: msg }
end


end


