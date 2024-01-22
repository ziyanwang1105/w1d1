require_relative './player.rb'
require 'set'

class Game
    Dictionary = File.read('dictionary.txt').split("\n").to_set
    attr_reader :fragment, :current_player, :previous_player
    def initialize(names)
        @fragment = ''
        @players = []
        names.each{|name| @players << Player.new(name)}
        @current_player = @players[0]
        @previous_player = nil
        @losses = {}
        @players.each{|player| @losses[player] = 0}
    end

    def next_player!

        @players.rotate!
        @previous_player = @current_player
        @current_player = @players[0]

    end

    def valid_play?(string)

        if !('a'..'z').include?(string)
            puts 'Please guess an alphabet from a to z'
            return false
        end
        if !Dictionary.any?{|word| word.start_with?(@fragment + string)}
            puts 'No word starts with the new guess fragment'
            return false
        end
        true

    end

    def take_turn(player)
        guess  = player.guess
        while !valid_play?(guess) && @losses[player] < 5
            guess = player.guess
            @losses[player] +=1
        end
        if @losses[player] < 5
            @fragment += guess
        end

    end

    def record(player)

        ghost = 'GHOST'
        score = @losses[player]
        ghost[0...score]
    end

    def play_round

        take_turn(@current_player)
        self.next_player!

    end


    def run

        while @losses.one?{|key, val| val < 5} || Dictionary.include?(@frament)
            self.play_round
        end


    end

end

if __FILE__ == $PROGRAM_NAME
    a = Game.new(["jerry", "tom"])
    a.run

end
