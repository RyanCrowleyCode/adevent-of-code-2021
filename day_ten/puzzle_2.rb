################ Getting the data ##########################
file = File.read("day_ten.csv").split("\n")

@lines_array = []
@incomplete_lines_array = []

def set_lines_array(file)
    file.each do |row|
        @lines_array.push(row.split(""))
    end
end

set_lines_array(file)

################ Solving the problem ########################## 
@scores_array = []

@points_map = Hash.new
@points_map["("] = 1
@points_map["["] = 2
@points_map["{"] = 3
@points_map["<"] = 4

def build_scores_array
    openers = ["(", "[", "{", "<"]
    
    closers_map = Hash.new
    closers_map[")"] = "("
    closers_map["]"] = "["
    closers_map["}"] = "{"
    closers_map[">"] = "<"

    openers_map = Hash.new
    openers_map["("] = ")"
    openers_map["["] = "]"
    openers_map["{"] = "}"
    openers_map["<"] = ">" 

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
                    tracker = []
                    break
                end
            end
        end

        if tracker.length > 0
            score = 0
            tracker = tracker.reverse

            tracker.each do |opener|
                score *= 5
                score += (@points_map[opener])
            end            
            @scores_array.push(score)
        end
    end
end

def find_middle_score
    build_scores_array
    sorted = @scores_array.sort
    len = sorted.length
    middle_index = (len -1) / 2
    sorted[middle_index]
end


################ Showing the Answer ##########################

puts find_middle_score
