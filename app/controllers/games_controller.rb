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
    answer = params[:answer].downcase
    data = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{
      answer}").read)

    if data['found'] && answer.upcase.chars.all? { |char| answer.upcase.count(char) <= @letters.count(char) }
      @response = "Well done! #{answer.upcase} is a valid word!"
    elsif data['found'] == false
      @response = "Sorry. #{answer.upcase} is not an English word"
    else
      @response = "#{answer.upcase} cannot be built from #{@letters}"
    end
    @response
  end
end
