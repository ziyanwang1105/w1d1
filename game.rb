require_relative './player.rb'
require 'set'
require_relative './ai_player.rb'

class Game
    Dictionary = File.read('dictionary.txt').split("\n").to_set
    attr_reader :fragment, :current_player, :previous_player, :num_human_player
    def initialize(names)
        @fragment = ''
        @players = []
        names.each{|name| @players << Player.new(name)}
        @num_human_player = @players.length
        @players << Ai_player.new
        @current_player = @players[0]
        @previous_player = nil
        @losses = Hash.new(0)
        @players.each{|player| @losses[player] = 0}
    end

    def dictionary
        Dictionary
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
        if @losses[player] < 5
            guess  = player.guess
        end

        while !valid_play?(guess) && @losses[player] < 5
            @losses[player] +=1
            puts record(player)
            guess = player.guess
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

        until @losses.one?{|key, val| val < 5} || Dictionary.include?(@fragment)

            self.play_round
        end
        if !Dictionary.include?(@fragment)
            puts "#{@current_player} wins"
        else
            puts "#{@previous_player} wins"
        end


    end

end

if __FILE__ == $PROGRAM_NAME
    a = Game.new(["jerry", "tom"])
    a.run

end
