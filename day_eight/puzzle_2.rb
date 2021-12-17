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

def count_outputs
    count = 0
    @data_hash_array.each do |sequence_hash|
        @input_map = Hash.new
        @letter_map = Hash.new
        get_letter_map(sequence_hash["input"])

        count_string = ""
        sequence_hash["output"].each do |sequence|
            @input_map.each do |key, value|
                if value.chars.sort.join == sequence.chars.sort.join
                    count_string += key
                end
            end
        end
        count += count_string.to_i
    end
    count
end

# we need to do this for EACH ROW!! Each row is scrambled.
def find_1_4_7_or_8(input_row)
    input_row.each do |sequence|
        if sequence.length == 2
            @input_map["1"] = sequence
        elsif sequence.length == 3
            @input_map["7"] = sequence
        elsif sequence.length == 4
            @input_map["4"] = sequence
        elsif sequence.length == 7
            @input_map["8"] = sequence
        end
    end
end

def get_letter_map(input_row)
    find_1_4_7_or_8(input_row)
    
    set_top
    set_middle_and_bottom(input_row)
    # at this point we have 1, 3, 4, 7, 8
    # at this point we have top, middle, bottom
    set_top_left_and_top_right(input_row)
    # at this point we have 1, 3, 4, 5, 7, 8
    # at this point we have top, middle, bottom, top_right, top_left
    set_bottom_right(input_row)
    # at this point we have 1, 3, 4, 5, 7, 8, 9
    # at this point we have top, middle, bottom, top_right, top_left, bottom_right
    set_bottom_left
    # at this point we have 1, 3, 4, 5, 7, 8, 9
    # at this point we have EVERYTHING
    set_0
    set_2
    set_6
end

def set_top
    @input_map["7"].split("").each do |letter|
        if !@input_map["1"].include? letter
            @letter_map["top"] = letter
            break
        end
    end
end

def set_middle_and_bottom(input_row)
    input_row.each do |sequence|
        if (sequence.length == 5) && includes_all(@input_map["7"], sequence)
            @input_map["3"] = sequence

            sequence.split("").each do |letter|
                if !@input_map["7"].include? letter
                    if @input_map["4"].include? letter
                        @letter_map["middle"] = letter
                    end
                    if !@input_map["4"].include? letter
                        @letter_map["bottom"] = letter
                    end
                end
            end
        end
    end
end

def set_top_left_and_top_right(input_row)
    input_row.each do |sequence|
        if (sequence.length == 5)
            sequence.split("").each do |letter|
                if (!@input_map["3"].include? letter) && (@input_map["4"].include? letter)
                    @input_map["5"] = sequence
                    @letter_map["top_left"] = letter

                    @input_map["3"].split("").each do |letter|
                        if !sequence.include? letter
                            @letter_map["top_right"] = letter
                            break
                        end
                    end
                    break
                end
            end
        end
    end
end

def set_bottom_right(input_row)
    input_row.each do |sequence|
        if (sequence.length == 6) && (sequence.include? @letter_map["middle"]) && (includes_all(@input_map["7"], sequence))
            @input_map["9"] = sequence
            @input_map["7"].split("").each do |letter|
                if (letter != @letter_map["top_right"]) && (letter != @letter_map["top"])
                    @letter_map["bottom_right"] = letter
                    break
                end
            end
            break
        end
    end
end

def set_bottom_left
    @input_map["8"].split("").each do |letter|
        if !@input_map["9"].include? letter
            @letter_map["bottom_left"] = letter
            break
        end
    end
end

def set_0
    @input_map["0"] = @letter_map["bottom_left"]
    @input_map["0"] += @letter_map["bottom_right"]
    @input_map["0"] += @letter_map["top_left"]
    @input_map["0"] += @letter_map["top_right"]
    @input_map["0"] += @letter_map["bottom"]
    @input_map["0"] += @letter_map["top"]
end

def set_2
    @input_map["2"] = @letter_map["bottom_left"]
    @input_map["2"] += @letter_map["top_right"]
    @input_map["2"] += @letter_map["bottom"]
    @input_map["2"] += @letter_map["top"]
    @input_map["2"] += @letter_map["middle"]
end

def set_6
    @input_map["6"] = @letter_map["bottom_left"]
    @input_map["6"] += @letter_map["bottom_right"]
    @input_map["6"] += @letter_map["top_left"]
    @input_map["6"] += @letter_map["bottom"]
    @input_map["6"] += @letter_map["top"]
    @input_map["6"] += @letter_map["middle"]
end

def includes_all(all_of_this, in_that)
    all_of_this.split("").each do |letter|
        if !in_that.include? letter
            return false
        end
    end
    true
end


################ Showing the Answer ##########################
puts count_outputs

