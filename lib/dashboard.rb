require 'sinatra/base'

class Dashboard < Sinatra::Base
  get '/' do
    @content = '<h1>Home Dashboard</h1>'
    @title = 'Dashboard'
    erb :index, layout: :default
  end

  get '/catface' do
    @title = 'Catface'
    erb :catface, layout: :default
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
