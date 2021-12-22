################ Getting the data ##########################
file = File.read("day_eleven.csv").split("\n")

@energy_array = []

def set_energy_array(file)
    file.each do |row|
        new_row = []
        
        row.split("").each do |number_string|
            new_row.push(number_string.to_i)
        end

        @energy_array.push(new_row)
    end
end

set_energy_array(file)


################ Solving the problem ########################## 

@flashes = 0

def one_step
    increment_each_by_one
    flash
end

def increment_each_by_one
    new_array = []
    @energy_array.each do |row|
        new_row = []
        row.each do |octopus|
            new_row.push(octopus +1)
        end
        new_array.push(new_row)
    end
    @energy_array = new_array
end

def flash
    can_flash = true

    while can_flash
        can_flash = false
        @energy_array.each_with_index do |row, row_index|
            row_length = row.length
            row.each_with_index do |octopus, index|
                if octopus > 9
                    @flashes += 1
                    can_flash = true
                    @energy_array[row_index][index] = 0

                    if has_left(index)
                        if @energy_array[row_index][(index - 1)] != 0
                            @energy_array[row_index][(index - 1)] += 1
                        end
                    end
                    if has_right(index, row_length)
                        if @energy_array[row_index][(index + 1)] != 0
                            @energy_array[row_index][(index + 1)] += 1
                        end
                    end
                    if has_up(row_index)
                        if @energy_array[row_index - 1][(index)] != 0
                            @energy_array[row_index - 1][(index)] += 1
                        end
                    end
                    if has_down(row_index)
                        if @energy_array[row_index + 1][(index)] != 0
                            @energy_array[row_index + 1][(index)] += 1
                        end
                    end
                    if has_up_right(index, row_index, row_length)
                        if @energy_array[row_index - 1][(index + 1)] != 0
                            @energy_array[row_index - 1][(index + 1)] += 1
                        end
                    end
                    if has_up_left(row_index, index)
                        if @energy_array[row_index - 1][(index - 1)] != 0
                            @energy_array[row_index - 1][(index - 1)] += 1
                        end
                    end
                    if has_down_left(row_index, index)
                        if @energy_array[row_index + 1][(index - 1)] != 0
                            @energy_array[row_index + 1][(index - 1)] += 1
                        end
                    end
                    if has_down_right(index, row_index, row_length)
                        if @energy_array[row_index + 1][(index + 1)] != 0
                            @energy_array[row_index + 1][(index + 1)] += 1
                        end
                    end
                end
            end
        end
    end
end

def has_left(index)
    return index > 0
end

def has_right(index, row_length)
    return index < (row_length - 1)
end

def has_up(row_index)
    return row_index > 0
end

def has_down(row_index)
    return row_index < (@energy_array.length - 1)
end

def has_up_right(index, row_index, row_length)
    has_up(row_index) && has_right(index, row_length)
end

def has_up_left(row_index, index)
    has_up(row_index) && has_left(index)
end

def has_down_left(row_index, index)
    has_down(row_index) && has_left(index)
end

def has_down_right(index, row_index, row_length)
    has_down(row_index) && has_right(index, row_length)
end

def step_through_times(times)
    range = (1..times)

    range.each do |time|
        one_step
    end
end

################ Showing the Answer ##########################


step_through_times(100)
puts @flashes

