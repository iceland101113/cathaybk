class SelectsController < ApplicationController
  def index
    @select=Select.first
  end
end
