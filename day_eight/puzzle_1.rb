################ Getting the data ##########################
file = File.read("day_eight.csv").split("\n")

@data_hash_array = []

def create_data_hash_array(file)
    file.each do |row|
        split_row = row.split(" | ")
        data_hash = {}
        input_array = split_row.first.split(" ")
        output_array = split_row[1].split(" ")

        data_hash["input"] = input_array
        data_hash["output"] = output_array
        @data_hash_array.push(data_hash)
    end
end

create_data_hash_array(file)

################ Solving the problem ########################## 

digits_hash = {
    "2": [1],
    "3": [7],
    "4": [4],
    "5": [3, 5],
    "6": [0, 6, 9],
    "7": [8]
}

def find_1_4_7_or_8
    count = 0
    @data_hash_array.each do |row_hash|
        row_hash["output"].each do |sequence|
            if unique_length(sequence)
                count += 1
            end
        end
    end
    count
end

def unique_length(sequence)
    unique_lengths = [2, 3, 4, 7]
    return true if unique_lengths.include? sequence.length
    false
end

################ Showing the Answer ##########################

puts find_1_4_7_or_8