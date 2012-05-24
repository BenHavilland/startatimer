class Tick
  constructor: ->
    @subscribers = []

  addSubscriber: (newSub) ->
    throw "InvalidSubscriberError" if not newSub.tick?
    @subscribers.push newSub

  fire: ->
    (sub.tick() for sub in @subscribers)

exports.Tick = Tick


class Timer
  constructor: ->
    @seconds = 0

  tick: ->
    @seconds = @seconds + 1

exports.Timer = Timer
