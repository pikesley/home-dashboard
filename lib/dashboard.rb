require 'sinatra/base'
require 'sinatra/assetpack'
require 'tilt'
require 'sass'
require 'httparty'
require 'rack/conneg'
require 'csv'
require 'dotenv'
require 'json'
require 'active_support/inflector'

require_relative 'dashboard/fetcher'
require_relative 'dashboard/cleaner'
require_relative 'dashboard/assets'
require_relative 'dashboard/racks'
require_relative 'dashboard/version'

Dotenv.load

module Dashboard
  class App < Sinatra::Base
    set :views, 'lib/views'
    set :sass, { :load_paths => [ "#{App.root}/../assets/css" ] }

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
          erb :grid, layout: :default
        end

        wants.json do
          urls = Fetcher.list_CSVs('pikesley/catface')
          urls.map { |url| Cleaner.sanitized_data url }.to_json
        end
      end
    end

    get '/snake' do
      respond_to do |wants|
        headers 'Vary' => 'Accept'

        wants.html do
          @title = 'Snake'
          erb :grid, layout: :default
        end

        wants.json do
          urls = Fetcher.list_CSVs('pikesley/snake-data')
          urls.map { |url| Cleaner.sanitized_data url }.to_json
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
end
