module Dashboard
  module Helpers
    def repo_map
      l = Cleaner.lookups.keys.map { |k| { Cleaner.lookups[k]['url'][1..-1] => Cleaner.lookups[k]['repo'] } }
      map = {}
      l.each do |m|
        m.each_pair do |k, v|
          map[k] = v
        end
      end

      map
    end
  end
end
