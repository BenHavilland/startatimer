Tick = (require './timer').Tick

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
