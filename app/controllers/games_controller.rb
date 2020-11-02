require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @alphabet = ('a'..'z').to_a.sample(10)
  end

  def score
    @attempt = params[:answer]
    @grid = params[:grid]
    serialized_words = open("https://wagon-dictionary.herokuapp.com/#{@attempt}").read
    result = JSON.parse(serialized_words)
    gridcounter = Hash.new(0)
    attemptcounter = Hash.new(0)
    @grid.chars.each { |word| gridcounter[word] += 1 }
    @attempt.chars.each { |word| attemptcounter[word] += 1 }

    gridcounter.each do |key, _value|
      gridcounter.delete(key) unless attemptcounter.key?(key)
    end
    @grid_ok = gridcounter.values.sum >= attemptcounter.values.sum
    @word_ok = result['found']

    # raise
    # if @grid_ok && @word_ok
    #   @first = "Congratulations! "
    #   @second = " is a valid English word!"
    # elsif !@grid_ok
    #   @first = "Sorry but "
    #   @second = " can't be build out of #{@grid.chars.join(', ')} "
    # elsif !@word_ok
    #   @first = "Sorry but "
    #   @second = "does not seem to be an english word"
    # end
  end
end
