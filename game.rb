require_relative './player.rb'

Dictionary = ''
class Game


    def initialize(name1, name2)
        @fragment = ''
        @player_1 = Player.new(name1)
        @player_2 = Player.new(name2)
        @dictionay = Dictionary
        @current_player = @player_1
    end

end
