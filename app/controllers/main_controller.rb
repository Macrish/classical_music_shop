class MainController < ApplicationController
  def welcome
    @composers = Composer.all.order(last_name: :asc)
  end

  def home; end

  def view_cart; end
end
