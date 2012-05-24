($ ->
  window.ticker = new Tick
  dat_timer = new Timer
  window.ticker.addSubscriber dat_timer
  setInterval (=> window.ticker.fire()), 1000
)
