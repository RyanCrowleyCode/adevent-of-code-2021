################ Getting the data ##########################
file = File.read("day_seven.csv").split(",")

def convert_to_int(file)
    numbers = []
    file.each do |number|
        numbers.push(number.to_i)
    end
    numbers
end

file = convert_to_int(file).sort
################ Solving the problem ########################## 

def get_middle(list)
    middle = list.length/2
    list[middle]
end

def calculate_fuel(list)
    middle = get_middle(list)
    fuel_cost = 0

    list.each do |position|
        fuel_cost += (position - middle).abs
    end
    fuel_cost
end


################ Showing the Answer ##########################
puts calculate_fuel(file)