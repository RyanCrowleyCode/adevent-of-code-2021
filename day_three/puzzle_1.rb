file = File.read("day_three.csv")

def get_binary_data(rows)
    split_rows = rows.split("\n")
    binary_data = split_rows.map do | row |
        row.split("")
    end
    
    binary_data
end

binary_rows = get_binary_data(file)

def get_power_consumption(binary_rows)
    gamma_binary_string = ""
    epsilon_binary_string = ""
    
    max_position = binary_rows.first.size - 1

    for i in 0..max_position do
        ones = 0
        zeroes = 0

        binary_rows.each do | row |
            ones += 1 if row[i] == "1"
            zeroes += 1 if row[i] == "0"
       end
       
       if ones > zeroes
        gamma_binary_string += "1"
        epsilon_binary_string += "0"
       else
        gamma_binary_string += "0"
        epsilon_binary_string += "1"
       end
    end

    gamma_binary_string.to_i(2) * epsilon_binary_string.to_i(2)
end

puts get_power_consumption(binary_rows)