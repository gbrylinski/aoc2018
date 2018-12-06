require 'ostruct'

# Solution for day #6
class Solution
  def initialize(input_file_name)
    @input_file_name = input_file_name
    @field = {}
    @occurences = {}
    @sums = {}
    @border_ids = []
  end

  def run
    puts "Solution to part 1: #{part1}"
    puts "Solution to part 2: #{part2}"
  end

  private

  def part1
    find_field_borders

    @min_x.upto(@max_x) do |x|
      @min_y.upto(@max_y) do |y|
        distances = input.map { |i| {id: i.id, distance: (i.x - x).abs + (i.y - y).abs} }
        found = distances.sort_by { |i| i[:distance] }
        @sums[[x, y]] = distances.inject(0) { |a, i| a + i[:distance] }

        next if found[0][:distance] == found[1][:distance]
        @field[[x, y]] = found[0]
        @occurences[found[0][:id]] ||= 0
        @occurences[found[0][:id]] += 1
        @border_ids << found[0][:id] if x == @min_x || x == @max_x || y == @min_y || y == @max_y
      end
    end

    @occurences.reject { |(id, _)| @border_ids.include?(id) }.max_by { |_, v| v }[1]
  end

  def part2
    @sums.count { |_, sum| sum < 10_000 }
  end

  def find_field_borders
    @min_x = @max_x = input[0].x
    @min_y = @max_y = input[0].y

    input.each do |item|
      @min_x = item.x if item.x < @min_x
      @min_y = item.y if item.y < @min_y
      @max_x = item.x if item.x > @max_x
      @max_y = item.y if item.y > @max_y
    end
  end

  def input
    @input ||= begin
      File.open(@input_file_name, 'r') do |f|
        f.each_line.map.with_index do |line, idx|
          x, y = line.split(',').map(&:to_i)
          OpenStruct.new(id: idx, x: x, y: y)
        end
      end
    end
  end
end

Solution.new(ARGV[-1]).run
