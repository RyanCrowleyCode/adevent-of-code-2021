################ Getting the data ##########################
file = File.read("example.csv")

# example_coordinates = [
#     {"start"=>["0", "9"], "end"=>["5", "9"], "x1"=>0, "y1"=>9, "x2"=>5, "y2"=>9},
#     {"start"=>["8", "0"], "end"=>["0", "8"], "x1"=>8, "y1"=>0, "x2"=>0, "y2"=>8},
#     {"start"=>["9", "4"], "end"=>["3", "4"], "x1"=>9, "y1"=>4, "x2"=>3, "y2"=>4},
#     {"start"=>["2", "2"], "end"=>["2", "1"], "x1"=>2, "y1"=>2, "x2"=>2, "y2"=>1},
#     {"start"=>["7", "0"], "end"=>["7", "4"], "x1"=>7, "y1"=>0, "x2"=>7, "y2"=>4},
#     {"start"=>["6", "4"], "end"=>["2", "0"], "x1"=>6, "y1"=>4, "x2"=>2, "y2"=>0},
#     {"start"=>["0", "9"], "end"=>["2", "9"], "x1"=>0, "y1"=>9, "x2"=>2, "y2"=>9},
#     {"start"=>["3", "4"], "end"=>["1", "4"], "x1"=>3, "y1"=>4, "x2"=>1, "y2"=>4},
#     {"start"=>["0", "0"], "end"=>["8", "8"], "x1"=>0, "y1"=>0, "x2"=>8, "y2"=>8},
#     {"start"=>["5", "5"], "end"=>["8", "2"], "x1"=>5, "y1"=>5, "x2"=>8, "y2"=>2}
# ]

def parse_file(file)
    file_array = file.split("\n")
    coordinates_array = divide_start_and_finish(file_array)
    @coordinates = get_coordinates(coordinates_array)
    puts @coordinates
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

        coordinates_hash["start"] = starting 
        coordinates_hash["end"] = ending
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

################ Showing the Answer ##########################



