# Solution for day #6
class Solution
  def initialize(input_file_name)
    @input_file_name = input_file_name
    @input = []
  end

  def run
    load_input

    puts "Solution to part 1: #{part1}"
    puts "Solution to part 2: #{part2}"
  end

  private

  def part1
    load_input
    do_nodes1
  end

  def part2
    load_input
    do_nodes2
  end

  def do_nodes1
    nodes = @input.shift
    meta = @input.shift
    node_values = nodes.times.map { do_nodes1 }
    meta_values = @input.shift(meta)

    node_values.inject(0, &:+) + meta_values.inject(0, &:+)
  end

  def do_nodes2
    nodes = @input.shift
    meta = @input.shift
    node_values = nodes.times.map { do_nodes2 }
    meta_values = @input.shift(meta)

    if nodes > 0
      meta_values.inject(0) { |a, i| a + (node_values[i - 1] || 0) }
    else
      meta_values.inject(0, &:+)
    end
  end

  def load_input
    File.open(@input_file_name, 'r') do |f|
      @input = f.readline.split(' ').map(&:to_i)
    end
  end
end

Solution.new(ARGV[-1]).run
