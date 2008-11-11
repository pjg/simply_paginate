module SimplyPaginate

  # SimplyPaginate::Collection is just your typical array with some extra properties required for pagination view helpers
  class Collection < Array

    attr_reader :current_page, :per_page, :total_entries, :total_pages

    def initialize(page, per_page, total_entries = nil)
      @current_page  = page.to_i
      @per_page = per_page.to_i
      self.total_entries = total_entries
    end

    # Just like 'new', but yields the object after instantiation and returns it afterwards
    def self.create(page, per_page, total_entries = nil, &block)
      pager = new(page, per_page, total_entries)
      yield pager
      pager
    end

    # Current offset of the paginated collection. If we're on the first page,
    # it is always 0. If we're on the 2nd page and there are 30 entries per page,
    # the offset is 30. This property is useful if you want to render ordinals
    # side by side with records in the view: simply start with offset + 1
    def offset
      (current_page - 1) * per_page
    end

    # current_page - 1 or nil if there is no previous page
    def previous_page
      current_page > 1 ? (current_page - 1) : nil
    end

    # current_page + 1 or nil if there is no next page
    def next_page
      current_page < total_pages ? (current_page + 1) : nil
    end

    # two helper methods to display "Currently showing results: 1 - 10"
    def current_results_first
      offset + 1
    end

    def current_results_last
      next_page ? current_page * per_page : total_entries
    end

    # sets the total_entries property and calculates total_pages
    def total_entries=(number)
      @total_entries = number.to_i
      @total_pages = (@total_entries / per_page.to_f).ceil
    end

  end

end
