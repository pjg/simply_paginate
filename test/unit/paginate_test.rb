require File.dirname(__FILE__) + '/../test_helper'

require File.dirname(__FILE__) + '/../fixtures/rectangle_model.rb'

class PaginateTest < Test::Unit::TestCase

  def test_array_pagination
    numbers = [1, 2, 3, 4, 5]

    assert_equal SimplyPaginate::Collection, numbers.paginate.class
    assert_equal numbers.size, numbers.paginate.total_entries

    paginated = numbers.paginate(:page => 2, :per_page => 2)
    assert_equal numbers[2..3], paginated
    assert_equal 2, paginated.offset
    assert_equal 1, paginated.previous_page
    assert_equal 3, paginated.next_page
    assert_equal 3, paginated.current_results_first
    assert_equal 4, paginated.current_results_last

    assert_equal numbers[0..1], numbers.paginate(:page => 1, :per_page => 2)
    assert_equal numbers[0..3], numbers.paginate(:page => 1, :per_page => 4)
    assert_equal numbers[3..4], numbers.paginate(:page => 2, :per_page => 3)
  end

  def test_active_record_pagination
    rectangles = Rectangle.ordered

    assert_equal rectangles[0..0], Rectangle.paginate(:page => 1, :per_page => 1, :order => 'name')
    assert_equal rectangles[0..2], Rectangle.paginate(:page => 1, :per_page => 3, :order => 'name')
    assert_equal rectangles[2..3], Rectangle.paginate(:page => 2, :per_page => 2, :order => 'name')
    assert_equal rectangles[0..3], Rectangle.paginate(:page => 1, :per_page => 4, :order => 'name')
    assert_equal rectangles[4..4], Rectangle.paginate(:page => 2, :per_page => 4, :order => 'name')

    assert_equal rectangles, Rectangle.paginate(:per_page => 100, :order => 'name')
    assert_equal rectangles, Rectangle.ordered.paginate(:per_page => 100)
  end
end
