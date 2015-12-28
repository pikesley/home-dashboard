require 'sinatra/base'
require 'sinatra/assetpack'
require 'tilt'

require_relative 'dashboard/fetcher'

module Dashboard
  class App < Sinatra::Base
    register Sinatra::AssetPack

    assets do
      serve '/js', from: 'assets/javascripts'
      js :application, [
        '/js/dashboard.js'
      ]

      serve '/css', from: 'assets/css'
      css :application, [
        '/css/styles.css'
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
end
