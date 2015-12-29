module Dashboard
  class App < Sinatra::Base
    set :views, 'lib/views'

    register Sinatra::AssetPack
    assets do
      serve '/js', from: '../assets/javascripts'
      js :application, [
        '/js/dashboard.js'
      ]

      serve '/css', from: '../assets/css'
      css :application, [
        '/css/styles.css'
      ]

      js_compression :jsmin
      css_compression :sass
    end
  end
end
