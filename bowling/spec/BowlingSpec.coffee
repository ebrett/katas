describe 'Bowling', ->
  rolls = null

  beforeEach ->
    rolls = []

  roll = (pins) ->
    rolls = rolls.concat(pins)

  score = () ->
    result = 0
    for fallen in rolls
      result += fallen
    result

  it 'returns 0 for 20 gutter ball', ->
    for [1..20]
      roll(0)
    expect(score()).toEqual 0

  it 'returns 20 for 20 single pins knocked down', ->
    for [1..20]
      roll(1)
    expect(score()).toEqual 20

  it 'returns 14 for [8, 2, 2] spare', ->
    roll(8)
    roll(2)
    roll(2)
    for [1..17]
      roll(0)
    expect(score()).toEqual 14
