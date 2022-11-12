BRACKET_VALUE = { '(' => ')',
             '{' => '}',
             '[' => ']' }

def check_bracket(brack)
  arr = Array.new
  brack.each_char { |i|
    if !BRACKET_VALUE.keys.include?(i)
      if BRACKET_VALUE.values.include?(i)
        i == BRACKET_VALUE[arr.last] ? arr.pop : (return false)
      end
    else
      arr.push(i)
    end
  }
  arr.empty?
end

line = ''
until line.length >= BRACKET_VALUE.keys.length + BRACKET_VALUE.values.length
  print "Введите скобку:"
  user_input = $stdin.gets.chomp
  unless (BRACKET_VALUE.keys.include? user_input) || (BRACKET_VALUE.values.include? user_input)
    print "Вы допустили ошибку в воде!"
    next
  end
  if check_bracket(line.concat(user_input))
    (print "Скобки сбалансированы!")
  else
    (print "Скобки несбалансированы!")
  end
  puts "\nСтрока: #{line}" unless line.empty?
  print "\n"
end