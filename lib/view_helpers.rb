module SimplyPaginate

  # Global options for pagination helpers. You can override them on the global level
  # by putting the following into "config/initializers/simply_paginate.rb":
  #
  #   SimplyPaginate::ViewHelpers.pagination_options[:previous_label] = 'Previous page'
  #
  module ViewHelpers

    @@pagination_options = {
      :previous_label => '« Poprzednia strona',
      :next_label     => 'Następna strona »',
      :window_size    => 2, # for multi pages results, how many pages to show around current page
      :param_name     => :page
    }

    mattr_accessor :pagination_options

    # Renders pagination for a SimplyPaginate::Collection object
    def pagination_for(collection, options = {})
      # return if nothing to render
      return if collection.blank?
      return if collection.total_pages < 2

      options = options.symbolize_keys.reverse_merge SimplyPaginate::ViewHelpers.pagination_options

      # delete empty :path param so there is no empty question sign in every link
      link_params = params.symbolize_keys.delete_if {|key, value| key == :path and value.blank?}

      # window_pages are pages shown around the current page
      window_pages = {}
      window_pages[:first] = (collection.current_page - options[:window_size]) > 1 ? collection.current_page - options[:window_size] : 1
      window_pages[:last] = (collection.current_page + options[:window_size]) < collection.total_pages ? collection.current_page + options[:window_size] : collection.total_pages

      # previous page
      html = (collection.previous_page ? link_to(options[:previous_label], link_params.merge(options[:param_name] => collection.previous_page)) : content_tag(:span, options[:previous_label]))

      # first page
      html << (collection.current_page == 1 ? content_tag(:strong, collection.current_page) : link_to(1, link_params.merge(options[:param_name] => 1)))

      # window_pages prefix
      html << " … " if window_pages[:first] > 2

      # window_pages
      for i in window_pages[:first]..window_pages[:last]
        if i > 1 && i < collection.total_pages
          html << (i == collection.current_page ? content_tag(:strong, i) : link_to(i, link_params.merge(options[:param_name] => i)))
        end
      end

      # window_pages suffix
      html << " … " if window_pages[:last] < collection.total_pages - 1

      # last page
      html << (collection.total_pages == collection.current_page ? content_tag(:strong, collection.current_page) : link_to(collection.total_pages, link_params.merge(options[:param_name] => collection.total_pages)))

      # next page
      html << (collection.next_page ? link_to(options[:next_label], link_params.merge(options[:param_name] => collection.next_page)) : content_tag(:span, options[:next_label]))

      # wrap pagination in <p> tag
      content_tag(:p, html, :class => 'pagination')
    end

  end

end
