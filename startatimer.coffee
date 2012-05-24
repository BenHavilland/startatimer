($ ->
  window.ticker = new Tick
  window.timer = new Timer
  window.ticker.addSubscriber window.timer

  window.timerDisplay =
    tick: ->
      for thing in ["seconds", "minutes", "hours", "days"]
        $("\##{thing}").html(window.timer[thing]())

  window.ticker.addSubscriber window.timerDisplay

  setInterval (=> window.ticker.fire()), 1000
)
