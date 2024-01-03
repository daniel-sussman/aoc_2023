data = File.open('input.txt').read.split("\n")

LIST = {}
PULSE_COUNT = {low: 0, high: 0}

class BaseModule
  def initialize(id, outputs)
    @id = id
    @outputs = outputs
    @queue = []
  end

  def broadcast(pulse_type)
    PULSE_COUNT[pulse_type] += @outputs.size
    @outputs.each { |child| LIST[child]&.receive(pulse_type, @id) }
  end

  def receive(pulse_type, _sender_id)
    @queue << pulse_type
  end

  def process
    result = @queue.size
    @queue.each { |pulse_type| broadcast(pulse_type) }
    @queue = []
    result
  end
end

class FlipFlopModule < BaseModule
  def initialize(id, outputs)
    super
    @on = false
  end

  def receive(pulse_type, _sender_id)
    if pulse_type == :low
      @on = !@on
      @queue << (@on ? :high : :low)
    end
  end
end

class ConjunctionModule < BaseModule
  attr_reader :triggered

  def initialize(id, inputs, outputs)
    super(id, outputs)
    @memory = {}
    inputs.each { |input| @memory[input] = :low }
    @triggered = false
  end

  def broadcast(pulse_type)
    @triggered = true if pulse_type == :high
    @triggered = false if pulse_type == :low
    super
  end

  def receive(pulse_type, sender_id)
    @memory[sender_id] = pulse_type
    @queue << (@memory.values.all? { |pulse_type| pulse_type == :high } ? :low : :high)
  end
end

class ReceiverModule < BaseModule
  attr_reader :triggered

  def initialize(id, outputs)
    super
    @triggered = false
  end

  def receive(pulse_type, _sender_id)
    @triggered = true if pulse_type == :low
  end
end

def push_button_n_times(source)
  # targets are {"qz"=>:low, "cq"=>:low, "jx"=>:low, "tt"=>:low}
  build_list(source)
  LIST['rx'] = ReceiverModule.new('rx', [])
  targets = %w(qz cq jx tt)
  targets.map! { |target| find_trigger_point(target) }
  p targets
  targets.inject(1, :lcm)
end

def find_trigger_point(comm_module_id)
  5000.times do |n|
    LIST['broadcaster'].broadcast(:low)
    result = 1
    iteration = 1
    while result > 0
      result = LIST.values.inject(0) { |sum, comm_module| sum + comm_module.process }
      p iteration if LIST[comm_module_id].triggered
      return n + 1 if LIST[comm_module_id].triggered && (iteration == 2 || iteration == 3)
      iteration += 1
    end
  end
  "ERROR"
end

def push_button_1k_times(source)
  PULSE_COUNT[:low] = 0
  PULSE_COUNT[:high] = 0
  build_list(source)
  1000.times do
    PULSE_COUNT[:low] += 1 # the button sends a pulse to broadcaster
    LIST['broadcaster'].broadcast(:low)
    result = 1
    while result > 0
      result = LIST.values.inject(0) { |sum, comm_module| sum + comm_module.process }
    end
  end
  PULSE_COUNT[:low] * PULSE_COUNT[:high]
end

def build_list(source)
  source.each do |row|
    key, value = row.split(' -> ')
    outputs = value.split(', ')
    case key
    when 'broadcaster'
      LIST[key] = BaseModule.new(key, outputs)
    when /^%.+/
      key = key[1..]
      LIST[key] = FlipFlopModule.new(key, outputs)
    when /^&.+/
      key = key[1..]
      inputs = fetch_inputs(source, key)
      LIST[key] = ConjunctionModule.new(key, inputs, outputs)
    end
  end
end

def fetch_inputs(source, module_id)
  inputs = []
  source.each do |row|
    key, value = row.split(' -> ')
    inputs << /^[%&]?(.*)/.match(key)[1] if value.split(', ').include?(module_id)
  end
  inputs
end

# p push_button_1k_times(data)
p push_button_n_times(data)
