should = require 'should'
stream = require '../src/stream'

		
describe 'prime numbers', ->
    it 'finds them', ->
        sieve(stream.range 2).take(5).should.eql [2, 3, 5, 7, 11]

describe 'fizzbuzz', ->
  it 'can count to twenty', ->
    fizzbuzz(20).should.eql ['1', '2', '3 fizz', '4', '5 buzz', '6 fizz', '7', '8', '9 fizz', '10 buzz', '11', '12 fizz', '13', '14', '15 fizz buzz', '16', '17', '18 fizz', '19', '20 buzz']
            

sieve = (s) ->
    h = s.head()
    stream.create (-> h), (-> sieve s.tail().filter (x) -> x % h isnt 0)

fizzbuzz = (max) ->
	naturals = stream.range 1
	threes = stream.cycle ['', '', ' fizz']
	fives = stream.cycle ['', '', '', '', ' buzz']
	concat = (arr) -> arr.join ''
	stream.zip(naturals, threes, fives).map(concat).take(max)
