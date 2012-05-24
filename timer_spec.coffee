Tick = (require './timer').Tick
Timer = (require './timer').Timer

describe "Timer", ->
  beforeEach ->
    @timer = new Timer

  describe "seconds", ->
    it "adds one second when tick() is fired", ->
      expect(@timer.seconds()).toBe 0
      @timer.tick()
      expect(@timer.seconds()).toBe 1
      @timer.tick()
      expect(@timer.seconds()).toBe 2

    it "rolls seconds back to 0 when they hit 60", ->
      @timer.total_seconds = 59
      @timer.tick()
      expect(@timer.seconds()).toBe 0

  describe "minutes", ->
    it "returns 0 minutes when seconds are under 60", ->
      @timer.total_seconds = 59
      expect(@timer.minutes()).toBe 0

    it "returns 1 minute when seconds are 60", ->
      @timer.total_seconds = 60
      expect(@timer.minutes()).toBe 1

    it "returns 2 minutes when seconds are 120", ->
      @timer.total_seconds = 120
      expect(@timer.minutes()).toBe 2

    it "returns 0 minutes when seconds are 3600 (1 hour)", ->
      @timer.total_seconds = 3600
      expect(@timer.minutes()).toBe 0

  describe "hours", ->
    it "returns 1 hour when minutes are 60", ->
      @timer.total_seconds = 3600
      expect(@timer.hours()).toBe 1

    it "returns 0 hours when seconds are 86400 (1 day)", ->
      @timer.total_seconds = 86400
      expect(@timer.hours()).toBe 0

  describe "days", ->
    it "adds a day every 24 hours", ->
      expect(@timer.days()).toBe 0
      @timer.total_seconds = 86400
      expect(@timer.days()).toBe 1
      @timer.total_seconds = 172800
      expect(@timer.days()).toBe 2

  describe "reset", ->
    it "can reset back to 0", ->
      @timer.total_seconds = 100
      @timer.reset()
      expect(@timer.seconds()).toBe 0


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
