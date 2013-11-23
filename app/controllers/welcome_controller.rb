class WelcomeController < ApplicationController
  def index
    @businesses = Business.all
  end

  def about
  end

  def contact
  end
end
