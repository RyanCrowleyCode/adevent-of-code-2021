################ Getting the data ##########################
file = File.read("day_nine.csv").split("\n")

@height_array = []

def set_height_array(file)
    file.each do |row|
        new_row = []
        
        row.split("").each do |number_string|
            new_row.push(number_string.to_i)
        end

        @height_array.push(new_row)
    end
end

set_height_array(file)

################ Solving the problem ########################## 

# determine if has_left, has_right, has_up, has_down
# for each that it has, if it is less than all of those, it is a low point
# add this number to a low_points array

def sum_risk_levels
    low_points_array = []
    count = 0

    @height_array.each_with_index do |row, row_index|
        row.each_with_index do |height, height_index|
            is_low = true

            if has_left(height_index)
                if row[height_index - 1] <= height
                    is_low = false
                end
            end
            if has_right(height_index, row.length)
                if row[height_index + 1] <= height
                    is_low = false
                end
            end
            if has_up(row_index)
                if @height_array[row_index - 1][height_index] <= height
                    is_low = false
                end
            end
            if has_down(row_index)
                if @height_array[row_index + 1][height_index] <= height
                    is_low = false
                end
            end

            if is_low
                low_points_array.push(height)
            end
        end
    end

    low_points_array.each do |low_point|
        count += low_point
    end

    count + low_points_array.length
end

# risk level = 1 + height of the point
# so, 1 0 5 5 would be 2 1 6 6 
# we want to sum the risk levels of all of the low points.
# so, sum all the numbers in the low points array + length of the array

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
    return row_index < (@height_array.length - 1)
end

################ Showing the Answer ##########################

puts sum_risk_levels
