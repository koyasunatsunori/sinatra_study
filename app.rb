require 'sinatra'
require 'sinatra/reloader'

Bundler.require

get '/' do
  @now = Time.now
  #"今の時刻: #{now}"
  erb :index
end

get '/register_new' do
  erb :register_new
end

post '/register_new' do
  puts ### 送信されたデータ ###
  p params

  # DBに保存
  redirect '/'
end