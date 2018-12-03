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
    input.map do |id|
      id
        .chars
        .each_with_object({}) { |e, a| a[e] ||= 0; a[e] += 1 }
        .each_with_object({}) { |(_k, v), a| a[v] ||= 0; a[v] += 1 }
        .inject({}) { |a, (k, v)| a[k] ||= 0; a[k] += 1 unless v.zero?; a }
    end.each_with_object([0,0]) do |e, a|
      a[0] += e[2].to_i
      a[1] += e[3].to_i
    end.inject(&:*)
  end

  def part2
    different.map{|c1,c2| c1 if c1 == c2}.compact.join
  end

  def different
    1.upto(input.size-2).each do |i|
      input[i..-1].each do |id|
        return input[i - 1].chars.zip(id.chars) if difference(input[i - 1], id) == 1
      end
    end
  end

  def difference(s1, s2)
    s1.chars.zip(s2.chars).inject(0) { |a, (c1, c2)| c1 == c2 ? a : a + 1 }
  end

  def input
    @input ||= File.open(@input_file_name, 'r') do |f|
      f.each_line.map do |line|
        line.chomp.strip
      end
    end.compact
  end
end

Solution.new('2.txt').run
