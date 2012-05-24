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
    @minutes = 0

  tick: ->
    if @seconds == 59
      @seconds = 0
      @minutes = @minutes + 1
    else @seconds = @seconds + 1

exports.Timer = Timer
