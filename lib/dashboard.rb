require 'sinatra/base'
require 'sinatra/assetpack'
require 'tilt'
require 'httparty'
require 'csv'
require 'dotenv'
require 'json'

require_relative 'dashboard/fetcher'
require_relative 'dashboard/helpers'
require_relative 'dashboard/version'

Dotenv.load

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
      @data = Fetcher.fetch_CSVs('pikesley/catface').to_json
      erb :catface, layout: :default
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
