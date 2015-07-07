convertToRomanNumeral = (number) ->
  result = ''

  map = [
    [100,'C'],
    [90,'XC'],
    [50,'L'],
    [40,'XL'],
    [10,'X'],
    [9, 'IX'],
    [5,'V'],
    [4,'IV'],
    [1,'I']
  ]

  for [arabic, roman] in map
    while (number >= arabic)
      result = result.concat(roman)
      number -= arabic

  result

describe 'convertToRomanNumeral', ->
  it 'converts 1 to I', ->
    result = convertToRomanNumeral(1)
    expect(result).toEqual('I')

  it 'converts 2 to II', ->
    result = convertToRomanNumeral(2)
    expect(result).toEqual('II')

  it 'converts 3 to III', ->
    result = convertToRomanNumeral(3)
    expect(result).toEqual('III')

  it 'converts 4 to IV', ->
    result = convertToRomanNumeral(4)
    expect(result).toEqual('IV')

  it 'converts 5 to V', ->
    result = convertToRomanNumeral(5)
    expect(result).toEqual('V')

  it 'converts 6 to VI', ->
    result = convertToRomanNumeral(6)
    expect(result).toEqual('VI')

  it "converts 7 to VII", ->
    result = convertToRomanNumeral(7)
    expect(result).toEqual('VII')

  it "converts 9 to IX", ->
    result = convertToRomanNumeral(9)
    expect(result).toEqual('IX')

  it "converts 10 to X", ->
    result = convertToRomanNumeral(10)
    expect(result).toEqual('X')

  it 'converts 15 to XV', ->
    result = convertToRomanNumeral(15)
    expect(result).toEqual('XV')

  it 'converts 20 to XX', ->
    result = convertToRomanNumeral(20)
    expect(result).toEqual('XX')

  it 'converts 40 to XL', ->
    result = convertToRomanNumeral(40)
    expect(result).toEqual('XL')

  it 'converts 47 to XLVII', ->
    result = convertToRomanNumeral(47)
    expect(result).toEqual('XLVII')

  it 'converts 50 to L', ->
    result = convertToRomanNumeral(50)
    expect(result).toEqual('L')

  it 'converts 90 to XC', ->
    result = convertToRomanNumeral(90)
    expect(result).toEqual('XC')

  it 'converts 100 to C', ->
    result = convertToRomanNumeral(100)
    expect(result).toEqual('C')

