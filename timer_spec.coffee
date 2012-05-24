Tick = (require './timer').Tick
Timer = (require './timer').Timer

describe "Timer", ->
  beforeEach ->
    @timer = new Timer

  it "adds one second when tick() is fired", ->
    expect(@timer.seconds).toBe 0
    @timer.tick()
    expect(@timer.seconds).toBe 1
    @timer.tick()
    expect(@timer.seconds).toBe 2

  it "rolls seconds back to 0 when they hit 60", ->
    @timer.seconds = 59
    @timer.tick()
    expect(@timer.seconds).toBe 0

  it "adds a minute every 60 seconds", ->
    expect(@timer.minutes).toBe 0
    @timer.seconds = 59
    @timer.tick()
    expect(@timer.minutes).toBe 1

describe "Tick", ->
  beforeEach ->
    @tick = new Tick
    @foo = tick: -> "hi"
    @bar = tick: -> "what"

  it "accepts subscribers", ->
    @tick.addSubscriber @foo
    expect(@tick.subscribers).toEqual [@foo]
    @tick.addSubscriber @bar
    expect(@tick.subscribers).toEqual [@foo, @bar]

  it "calls the 'tick' method on subscribers", ->
    spyOn(@foo, 'tick')
    spyOn(@bar, 'tick')
    @tick.addSubscriber @foo
    @tick.addSubscriber @bar

    @tick.fire()
    expect(@foo.tick).toHaveBeenCalled()
    expect(@bar.tick).toHaveBeenCalled()

  it "rejects new subscribers without a tick() method", ->
    expect((=> @tick.addSubscriber { thing: "yeah!" })).toThrow("InvalidSubscriberError")
