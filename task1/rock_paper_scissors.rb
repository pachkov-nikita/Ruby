def do_chose(chose)
  if chose == 1
    chose_to_string = "Камень"
  elsif chose == 2
    chose_to_string = "Ножницы"
  else
    chose_to_string = "Бумага"
  end
  chose_to_string
end

print "Начало игры, сделайте выбор!\n"
puts "1.Камень
2.Ножницы
3.Бумага"
user_chose = gets.chomp.to_i
computer_chose = rand(1..3)

print "\n"
if (1..3) === user_chose
  puts "Ваш выбор: #{do_chose(user_chose)}"
  puts "Выбор компьютера: #{do_chose(computer_chose)}"
  if user_chose === computer_chose
    print "Ничья!"
  elsif (user_chose === 1 && computer_chose === 2) ||
    (user_chose === 2 && computer_chose === 3) ||
    (user_chose === 3 && computer_chose === 1)
    print "Вы выиграли!"
  else
    print "Вы проиграли!"
  end
else
  print "Вы ввели некоректное число!"
end
