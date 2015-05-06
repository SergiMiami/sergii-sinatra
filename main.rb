#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require './song'

configure do
  puts "===== Process is starting with pid: #{Process.pid}. Run stop.rb to gracefully stop. ====="
  puts "===== Environment is <<#{Sinatra::Base.environment}>> ====="
  File.open('pid.txt', 'w') {|f| f.write Process.pid }
  #DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end

get('/styles.css') { scss :styles}

get '/' do
  slim :home
end

get '/about' do
  @title = "All About This Website"
  slim :about
end

get '/contact' do
  slim :contact
end

get '/login' do
  slim :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/songs')
  else
    slim :login
  end
end

get '/logout' do
  session.clear
  redirect to('/login')
end

not_found {slim :not_found}



