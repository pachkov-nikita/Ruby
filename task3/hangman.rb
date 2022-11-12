def get_word
  File.read('task3/words.txt').split.sample
end

lives = 5
hidden_word = get_word
final_word = hidden_word.split('').map { '_' }.join('')

while lives > 0
  puts "Загаданое слово: #{final_word}"
  puts "Осталось жизней = #{lives}"
  print "Введите букву: "
  letter = STDIN.gets.chomp.encode('UTF-8')[0]
  print "\n"
  the_letter_is = false
  hidden_word.split('').each_with_index { |hidden_letter, i|
    if hidden_letter === letter
      the_letter_is = true
      final_word[i] = hidden_letter
    end
  }
  if !final_word.include?('_')
    puts "Загаданое слово было: #{final_word}"
    print "\nПоздравляю! Вы выиграли"
    break
  elsif !the_letter_is
    lives -= 1
    if lives == 0
      print "\nУвы! Вы проиграли!"
    end
  end
end