require 'sinatra'
require 'sinatra/reloader'

Bundler.require

#DB利用設定
#一時表示機能(セッション)
set :database, {adapter: "sqlite3", database: "registers.sqlite3"}
enable :sessions

class Register < ActiveRecord::Base
  validates_presence_of :name
end

get '/' do
  @now = Time.now
  @register = Register.all
  @message = session.delete :message
  #@message = session[:message]
  erb :index
end

get '/register_new' do
  @register = Register.new
  erb :register_new
end

post '/register_new' do
  puts ### 送信されたデータ ###
  p params

  name = params[:name]

  # DBに保存
  @register = Register.new({name: name})
  if @register.save
    #true
    session[:message] = "#{name}さんを作成しました。"
    redirect '/'
  else
    # false
    erb :register_new

  end

end