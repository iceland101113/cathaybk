class CathaybkController < ApplicationController
  def index
    @select = Select.first
  end

  def basic
    @select = Select.first
  end
end
