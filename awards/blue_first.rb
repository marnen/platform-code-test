require 'awards/linear'

module Awards
  module BlueFirst
    include Linear.new daily_change: 1
  end
end
