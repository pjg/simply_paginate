class Rectangle < ActiveRecord::Base
  named_scope :ordered, :order => 'name'
end
