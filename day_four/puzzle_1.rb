################ Getting the data ##########################
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
    board_number = 1

    board = Array.new
    board_array.each do | row |
        board.push(row.split) if !row.empty?

        if board.length == 5
            board_name = "board_#{board_number}"
            @board_hash[board_name] = Hash.new

            board.each_with_index do |row, index|
                row_name = "row_#{index + 1}"
                @board_hash[board_name][row_name] = Hash.new

                row.each_with_index do |number, index|
                    column_name = "column_#{index + 1}"
                    @board_hash[board_name][row_name][column_name] = Hash.new
                    @board_hash[board_name][row_name][column_name]["bingo_number"] = number
                    @board_hash[board_name][row_name][column_name]["marked"] = false
                end
            end
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
        check_number_in_row(number, board)
    end
end

def check_number_in_row(number, board)
    board.each do |row_name, row|
        row.each do |column_name, column|
            if column["bingo_number"] == number
                column["marked"] = true
            end
            if whole_row_marked(board) || whole_column_marked(board)
                @score ||= count_unmarked_numbers(board) * number.to_i
            end
        end
    end
end

def whole_row_marked(board)
    board.each do |row_name, row|
        completed = true
        row.each do |column_name, column|
            if column["marked"] == false
                completed = false
            end
        end
        return true if completed == true
    end
    return false
end

def whole_column_marked(board)
    column_names = [
        "column_1",
        "column_2",
        "column_3",
        "column_4",
        "column_5"
    ]
    column_names.each do | column_name |
        completed = true
        board.each do |row_name, row|
            if row[column_name]["marked"] == false
                completed = false
            end
        end
        return true if completed == true
    end
    return false
end

def count_unmarked_numbers(board)
    count = 0
    board.each do |row_name, row|
        row.each do |column_name, column|
            count += column["bingo_number"].to_i if column["marked"] == false
        end
    end
    count
end


################ Showing the Answer ##########################
play_bingo



