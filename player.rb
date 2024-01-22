class Player

    attr_reader :name

    def initialize(name)
        @name=name
    end

    def guess

        puts "Type in your guess Player #{@name}"
        gets.chomp
    end
end
