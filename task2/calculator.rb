print "Введите первое число:"
first_number = gets.chomp.to_i
print "Введите знак:"
operator = gets.chomp
print "Введите второе число:"
second_number = gets.chomp.to_i
print "Результат: "

case operator
when '+'
  puts "#{first_number} + #{second_number} = #{first_number + second_number}"
when '-'
  puts "#{first_number} - #{second_number} = #{first_number - second_number}"
when '*'
  puts "#{first_number} * #{second_number} = #{first_number * second_number}"
when '/'
  if second_number != 0
  puts "#{first_number} / #{second_number} = #{first_number / second_number}"
  else
    print "А на ноль делить то нельзя???!"
  end
else
  print "Введен неправельный знак!"
end
