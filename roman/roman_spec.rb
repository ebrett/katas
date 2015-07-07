def convert_to_roman(arabic)
  result = ''
  [
    [10,'X'],
    [9,'IX'],
    [6,'VI'],
    [5,'V'],
    [4,'IV'],
    [1, 'I']
  ].each do |roman_mapping|
    while arabic - roman_mapping[0] >= 0
      result << roman_mapping[1]
      arabic -= roman_mapping[0]
    end
  end
  result
end

RSpec.describe 'convert_to_roman' do

  {
    1 => 'I',
    2 => 'II',
    4 => 'IV',
    5 => 'V',
    6 => 'VI',
    7 => 'VII',
    9 => 'IX',
   10 => 'X'
  }.each do | arabic, roman |
    it "converts arabic #{arabic} to roman #{roman}" do
      expect(convert_to_roman(arabic)).to eq roman
    end
  end

end
