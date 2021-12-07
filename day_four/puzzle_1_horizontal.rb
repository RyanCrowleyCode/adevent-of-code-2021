################ Getting the data ##########################
# example_board_hash = {
#     "board_1": [
#         ["22", "13", "17", "11", "0"],
#         ["8", "2", "23", "4", "24"],
#         ["21", "9", "14", "16", "7"],
#         ["6", "10", "3", "18", "5"],
#         ["1", "12", "20", "15", "19"]
#     ]
# }

# example_board_tracker_hash = {
#     "board_1": [
#         [],
#         [],
#         [],
#         [],
#         []
#     ]
# }

file = File.read("day_four.csv")

def parse_file(file)
    @draw_numbers = file.split(",")
    last_number = @draw_numbers.last.split("\n")
    @draw_numbers.last.replace(last_number.first)
    
    last_number.shift
    board_array = last_number
    prepare_boards(board_array)
end

def prepare_boards(board_array)
    @board_hash = Hash.new
    @board_tracker_hash = Hash.new
    board_number = 1

    board = Array.new
    board_array.each do | row |
        board.push(row.split) if !row.empty?

        if board.length == 5
            board_name = "board_#{board_number}"
            @board_hash[board_name] = board
            @board_tracker_hash[board_name] = board.dup
            board = Array.new
            board_number += 1
        end
    end
end

parse_file(file)


################ Solving the problem ##########################
def play_bingo
    @draw_numbers.each do | number |
        check_number_in_boards(number)
    end
    puts @score
end

def check_number_in_boards(number)
    @board_hash.each do |board_name, board|
        check_number_in_row(number, board_name, board)
    end
end

def check_number_in_row(number, board_name, board)
    board.each_with_index do |row, index|
        if row.include? number
            @board_tracker_hash[board_name][index].delete(number)
            if @board_tracker_hash[board_name][index].empty?
                umarked_count = count_unmarked_numbers(@board_tracker_hash[board_name])
                @score ||= number.to_i * umarked_count
            end
        end
    end
end

def count_unmarked_numbers(board)
    count = 0

    board.each do | row |
        row.each do | number |
            count += number.to_i
        end
    end
    count
end


################ Showing the Answer ##########################
play_bingo