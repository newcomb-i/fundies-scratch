use context dcic2024
include csv 
include data-source
include tables
import statistics as S

#problem 1 

fun leap-year(year :: Number) -> Boolean:
  doc: "determins if a given year is a leap year"
  ((num-modulo(year, 4) == 0) and (num-modulo(year, 100) <> 0)) or ((num-modulo(year, 400) == 0))
where:
  leap-year(2000) is true
  leap-year(1900) is false
  leap-year(2024) is true
  leap-year(2023) is false
end

#problem 2

fun second-tick(seconds :: Number) -> Number:
  doc: "takes a number of seconds and returns the next second as if a clock were ticking." 
  if seconds < 59:
    seconds + 1
  else if seconds == 59:
    0
  else:
    raise("not valid")
  end
where: 
  second-tick(24) is 25
  second-tick(59) is 0
  second-tick(1) is 2
end

#problem 3

fun rock-paper-scissors(player1 :: String, player2 :: String) -> String: 
  doc: "determines the winner of a Rock, paper, scissors game."
  if (player1 == 'rock') and (player2 == 'scissors'):
    "player1 wins"
  else if (player1 == 'scissors') and (player2 == 'paper'):
    "player1 wins"
  else if (player1 == 'paper') and (player2 == 'rock'):
    "player1 wins"   
  else if (player2 == 'rock') and (player1 == 'scissors'):
    "player2 wins"
  else if (player2 == 'scissors') and (player1 == 'paper'):
    "player2 wins"
  else if (player2 == 'paper') and (player1 == 'rock'):
    "player2 wins"   
  else if player1 == player2:
    "its a draw"
  else:
    "invalid choice"
  end
where:
  rock-paper-scissors('rock', 'scissors') is "player1 wins"
  rock-paper-scissors('scissors', 'rock') is "player2 wins"
  rock-paper-scissors('paper', 'paper') is "its a draw"
  rock-paper-scissors('lalalala', 'kjcudoiqqb') is "invalid choice"  
end

#problem 4
planets = table: planet :: String, distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

mars = planets.row-n(3)
mars-distance = mars["distance"]
planets

#problem 5
something = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-url("https://raw.githubusercontent.com/newcomb-i/LCSCI4207-lab2/refs/heads/main/boe_rates.csv", default-options)
  sanitize rate using num-sanitizer
end

total-rows = something.length()
rates = something.get-column("rate")
median-rate = S.median(rates)
mode-rate = S.modes(rates)
asc-table = something.order-by("rate", true)
desc-table = something.order-by("rate", false)
min-rate = asc-table.row-n(0)["rate"]
max-rate = desc-table.row-n(0)["rate"]

total-rows
median-rate
mode-rate
min-rate
max-rate
