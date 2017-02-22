class GameController < ApplicationController
  def try
    #create counter variable
    @counter = cookies[:counter].to_i
    #Create and display a counter for the number of tries attempted.
    #each time we enter a guess we want to count that guess in our counter
    #if the counter is blank or our guess is blank then count the attempt
    if @counter.blank? || (params[:guess].blank?)
      @counter = 0
    elsif @counter >= 0
      @counter += 1
    end
    #generate a random secret random number
    if cookies[:secret_number].blank?
      cookies[:secret_number] = rand(1..100)
    end

    #On each call, check the secret number against the guess (the parameter).
    if cookies[:secret_number] == params[:guess]
      #if the guess equals the secret number, "you guessed the right number!"
      @result = "You guessed the right number!"
    else
      #if the guess does not equal the secret number, "Guess Again"
      @result = "Guess Again"
    end
    cookies[:counter] = @counter
    render 'try.html.erb'
  end

  def reset
    #resets the counter to 0
    cookies[:counter] = 0
    #resets to a new random number
    cookies[:secret_number] = nil
    #this will redirect the page from /new_page route to /try route
    redirect_to '/try'
  end

end #ends class


# def guess
#   render text: params[:guess].to_i #to turn the guess amount into an integer use .to_i OUTSIDE the brackets
# end
