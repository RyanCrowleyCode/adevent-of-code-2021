file = File.read("day_two.csv")

def get_movement_list(rows)
    movement_list = rows.split("\n")
    movement_list = movement_list.each.map do | movement |
        movement.split(" ")
    end

    movement_list
end

movement_list = get_movement_list(file)

def multiply_position_by_depth(movement_list)
    aim = 0
    horizontal_position = 0
    depth = 0

    movement_list.each do | move |
        direction = move.first
        amount = move[1].to_i
        
        case
        when direction == "forward"
            horizontal_position += amount
            depth += aim * amount
        when direction == "up"
            aim -= amount
        when direction == "down"
            aim += amount
        end
    end

    horizontal_position * depth
end

example_list = [["forward", "5"], ["down", "5"], ["forward", "8"], ["up", "3"], ["down", "8"], ["forward", "2"]]
puts multiply_position_by_depth(movement_list)