def slice_pie(pie)
  height_pie = pie.lines.length
  weight_pie = pie.lines[0].chomp.length
  x0 = 0
  y0 = 0
  cnt = pie.chars.count 'o'
  if cnt == 0
    return []
  elsif weight_pie * height_pie % cnt != 0
    return []
  end
  field = (weight_pie * height_pie) / cnt
  sizes = (1..field).select do |h1|
    field % h1 == 0
  end.to_a
  raisin = (0...weight_pie).to_a.product((0...height_pie).to_a).filter do |x, y|
    pie.lines[y].chars[x] == 'o'
  end
  arr = Array.new
  slice(weight_pie, height_pie, field, sizes, raisin, arr, x0, y0)
  arr
end

def slice(w, h, field, size, raisin, arr, x, y)
  size.each do |h1|
    unless y + h1 <= h
      break
    end
    w1 = field / h1
    unless x + w1 <= w
      next
    end
    unless raisin.one? do |x1, y1|
      x <= x1 && x1 < x + w1 && y <= y1 && y1 < y + h1
    end
      next
    end
    arr << [x, y, w1, h1]
    xy = get_xy arr, x + w1, y, w, h
    if xy.nil?
      return true
    end
    result = slice(w, h, field, size, raisin, arr, *xy)
    if result
      return true
    end
    arr.pop
  end
  false
end

def get_xy(arr, x, y, wei, hei)
  unless x >= wei
    return [x, y]
  end
  loop do
    if x == wei
      y = y + 1
      if y == hei
        return nil
      end
      x = 0
    end
    result = arr.find do |x1, y1, w, h|
      y >= y1 && y < y1 + h && x >= x1 && x < x1 + w
    end
    if result.nil?
      return [x, y]
    end
    x += result[2]
  end
end

def print_result(pie, slice_p)
  slices = slice_p.map do |x, y, w, h|
    pie.lines[y...y + h].map { |line| line[x...x + w] } * "\n"
  end
  i = 0
  puts ""
  while i < slices.size
    puts "Кусок #{i+1}"
    puts slices[i]
    puts ""
    i = i + 1
  end
  if i >= 5
    puts"\nПирог разрезан на #{i} кусков"
  else
    puts"\nПирог разрезан на #{i} куска"
  end
end

unless slice_pie('.').empty?
  p
end
unless slice_pie('oo.').empty?
  p
end
unless slice_pie('oo..').empty?
  p
end
if slice_pie('o') != [[0, 0, 1, 1]]
  p
end
if slice_pie('oo') != [[0, 0, 1, 1], [1, 0, 1, 1]]
  p
end
if slice_pie('o..o') != [[0, 0, 2, 1], [2, 0, 2, 1]]
  p
end

pie = ".o......\n"\
       "......o.\n"\
       "....o...\n"\
       "..o....."

puts "Пирог:"
puts pie
puts ""
slice_p = slice_pie(pie)
print_result pie, slice_p