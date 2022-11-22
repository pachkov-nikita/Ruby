TRIGONOMETRICAL = %w[cos sin tan cot]
TRIGONOMETRICAL_CHARS = TRIGONOMETRICAL.join.chars.uniq
@to_merge = false
@trigonometrical = ""
@out = []
@stack = []

def operator(string)
  !digit string
end

def digit(string)
  string.match?(/\d/)
end

def open_bracket(string)
  string.eql? '('
end

def close_bracket(string)
  string.eql? ')'
end

def operand(string)
  !operator(string) && (string != ')')
end

def priority(string)
  return 1 if string == "-" || string == "+"
  return 2 if string == '*' or string == '/'
  return 3 if string == '^'
  if TRIGONOMETRICAL.include? string
    4
  else
    0
  end
end

def trigonometrical(string)
  TRIGONOMETRICAL_CHARS.include? string
end

def convert(string)
  string.split(//).reject do |x|
    x == " "
  end.each do |i|
    case
    when open_bracket(i)
      unless @trigonometrical.empty?
        @stack << @trigonometrical + " "
      end
      @stack << i
      @trigonometrical = ""
      @to_merge = false
    when close_bracket(i)
      while @stack.length != 0 && !open_bracket(@stack.last) do
        help_number = @out.pop
        @out.push(@stack.pop + @out.pop + help_number)
      end
      @stack.pop
      @to_merge = false
    when !operator(i)
      if @to_merge
        @out << @out.pop.strip + i + " "
      end
      unless @to_merge
        @out << i + " "
      end
      @to_merge = true
    else
      if trigonometrical(i)
        @trigonometrical << i
        next
      end
      while @stack.length != 0 && priority(i.to_s) <= priority(@stack.last&.strip) do
        help_number = @out.pop
        @out.push(@stack.pop + @out.pop + help_number)
      end
      @stack.push(i + " ")
      @to_merge = false
    end
  end

  while @stack.length != 0 do

    help_number1 = @out.pop
    help_number2 = @out.pop
    operator = @stack.pop
    temp = ""
    unless operator.nil?
      temp << operator
    end
    unless help_number2.nil?
      temp << help_number2
    end
    unless help_number1.nil?
      temp << help_number1
    end
    @out.push(temp)
  end

  @out.last
end

def calculate(string)
  split = string.split.reverse
  count = 0
  until nil == (operation = split[count]) do
    if operand(operation)
      @stack.push(operation)
    else
      if TRIGONOMETRICAL.include? operation
        number1 = @stack.pop
        result = chose_operator(number1, 0, operation)
        @stack.push(result)
      else
        number2 = @stack.pop
        number1 = @stack.pop
        result = chose_operator(number1, number2, operation)
        @stack.push(result)
      end
    end
    count += 1
  end
  @stack.pop
end

def chose_operator(number1, number2, operation)
  case operation
  when '+'
    number1.to_i + number2.to_i
  when '-'
    number1.to_i - number2.to_i
  when '*'
    number1.to_i * number2.to_i
  when '/'
    number1.to_i / number2.to_i
  when '^'
    number2.to_i ** number1.to_i
  when 'cos'
    Math.cos(number1)
  when 'sin'
    Math.sin(number1)
  when 'tg'
    Math.tan(number1)
  when  operation == 'ctg'
    Math.cos(number1)/Math.sin(number1)
  else
    puts 'Something wrong'
  end
end

polish_notation_convert = convert("19^2")
result = calculate(polish_notation_convert)
puts polish_notation_convert
puts result