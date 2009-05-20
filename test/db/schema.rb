ActiveRecord::Schema.define(:version => 1) do
  create_table "rectangles", :force => true do |t|
    t.string "name", :limit => 30
  end
end
