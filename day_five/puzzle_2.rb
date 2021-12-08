################ Getting the data ##########################
file = File.read("day_five.csv")

# example_coordinates = [
#     {"x1"=>0, "y1"=>9, "x2"=>5, "y2"=>9},
#     {"x1"=>8, "y1"=>0, "x2"=>0, "y2"=>8},
#     {"x1"=>9, "y1"=>4, "x2"=>3, "y2"=>4},
#     {"x1"=>2, "y1"=>2, "x2"=>2, "y2"=>1},
#     {"x1"=>7, "y1"=>0, "x2"=>7, "y2"=>4},
#     {"x1"=>6, "y1"=>4, "x2"=>2, "y2"=>0},
#     {"x1"=>0, "y1"=>9, "x2"=>2, "y2"=>9},
#     {"x1"=>3, "y1"=>4, "x2"=>1, "y2"=>4},
#     {"x1"=>0, "y1"=>0, "x2"=>8, "y2"=>8},
#     {"x1"=>5, "y1"=>5, "x2"=>8, "y2"=>2}
# ]

# example_tracker = {
#     "0,0": 2,
#     "0,1": 0,
#     "0,2": 1
# }

def parse_file(file)
    file_array = file.split("\n")
    coordinates_array = divide_start_and_finish(file_array)
    @coordinates = get_coordinates(coordinates_array)
end

def divide_start_and_finish(file_array)
    coordinates_array = []
    file_array.each do | line |
        coordinates_array.push(line.split(" -> "))
    end
    coordinates_array
end

def get_coordinates(coordinates_array)
    coordinates = []
    coordinates_array.each do | row |
        coordinates_hash = Hash.new
        starting = row.first.split(",")
        ending = row[1].split(",")

        coordinates_hash["x1"] = starting[0].to_i
        coordinates_hash["y1"] = starting[1].to_i
        coordinates_hash["x2"] = ending[0].to_i
        coordinates_hash["y2"] = ending[1].to_i

        coordinates.push(coordinates_hash)
    end
    coordinates
end

parse_file(file)

################ Solving the problem ##########################
def count_overlap(coordinates_array)
    @tracker = Hash.new
    overlap_two_or_more = 0

    coordinates_array.each do | coordinates |
        if coordinates["x1"] == coordinates["x2"]
            track_vertical_line(coordinates)
        elsif coordinates["y1"] == coordinates["y2"]
            track_horizontal_line(coordinates)
        else
            track_diagonal_line(coordinates)
        end
    end
    
    @tracker.each_value do |value|
        overlap_two_or_more += 1 if value >= 2
    end
    overlap_two_or_more 
end

def track_vertical_line(coordinates)
    path = []
    min = [coordinates["y1"], coordinates["y2"]].min
    if min == coordinates["y1"]
        path = generate_verticle_path_array(coordinates, "increasing")
    else
        path = generate_verticle_path_array(coordinates, "decreasing")
    end
    path.each do | coordinate |
        set_or_increment_tracker(coordinate)
    end
end

def generate_verticle_path_array(coordinates, direction)
    path = []

    if direction == "increasing"
        y_start = coordinates["y1"]
        y_end = coordinates["y2"]
    else
        y_start = coordinates["y2"]
        y_end = coordinates["y1"]
    end

    while y_start <= y_end
        coordinate = "#{coordinates["x1"]},#{y_start}"
        path.push(coordinate)
        y_start += 1
    end
    path
end

def track_horizontal_line(coordinates)
    path = []
    min = [coordinates["x1"], coordinates["x2"]].min
    if min == coordinates["x1"]
        path = generate_horizontal_path_array(coordinates, "increasing")
    else
        path = generate_horizontal_path_array(coordinates, "decreasing")
    end
    path.each do | coordinate |
        set_or_increment_tracker(coordinate)
    end
end

def generate_horizontal_path_array(coordinates, direction)
    path = []

    if direction == "increasing"
        x_start = coordinates["x1"]
        x_end = coordinates["x2"]
    else
        x_start = coordinates["x2"]
        x_end = coordinates["x1"]
    end

    while x_start <= x_end
        coordinate = "#{x_start},#{coordinates["y1"]}"
        path.push(coordinate)
        x_start += 1
    end
    path
end

def track_diagonal_line(coordinates)
    path = []
    min_x = [coordinates["x1"], coordinates["x2"]].min
    min_y = [coordinates["y1"], coordinates["y2"]].min

    if min_x == coordinates["x1"] && min_y == coordinates["y1"]
        path = generate_diagonal_up_right_path_array(coordinates)
    elsif min_x == coordinates["x2"] && min_y == coordinates["y1"]
        path = generate_diagonal_up_left_path_array(coordinates)
    elsif min_x == coordinates["x2"] && min_y == coordinates["y2"]
        path = generate_diagonal_down_left_path_array(coordinates)
    else
        path = generate_diagonal_down_right_path_array(coordinates)
    end
    path.each do | coordinate |
        set_or_increment_tracker(coordinate)
    end
end

def generate_diagonal_up_right_path_array(coordinates)
    path = []
    x_start = coordinates["x1"]
    x_end = coordinates["x2"]
    y_start = coordinates["y1"]
    
    while x_start <= x_end
        coordinate = "#{x_start},#{y_start}"
        path.push(coordinate)
        x_start += 1
        y_start += 1
    end
    path
end

def generate_diagonal_up_left_path_array(coordinates)
    path = []
    x_start = coordinates["x1"]
    x_end = coordinates["x2"]
    y_start = coordinates["y1"]
    
    while x_start >= x_end
        coordinate = "#{x_start},#{y_start}"
        path.push(coordinate)
        x_start -= 1
        y_start += 1
    end
    path
end

def generate_diagonal_down_left_path_array(coordinates)
    path = []
    x_start = coordinates["x1"]
    x_end = coordinates["x2"]
    y_start = coordinates["y1"]

    while x_start >= x_end
        coordinate = "#{x_start},#{y_start}"
        path.push(coordinate)
        x_start -= 1
        y_start -= 1
    end
    path
end

def generate_diagonal_down_right_path_array(coordinates)
    path = []
    x_start = coordinates["x1"]
    x_end = coordinates["x2"]
    y_start = coordinates["y1"]

    while x_start <= x_end
        coordinate = "#{x_start},#{y_start}"
        path.push(coordinate)
        x_start += 1
        y_start -= 1
    end
    path
end

def set_or_increment_tracker(coordinate)
    if @tracker.key?(coordinate)
        @tracker[coordinate] += 1
    else
        @tracker[coordinate] = 1
    end
end

################ Showing the Answer ##########################
puts count_overlap(@coordinates)

