def remove(arr)
  p arr.uniq
  p Hash[arr.zip arr].values
  array_ = Array.new
  p(arr.filter { |x|
    array_.each_with_index { |i, j| return j if i >= x }
    i = array_.length
    if array_[i] != x
      array_.insert i, x
      true
    else
      false
    end
  })
end

loop do
  print "Введите значение массива, через запятую: "
  remove(gets.chomp.split(',').map(&:to_i))
end