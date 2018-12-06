# Solution for day #5
class Solution
  def initialize(input_file_name)
    @input_file_name = input_file_name
    @patterns = ('a'..'z').flat_map do |c|
      [/#{c}#{c.upcase}/, /#{c.upcase}#{c}/]
    end
  end

  def run
    puts "Solution to part 1: #{part1}"
    puts "Solution to part 2: #{part2}"
  end

  private

  def part1
    loop do
      start_size = input.size
      @patterns.each { |pattern| input.gsub!(pattern, '') }
      break input.size if start_size == input.size
    end
  end

  def part2
    ('a'..'z').map do |c|
      @input = nil
      input.delete!("#{c}#{c.upcase}")
      part1
    end.min
  end

  def input
    @input ||= File.open(@input_file_name, 'r') do |f|
      f.readline.chomp.strip
    end
  end
end

Solution.new(ARGV[-1]).run
