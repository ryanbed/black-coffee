Spine = require('spine')
Deck = require('models/deck')

class Shoe extends Spine.Model
  @configure 'Shoe', 'cards', 'decks'
  cards: []
  decks: 6
  preShuffle: true
  runningCount: 0

  constructor: (config) ->
    super
    @decks = config.decks
    @cards = new Deck().cards for i in [1..@decks]
    @shuffle() if @preShuffle;

  shuffle: ->
    @cards.sort -> 0.5 - Math.random()
  
  drawCard: (facedown) ->
    card = @cards.pop()

    if !facedown
      if 9 < card.value or card.value == 1
        @runningCount--
      else if card.value < 7
        @runningCount++
      
    console.log "Dealing #{ card.shortName + card.shortSuit if !facedown }", card, "(running count is #{ @runningCount })"

    return card

module.exports = Shoe