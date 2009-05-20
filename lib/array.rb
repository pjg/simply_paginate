Array.class_eval do
  def paginate(options = {})
    SimplyPaginate::Collection.create(options[:page] || 1, options[:per_page] || 30, options[:total_entries] || self.length) {|pager|
      pager.replace self[pager.offset, pager.per_page].to_a
    }
  end
end
