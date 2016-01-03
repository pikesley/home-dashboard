module Dashboard
  class App < Sinatra::Base
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, '..', "assets") }
    set :views, 'lib/views'
  end
end
