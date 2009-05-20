class RectanglesController < ApplicationController
  # clear all filters defined in application.rb
  skip_filter filter_chain

  # second page of paginated results
  def index
    @rectangles = Rectangle.paginate(:per_page => 2, :page => 2)
    render :inline => "<%= pagination_for @rectangles %>", :layout => false
  end
end
