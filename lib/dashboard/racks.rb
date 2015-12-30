module Dashboard
  class App < Sinatra::Base

    use(Rack::Conneg) do |conneg|
      conneg.set :accept_all_extensions, false
      conneg.set :fallback, :html
      conneg.ignore('/css/')
      conneg.ignore_contents_of(File.join(File.dirname(__FILE__), '..', 'assets'))
      conneg.provide([
        :html,
        :json
      ])
    end

    before do
      if negotiated?
        content_type negotiated_type
      end
    end
  end
end
