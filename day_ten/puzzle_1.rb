################ Getting the data ##########################
file = File.read("day_ten.csv").split("\n")

@lines_array = []

def set_lines_array(file)
    file.each do |row|
        @lines_array.push(row.split(""))
    end
end

set_lines_array(file)

################ Solving the problem ########################## 
@illegal_characters_tally = Hash.new

def check_for_illegal_characters
    openers = ["(", "[", "{", "<"]
    
    closers_map = Hash.new
    closers_map[")"] = "("
    closers_map["]"] = "["
    closers_map["}"] = "{"
    closers_map[">"] = "<"  

    @lines_array.each do |line|
        tracker = []
        line.each do |character|
            if tracker.length == 0
                tracker.push(character)
            elsif openers.include?(character)
                tracker.push(character)
            else
                if tracker.last == closers_map[character]
                    tracker.pop
                else
                    if @illegal_characters_tally.has_key?(character)
                        @illegal_characters_tally[character] += 1
                        break
                    else
                        @illegal_characters_tally[character] = 1
                        break
                    end
                end
            end
        end
    end
end

def get_score
    score = 0
    
    points_map = Hash.new
    points_map[")"] = 3
    points_map["]"] = 57
    points_map["}"] = 1197
    points_map[">"] = 25137

    check_for_illegal_characters

    @illegal_characters_tally.each do |key, value|
        score += (points_map[key] * value)
    end

    score
end

################ Showing the Answer ##########################

puts get_score
