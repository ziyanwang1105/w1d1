require_relative './player.rb'


class Game
    Dictionary = File.read('dictionary.txt').split("\n").to_set
    attr_reader :fragment, :current_player, :previous_player
    def initialize(names)
        @fragment = ''
        @players = []
        names.each{|name| @players << Player.new(name)}
        @current_player = @players[0]
        @previous_player = nil
    end

    def next_player!

        @players.rotate!
        @previous_player = @current_player
        @current_player = @players[0]

    end

    def valid_play?(string)

        if !('a'..'z').include?(string)
            return false
        end
        if !Dictionary.any?{|word| word.start_with?(@fragment + string)}
            return false
        end
        true

    end

    def take_turn


    end

end
