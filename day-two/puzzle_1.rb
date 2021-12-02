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
    horizontal_position = 0
    depth = 0

    movement_list.each do | move |
        direction = move.first
        amount = move[1].to_i
        
        case
        when direction == "forward"
            horizontal_position += amount
        when direction == "up"
            depth -= amount
        when direction == "down"
            depth += amount
        end
    end

    horizontal_position * depth
end

puts multiply_position_by_depth(movement_list)