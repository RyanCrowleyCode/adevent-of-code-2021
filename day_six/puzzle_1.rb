################ Getting the data ##########################
file = File.read("example.csv").split(",")

def convert_to_int(file)
    new_file = []
    file.each do |number_string|
        new_file.push(number_string.to_i)
    end
    new_file
end

file = convert_to_int(file)

################ Solving the problem ##########################
@fish = file.dup

def multiply_fish_for_days(days)
    (days).times do
        mutiply_fish_one_day
    end
end

def mutiply_fish_one_day
    new_fish = []
    eights = 0
    @fish.each do | timer |
        if timer > 0
            new_fish.push(timer -1)
        else
            new_fish.push(6)
            eights += 1
        end
    end
    (eights).times do
        new_fish.push(8)
    end
    @fish = new_fish
end

def count_fish
    @fish.length
end

################ Showing the Answer ##########################
multiply_fish_for_days(80)
puts count_fish