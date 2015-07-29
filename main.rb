require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite:./db/base.db')

class Credit
  include DataMapper::Resource

  property :id,         Serial
  property :sum,        Float
  property :month,      Integer
  property :perc,       Float
  property :standart,   Boolean
  property :created_at, DateTime

end

DataMapper.finalize
DataMapper.auto_upgrade!

# if needs we can see all credits requests
get '/credits' do
  @credits = Credit.all
  erb :'index'
end

get '/' do 
  erb :'new'
end

post '/' do
  params.delete 'submit'
  @credit = Credit.create(params)
  redirect "/credits/#{@credit.id}"
end

get '/credits/:id' do
  @credit = Credit.get(params[:id])
  erb :'show'
end