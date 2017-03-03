require 'rubygems'
require 'sinatra'
require 'data_mapper'
require './note.rb'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/notes.db") 
DataMapper.finalize.auto_upgrade!


get '/' do
  @notes = Note.all :order => :id.desc
  @title = 'Notebook'
  erb :home

end

post '/' do
	redirect '/add'
end

get '/add' do
  @title = 'Add Notes'
  erb :add
end


post '/add' do
  n = Note.new
  n.title = params[:title]
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
  redirect '/'
end


get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

put '/:id' do
  n = Note.get params[:id]
  n.title = params[:title]
  n.content = params[:content]
  n.updated_at = Time.now
  n.save
  redirect '/'
end


get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Confirm deletion of note ##{params[:id]}"
  erb :delete
end

delete '/:id' do
  n = Note.get params[:id]
  n.destroy
  redirect '/'
end




