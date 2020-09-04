require 'awards/linear'

module Awards
  module Normal
    include Linear.new daily_change: -1
  end
end
