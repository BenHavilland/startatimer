class Tick
  constructor: ->
    @subscribers = []

  addSubscriber: (newSub) ->
    @subscribers.push newSub

  fire: ->
    (sub.tick() for sub in @subscribers)

exports.Tick = Tick
