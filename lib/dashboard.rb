require 'sinatra/base'
require 'sinatra/assetpack'
require 'tilt'
require 'httparty'
require 'rack/conneg'
require 'csv'
require 'dotenv'
require 'json'
require 'active_support/inflector'

require_relative 'dashboard/fetcher'
require_relative 'dashboard/cleaner'
require_relative 'dashboard/racks'
require_relative 'dashboard/assets'
require_relative 'dashboard/version'

Dotenv.load

module Dashboard
  class App < Sinatra::Base
    get '/' do
      @content = '<h1>Home Dashboard</h1>'
      @title = 'Dashboard'
      erb :index, layout: :default
    end

    get '/catface' do
      respond_to do |wants|
        headers 'Vary' => 'Accept'

        wants.html do
          @title = 'Catface'
          erb :catface, layout: :default
        end

        wants.json do
          @data = Fetcher.fetch_CSVs('pikesley/catface').to_json
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
