require 'array'
require 'collection'
require 'finder'
require 'view_helpers'

ActiveRecord::Base.send :include, SimplyPaginate::Finder
ActionView::Base.send :include, SimplyPaginate::ViewHelpers
