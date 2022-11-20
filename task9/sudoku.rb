sudoku =  [[5, 3, 0, 0, 7, 0, 0, 0, 0],
                 [6, 0, 0, 1, 9, 5, 0, 0, 0],
                 [0, 9, 8, 0, 0, 0, 0, 6, 0],
                 [8, 0, 0, 0, 6, 0, 0, 0, 3],
                 [4, 0, 0, 8, 0, 3, 0, 0, 1],
                 [7, 0, 0, 0, 2, 0, 0, 0, 6],
                 [0, 6, 0, 0, 0, 0, 2, 8, 0],
                 [0, 0, 0, 4, 1, 9, 0, 0, 5],
                 [0, 0, 0, 0, 8, 0, 0, 7, 9]]


def print_result(sudoku)
  puts "\n"
  span = 2 + sudoku.flatten.max.to_s.size
  sudoku.each_with_index { |i, index|
    number_ = ((index + 1) % 3).zero?
    unless index.zero?
      puts "\n"
    end
    i.each_with_index do |j, index_|
      num = ((index_ + 1) % 3).zero?
      no_zero = (j.to_s.rjust(span) + (num ? ' ' : ''))
        print "\e[37m#{no_zero}\e[0m"
    end
    print (if !number_
             ""
           else
             "\n"
           end)
  }
  print "\n"
end

def solver(sudoku_array)
  pos = search_position(sudoku_array)
  return true unless pos
  (1..9).to_a.each { |element|
    if validation(sudoku_array, pos, element)
      sudoku_array[pos[0]][pos[1]] = element
      return true if solver(sudoku_array)
      sudoku_array[pos[0]][pos[1]] = 0
    end
  }
  false
end

def search_position(sudoku_array)
  (0..8).to_a.each_with_index { |i|
    (0..8).to_a.each_with_index { |j| return [i, j] if sudoku_array[i][j] == 0 }
  }
  false
end

def validation(sudoku_array, pos, number)
  return false unless sudoku_array[pos[0]][pos[1]] <= 0
  (0..8).to_a.each { |i| return false if (sudoku_array[pos[0]][i] == number) || (sudoku_array[i][pos[1]] == number) }
  ((pos[0]/3 * 3)..((pos[0]/3 * 3) + 2)).to_a.each do |i|
    ((pos[1]/3 * 3)..((pos[1]/3 * 3) + 2)).to_a.each do |j|
      return false if sudoku_array[i][j] == number
    end
  end
  true
end

solver(sudoku)
print_result(sudoku)
