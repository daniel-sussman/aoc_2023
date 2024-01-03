data = File.open('input.txt').read

def verify(source)
  steps = source.split(',')
  steps.inject(0) { |sum, step| sum + make_hash(step) }
end

def make_hash(string)
  current_value = 0
  string.gsub!("\n", '')
  chars = string.split('')
  until chars.empty?
    char = chars.shift
    current_value += char.ord
    current_value *= 17
    current_value %= 256
  end
  current_value
end

def confirm(source)
  boxes = Array.new(256) {[]}
  steps = source.split(',')
  steps.each do |step|
    _, label, char, focal_length = /([a-z]+)([=-])(\d)?/.match(step).to_a
    n = make_hash(label)
    if char == '-'
      boxes[n].delete_if { |lens| /([a-z]+) \d/.match(lens)[1] == label }
    else
      i = boxes[n].index { |lens| /([a-z]+) \d/.match(lens)[1] == label }
      i ? boxes[n][i] = "#{label} #{focal_length}" : boxes[n] << "#{label} #{focal_length}"
    end
  end
  focusing_power = 0
  boxes.each_with_index do |box, box_number|
    next if box.empty?

    box.each_with_index do |lens, slot_number|
      focusing_power += (box_number + 1) * (slot_number + 1) * (lens[-1].to_i)
      # p "#{/([a-z]+) \d/.match(lens)[1]}: #{box_number + 1} (box #{box_number}) * #{slot_number + 1} (no. slot) * #{lens[-1]} (focal length) = #{(box_number + 1) * (slot_number + 1) * (lens[-1].to_i)}"
    end
  end
  focusing_power
end

# p verify(data)
p confirm(data)
