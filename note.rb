class Note
  include DataMapper::Resource
  property :id, Serial
  property :title, Text
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end