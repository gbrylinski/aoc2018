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
    input.inject(0, &:+)
  end

  def part2
    occurences = {}
    occurences[0] = nil
    current_frequency = 0

    loop do
      current_frequency += input.first

      break current_frequency if occurences.has_key?(current_frequency)

      occurences[current_frequency] = nil
      input.rotate!
    end
  end

  def input
    @input ||= File.open(@input_file_name, 'r') do |f|
      f.each_line.map do |line|
        line.chomp.strip.to_i
      end
    end.compact
  end
end

Solution.new('1.txt').run
