require 'sinatra/base'
require 'sinatra/assetpack'
require 'tilt'
require 'sass'
require 'httparty'
require 'rack/conneg'
require 'csv'
require 'dotenv'
require 'json'
require 'redis'
require 'active_support/inflector'

require_relative 'dashboard/fetcher'
require_relative 'dashboard/cleaner'
require_relative 'dashboard/assets'
require_relative 'dashboard/helpers'
require_relative 'dashboard/racks'
require_relative 'dashboard/version'

Dotenv.load

module Dashboard
  class App < Sinatra::Base
    set :views, 'lib/views'

    helpers do
      include Dashboard::Helpers
    end

    get '/' do
      @content = '<h1>Home Dashboard</h1>'
      title = 'Dashboard'
      erb :index, layout: :default
    end

    get '/:repo' do
      respond_to do |wants|
        headers 'Vary' => 'Accept'

        repo = repo_map[params[:repo]]

        wants.html do
          @title = 'Catface'
          erb :grid, layout: :default
        end

        wants.json do
          urls = Fetcher.list_CSVs(repo_map[params[:repo]])
          urls.map { |url| Cleaner.sanitized_data url }.to_json
        end
      end
    end

    get '/:repo/:dataset' do
      respond_to do |wants|
        headers 'Vary' => 'Accept'

        wants.json do
          Cleaner.sanitized_data("https://api.github.com/repos/#{Cleaner.lookups[params[:repo]]['repo']}/contents/#{params[:dataset]}.csv?ref=master").to_json
        end

        wants.html do
          erb :dataset, layout: :default
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end


end
