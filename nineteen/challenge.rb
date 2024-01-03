data = File.open('input.txt').read.split("\n\n")

def sort(source)
  workflows = {'A' => 'A', 'R' => 'R'}
  source[0].split("\n").each do |element|
    e = /([a-z]+){(.*?,)(.*?,)?(.*?,)?([ARa-z]+)/.match(element)
    workflows[e[1]] = e[2..5].compact.map{ |i| i[-1] == ',' ? i[..-2] : i }
  end
  parts = source[1].split("\n")
  workflow = workflows['in']

  parts.inject(0) do |sum, part|
    result = assign_workflow(part, workflow, workflows)
    sum + result
  end
end

def assign_workflow(part, workflow, workflows)
  x, m, a, s = /x=(\d+),m=(\d+),a=(\d+),s=(\d+)/.match(part)[1..].map(&:to_i)
  until workflow.instance_of?(String)
    if workflow.first.include?(':')
      statement, result = workflow.first.split(':')
      throw "ERROR: #{statement}" unless /^[xmas][><]\d+$/.match(statement)
      workflow = eval(statement) ? workflows[result] : workflow[1..]
    else
      workflow = workflows[workflow.first]
    end
  end
  workflow == 'A' ? x + m + a + s : 0
end

class Path
  attr_writer :criteria

  def initialize(criteria = [])
    @criteria = criteria
  end

  def combos
    x = []
    m = []
    a = []
    s = []
    @criteria.each do |criterion|
      case criterion[0]
      when 'x'
        x << criterion
      when 'm'
        m << criterion
      when 'a'
        a << criterion
      when 's'
        s << criterion
      end
    end
  end
end

VALID_PATHS = []
WORKFLOWS = {}
QUEUE = []

def evaluate(source)
  paths = []
  possible_combos = 0
  source[0].split("\n").each do |element|
    e = /([a-z]+){(.*?,)(.*?,)?(.*?,)?([ARa-z]+)/.match(element)
    WORKFLOWS[e[1]] = e[2..5].compact.map{ |i| i[-1] == ',' ? i[..-2] : i }
  end
  workflow = WORKFLOWS['in']
  workflow.each do |criterion|
    if criterion.include?(':')
      statement, result = criterion.split(':')
      path_result = query(Path.new(statement), result)
      VALID_PATHS << path_result if path_result
    else
      QUEUE << criterion
    end
  end
end

def query(path, workflow)
  return path if workflow == 'A'
  return if workflow == 'R'

  criteria = WORKFLOWS[workflow]
  criteria.each do |criterion|
    if criterion.include?(':')
      clone = Path.new(path.criteria)
      statement, result = criterion.split(':')
      if result == 'A'
        path.criteria << statement
        VALID_PATHS << path
        clone.criteria << inverse_of(statement)

      elsif result == 'R'
        path.criteria << inverse_of(statement)
      else
        path.criteria << statement
        clone.criteria << inverse_of(statement)
      end
    else

    end
  end
end

def inverse_of(statement)
  statement.gsub('>', '<') if statement.include?('>')
  statement.gsub('<', '>') if statement.include?('<')
end

# p sort(data)
pp evaluate(data)
