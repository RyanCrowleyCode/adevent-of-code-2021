################ Getting the data ##########################
file = File.read("day_six.csv").split(",")

def convert_to_int(file)
    new_file = []
    file.each do |number_string|
        new_file.push(number_string.to_i)
    end
    new_file
end

@fish_hash = Hash.new
@fish_hash["0"] = 0
@fish_hash["1"] = 0
@fish_hash["2"] = 0
@fish_hash["3"] = 0
@fish_hash["4"] = 0
@fish_hash["5"] = 0
@fish_hash["6"] = 0
@fish_hash["7"] = 0
@fish_hash["8"] = 0

def add_file_to_hash(file)
    file.each do |number_string|
        @fish_hash[number_string] += 1
    end
end

add_file_to_hash(file)
puts @fish_hash

file = convert_to_int(file)

################ Solving the problem ##########################
@fish = file.dup

def multiply_fish_for_days_hash(days)
    days.times do 
        new_fish = @fish_hash["0"]
        @fish_hash["0"] = @fish_hash["1"]
        @fish_hash["1"] = @fish_hash["2"]
        @fish_hash["2"] = @fish_hash["3"]
        @fish_hash["3"] = @fish_hash["4"]
        @fish_hash["4"] = @fish_hash["5"]
        @fish_hash["5"] = @fish_hash["6"]
        @fish_hash["6"] = @fish_hash["7"]
        @fish_hash["7"] = @fish_hash["8"]
        @fish_hash["8"] = new_fish
        @fish_hash["6"] += new_fish
    end
end

def count_fish(days)
    count = 0
    @fish.each do | fish |
       count += multiply_fish_for_days(days, fish)
    end
    count
end

def count_fish_hash
    count = 0
    @fish_hash.each_value do |value|
        count += value
    end
    count
end

################ Showing the Answer ##########################
multiply_fish_for_days_hash(256)
puts count_fish_hash