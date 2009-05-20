module SimplyPaginate

  # A mixin for ActiveRecord::Base. Provides paginating finder
  module Finder

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # This is the paginating finder. Important input parameters:
      #   :page     - current page (defaults to 1)
      #   :per_page - number of results to display per page (defaults to 10)
      def paginate(options = {})

        # current page
        page = options[:page].blank? ? 1 : options[:page]

        # number of results to show per page
        per_page = options[:per_page].blank? ? 10 : options[:per_page]

        # total entries
        total_entries = count(:conditions => options[:conditions])

        # paginating finder
        SimplyPaginate::Collection.create(page, per_page, total_entries) do |pager|
          pager.replace find(:all,
                             :select => options[:select],
                             :joins => options[:joins],
                             :include => options[:include],
                             :conditions => options[:conditions],
                             :order => options[:order],
                             :offset => pager.offset,
                             :limit => per_page)
        end
      end
    end

  end

end
