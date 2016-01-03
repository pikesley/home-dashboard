module Dashboard
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, '..', "assets") }
    set :views, 'lib/views'

#   register Sinatra::AssetPack
#    assets do
#      serve '/js', from: '../assets/javascripts'
#      js :app, [
#        '/javascripts/dashboard.js'
#      ]
#
#      js_compression :jsmin
#    end
  end
end
