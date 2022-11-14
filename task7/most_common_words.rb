def get_common_word(string)
  return [] if string == ""
  common_words = string.group_by { |word| word }.inject({}) { |map, (key, val)| map.merge(key => val.size)}
                     .sort_by {|key, value| value}.filter_map { |key, value| key }.reverse
  if common_words.size < 3
    common_words
  else
    common_words.first(3)
  end
end

def split_to_downcase(string)
  string.downcase.split(/[^а-я']+/)
end


def get_result_with_split(str)
  get_common_word(split_to_downcase(str))
end

normal_text = "Григорий Саввич Сковорода родился 22 ноября (3 декабря) 1722 года в сотенном селе Чернухи Лубенского полка,
                входившем в черту Киевской губернии. Среди уроженцев Лубенского полка в ревизских книгах восемнадцатого века
                также упоминаются Клим, Фёдор и Емельян Сковорода, по всей видимости состоявшие с Григорием Сковородой в родстве.
                Григорий был вторым ребёнком в семье малоземельного казака Савки (Саввы) Сковороды и его жены Палажки — в
                девичестве — Пелагеи Степановны Шангиреевой"

two_words = "Два слова"

one_word = "Одно"

any_word = ""

puts "1.Три самых встречающихся слов с обычного текста:" + get_result_with_split(normal_text).to_s
puts "2.Текст с двумя слова:" + get_result_with_split(two_words ).to_s
puts "3.Текст с одним словом:" + get_result_with_split(one_word ).to_s
puts "4.Пустой текст:" + get_result_with_split(any_word).to_s