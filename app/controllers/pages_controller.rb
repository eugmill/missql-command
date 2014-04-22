class PagesController < ApplicationController
  before_action :authorize
  before_action :set_levels

  def index
  	render :about
  end

  def about
  end

end