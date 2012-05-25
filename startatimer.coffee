($ ->
  window.ticker = new Tick
  window.timer = new Timer
  window.ticker.addSubscriber window.timer

  window.timerDisplay =
    tick: ->
      for thing in ["seconds", "minutes", "hours", "days"]
        $("\##{thing}").html(window.timer[thing]())

  window.ticker.addSubscriber window.timerDisplay

  $('#headline h2').hide()
  $('#headline').hover (->
    $('#headline h2').show()), (->
    $('#headline h2').hide())

  $('#headline h1').click ->
    old = $(this).html()
    headline = (prompt "New Headline: ") or old
    $(this).html headline

  $('#restart').click ->
    window.timer.reset()

  $('body').keydown (e) ->
    if e.which == 13
      time = (prompt "Set seconds elapsed: ") or 0
      window.timer.total_seconds = time

  setInterval (=> window.ticker.fire()), 1000
)
