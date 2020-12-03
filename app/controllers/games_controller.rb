require "open-uri"

class GamesController < ApplicationController
# new will display a new random grid and a form
# submit via post to score
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end
# show the score
  def score
    @guess = params[:answer].upcase
    @letters = params[:letters].upcase
    # User won if word is english AND word's letters included in grid
    @win = false
    if included?(@guess, @letters) && english_word?(@guess)
      @win = true
    end
  end

  private

  # Verifies that guess' letters are included in letters
  def included?(guess, letters)
    guess.chars.all? { |letter| guess.count(letter) <= letters.count(letter) }
  end

  # Checks that word is in the dictionnary
  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
