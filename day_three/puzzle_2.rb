################ Getting the data ##########################
file = File.read("day_three.csv")

def get_binary_data(rows)
    split_rows = rows.split("\n")
    binary_data = split_rows.map do | row |
        row.split("")
    end
    binary_data
end

binary_rows = get_binary_data(file)

################ Solving the problem ##########################
def get_life_support_rating(binary_rows)
    oxygen_generator_rating = get_oxygen_generator_rating(binary_rows).first.join
    c02_scrubber_rating = get_c02_scrubber_rating(binary_rows).first.join  

    oxygen_generator_rating.to_i(2) * c02_scrubber_rating.to_i(2)
end

def get_oxygen_generator_rating(binary_rows, index=0)
    return binary_rows if binary_rows.size == 1

    ones_array = []
    zeroes_array = []

    binary_rows.each do | row |
        ones_array.push(row) if row[index] == "1"
        zeroes_array.push(row) if row[index] == "0"
    end
    
    if ones_array.size >= zeroes_array.size
        return get_oxygen_generator_rating(ones_array, index + 1)
    else
        return get_oxygen_generator_rating(zeroes_array, index +1)
    end
end

def get_c02_scrubber_rating(binary_rows, index=0)
    return binary_rows if binary_rows.size == 1

    ones_array = []
    zeroes_array = []

    binary_rows.each do | row |
        ones_array.push(row) if row[index] == "1"
        zeroes_array.push(row) if row[index] == "0"
    end
    
    if zeroes_array.size <= ones_array.size
        return get_c02_scrubber_rating(zeroes_array, index + 1)
    else
        return get_c02_scrubber_rating(ones_array, index +1)
    end
end

################ Showing the Answer ##########################
puts get_life_support_rating(binary_rows)