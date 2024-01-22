require_relative './game.rb'

class Ai_player

    def initialize
        @fragment = Game.fragment
        @num_human_player = Game.num_human_player
    end



    def guess

        ('a'..'z')[rand(0...26)]
    end
end

if __FILE__ == $PROGRAM_NAME


end
