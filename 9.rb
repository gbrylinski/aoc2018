# Solution for day #6
class Solution
  def initialize(input_file_name)
    @input_file_name = input_file_name
  end

  def run
    load_input

    puts "Solution to part 1: #{part1}"
    puts "Solution to part 2: #{part2}"
  end

  private

  def part1
    @circle = { 0 => [0, 0] }
    @elves = []
    1.upto(@marbles) do |marble|
      if marble % 23 == 0
        item_removed = 7.times.reduce(marble - 1) { |a, _| @circle[a][0] }
        item_before = @circle[item_removed][0]
        item_after = @circle[item_removed][1]
        @circle[item_before][1] = item_after
        @circle[item_after][0] = item_before
        @circle[marble] = @circle[item_after]
        @elves[marble % @players] ||= 0
        @elves[marble % @players] += (marble + item_removed)
      else
        item_before = @circle[marble - 1][1]
        item_after = @circle[item_before][1]
        @circle[marble] = [item_before, item_after]
        @circle[item_before][1] = marble
        @circle[item_after][0] = marble
      end
    end

    @elves.compact.max
  end

  def part2
    @marbles *= 100
    part1
  end

  def load_input
    File.open(@input_file_name, 'r') do |f|
      @players, @marbles = f.readline.scan(/^(\d+) .*worth (\d+).*/).flatten.map(&:to_i)
    end
  end
end

Solution.new(ARGV[-1]).run
