################ Getting the data ##########################
file = File.read("example.csv").split(",")

def convert_to_int(file)
    numbers = []
    file.each do |number|
        numbers.push(number.to_i)
    end
    numbers
end

file = convert_to_int(file)

################ Solving the problem ########################## 

def get_average(list)
    (list.reduce(:+).to_f / list.size)
end

def calculate_fuel(list)
    average = get_average(list)
    fuel_cost_floor = 0
    fuel_cost_ceil = 0

    list.each do |position|
        floor_gap = (position - average.floor).abs
        ceil_gap = (position - average.ceil).abs

        fuel_cost_floor += calculate_incrementing_fuel(floor_gap)
        fuel_cost_ceil += calculate_incrementing_fuel(ceil_gap)
    end
    [fuel_cost_floor, fuel_cost_ceil].min
end

def calculate_incrementing_fuel(number)
    fuel = 0
    i = number
    while i > 0 
        fuel += i
        i -= 1
    end
    fuel
end


################ Showing the Answer ##########################
puts calculate_fuel(file)
