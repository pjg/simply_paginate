require File.dirname(__FILE__) + '/../test_helper'
require 'action_controller'
require 'action_controller/test_process'

require File.dirname(__FILE__) + '/../fixtures/rectangle_model.rb'
require File.dirname(__FILE__) + '/../fixtures/rectangles_controller.rb'

class UsersControllerTest < ActionController::TestCase

  include SimplyAuthenticate::Helpers

  def setup
    @controller = RectanglesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new

    ActionController::Routing::Routes.draw do |map|
      map.root :controller => 'rectangles'
    end
  end

  # test pagination links on second page of paginated results
  def test_pagination_for
    get :index
    assert_response :success
    assert_select 'p.pagination'
    assert_select 'p.pagination a', :text => /«/
    assert_select 'p.pagination a', :text => /»/
    assert_select 'p.pagination a', :text => /1/
    assert_select 'p.pagination a', :text => /3/
    assert_select 'p.pagination strong', :text => /2/
  end

end
