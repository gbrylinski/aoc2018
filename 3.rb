class Solution
  def initialize(input_file_name)
    @input_file_name = input_file_name
  end

  def run
    puts "Solution to part 1: #{part1}"
    puts "Solution to part 2: #{part2}"
  end

  private

  def part1
    entries.each do |(id, x, y, w, h)|
      claim(id, x, y, w, h)
    end

    field.inject(0) do |a, (_k, v)|
      v >= 2 ? a + 1 : a
    end
  end

  def part2
    entries.each do |(id, x, y, w, h)|
      return id if check(id, x, y, w, h)
    end
  end

  def claim(id, x, y, w, h)
    x.upto(x + w - 1).each do |i|
      y.upto(y + h - 1).each do |j|
        pos = "#{i}_#{j}"
        field[pos] ||= 0
        field[pos] += 1
      end
    end
  end

  def check(id, x, y, w, h)
    x.upto(x + w - 1).each do |i|
      y.upto(y + h - 1).each do |j|
        pos = "#{i}_#{j}"
        return false if field[pos] > 1
      end
    end
    true
  end

  def field
    @field ||= {}
  end

  def entries
    input.map do |line|
      line.scan(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).flatten.map(&:to_i)
    end
  end

  def input
    @input ||= File.open(@input_file_name, 'r') do |f|
      f.each_line.map do |line|
        line.chomp.strip
      end
    end.compact
  end
end

Solution.new(ARGV[-1]).run
