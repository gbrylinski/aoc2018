require 'time'

# Solution for day #4
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
    id, values = guard_minutes.max_by { |_id, v| v.inject(0, &:+) }
    id * values.index(values.max)
  end

  def part2
    id, values = guard_minutes.max_by { |_id, v| v.max }
    id * values.index(values.max)
  end

  def guard_minutes
    guard = nil
    asleep_at = nil

    sorted_by_time.each_with_object({}) do |(t, v), a|
      case v
      when :asleep
        asleep_at = t
      when :awake
        a[guard] ||= Array.new(59, 0)
        asleep_at.min.upto(t.min - 1) { |i| a[guard][i] += 1 }
      else
        guard = v
      end
    end
  end

  def sorted_by_time
    lines = input.map do |line|
      line.scan(/\[(.*)\]\ (.*)/).flatten.compact
    end

    lines = lines.map do |t, v|
      time = Time.parse(t)
      value = case v
              when /wakes up/
                :awake
              when /asleep/
                :asleep
              else
                v.scan(/.*#(\d+).*/).flatten.first.to_i
              end
      [time, value]
    end

    lines.sort_by { |t, _v| t }
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
