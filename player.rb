class Player

    attr_reader :name

    def initialize(name)
        @name=name
    end

    def guess

        puts "Type in your guess Player #{@name}"
        gets.chomp.downcase

    end

end

if __FILE__ == $PROGRAM_NAME
   a = Player.new("Jerry")
   puts a
   a.guess
end
