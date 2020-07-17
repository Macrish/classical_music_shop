class MainController < ApplicationController
  def welcome
    @composers = Composer.all.order(last_name: :asc)
  end
end
