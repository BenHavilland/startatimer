if not exports? then exports = window

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
    @total_seconds = 0

  tick: ->
    @total_seconds = @total_seconds + 1

  seconds: ->
    @total_seconds % 60

  minutes: ->
    Math.floor(@total_seconds / 60) % 60

  hours: ->
    Math.floor(@total_seconds / 3600) % 24

  days: ->
    Math.floor(@total_seconds / 86400)

exports.Timer = Timer
