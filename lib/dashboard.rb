require 'sinatra/base'
require 'sinatra/assetpack'
require 'tilt'

class Dashboard < Sinatra::Base
  register Sinatra::AssetPack

  assets do
    js :application, [
      '/js/dashboard.js'
    ]

    css :application, [
      '/css/jqueryui.css',
      '/css/reset.css',
      '/css/foundation.css',
      '/css/app.css'
    ]

    js_compression :jsmin
    css_compression :sass
  end

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
