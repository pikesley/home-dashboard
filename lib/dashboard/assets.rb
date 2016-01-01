module Dashboard
  class App < Sinatra::Base
    set :views, 'lib/views'
    set :public_folder, 'public'

    set :sass, { :load_paths => [
      "../assets/css"
    ]}

    register Sinatra::AssetPack
    assets do
      serve '/js', from: '../assets/javascripts'
      js :app, [
        '/js/dashboard.js',
        '/js/plotly-latest.min.js'
      ]

      serve '/css', from: '../assets/css'
      css :application, [
        '/css/application.css'
      ]

      js_compression :jsmin
      css_compression :sass
    end
  end
end
