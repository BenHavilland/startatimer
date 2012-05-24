($ ->
  window.ticker = new Tick
  window.timer = new Timer
  window.ticker.addSubscriber window.timer

  window.timerDisplay =
    tick: ->
      for thing in ["seconds", "minutes", "hours", "days"]
        $("\##{thing}").html(window.timer[thing]())

  window.ticker.addSubscriber window.timerDisplay

  $('#headline h1').click ->
    old = $(this).html()
    headline = (prompt "New Headline: ") or old
    $(this).html headline

  $('#restart').click ->
    window.timer.reset()

  setInterval (=> window.ticker.fire()), 1000
)
