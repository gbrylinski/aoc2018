# Solution for day #7
class Solution
  def initialize(input_file_name)
    @input_file_name = input_file_name
    @tree = {}
  end

  def run
    puts "Solution to part 1: #{part1}"
    puts "Solution to part 2: #{part2}"
  end

  private

  def part1
    load_input
    result = []
    loop do
      break if @tree.empty?

      independent = @tree.select { |_, dependencies| dependencies.empty? }
      current = independent.keys.min
      @tree.delete(current)
      @tree.each { |_, dependencies| dependencies.delete(current) }
      result << current
    end

    result.join
  end

  def part2
    load_input
    result = []
    workers = {}
    total_time = 0
    max_workers = 5

    loop do
      break if @tree.empty?

      elapsed_time = workers.values.min.to_i
      total_time += elapsed_time
      removed = workers.keys.map do |node|
        workers[node] = workers[node] - elapsed_time
        next if workers[node] > 0

        @tree.delete(node)
        @tree.each { |_, dependencies| dependencies.delete(node) }
        result << node
        node
      end.compact
      removed.each { |node| workers.delete(node) }

      independent = @tree.select { |_, dependencies| dependencies.empty? }
      to_remove = independent.keys.sort - workers.keys
      free_slots = max_workers - workers.size
      to_remove.slice(0, free_slots).each do |node|
        workers[node] = 60 + node.ord - 64
      end
    end

    result.join
    total_time
  end

  def load_input
    File.open(@input_file_name, 'r') do |f|
      f.each_line.map.with_index do |line, idx|
        from_node, to_node = line.scan(/Step (\w+) .*step (\w+) .*/).flatten
        @tree[from_node] ||= []
        @tree[to_node] ||= []
        @tree[to_node] << from_node
      end
    end
  end
end

Solution.new(ARGV[-1]).run
