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

        wants.html do
          @title = Cleaner.lookups[params[:repo]]['title']
          erb :dashboard, layout: :default
        #  erb :grid, layout: :default
        end

        wants.json do
          urls = Fetcher.list_CSVs Cleaner.lookups[params[:repo]]['repo']
          urls.map { |url|
            Cleaner.sanitized_data url
          }.map { |dataset|
            {
              name: dataset['id'],
              url: "#{request.scheme}://#{request.env['HTTP_HOST']}/#{params[:repo]}/#{dataset['id']}",
              type: dataset['type']
            }
          }.to_json
        end
      end
    end

    get '/:repo/:dataset' do
      respond_to do |wants|
        headers 'Vary' => 'Accept'
        @layout = params.fetch('layout', 'default')

        wants.json do
          url = "https://api.github.com/repos/#{Cleaner.lookups[params[:repo]]['repo']}/contents/#{params[:dataset]}.csv?ref=master"
          Cleaner.sanitized_data(url).to_json
        end

        wants.csv do
          puts "WTF"
          require "pry" ; binding.pry

        end

        wants.html do
          erb :dataset, layout: @layout.to_sym
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end


end
