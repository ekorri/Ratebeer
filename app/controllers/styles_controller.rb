class StylesController < ApplicationController

  def index
  	@styles = Style.all
  end

  def show
  end

  def new
  end

end