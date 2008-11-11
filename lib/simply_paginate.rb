require 'collection'
require 'view_helpers'
require 'finder'

ActiveRecord::Base.send :include, SimplyPaginate::Finder
ActionView::Base.send :include, SimplyPaginate::ViewHelpers
