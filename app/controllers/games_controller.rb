require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('A'...'Z').to_a
    @letters = (0...10).to_a
    @letters.map! { |_n| alphabet.sample }
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer].downcase
    @data = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{
      @answer}").read)
    @grid = @answer.upcase.chars.all? { |char| @answer.upcase.count(char) <= @letters.count(char) }
  end
end
