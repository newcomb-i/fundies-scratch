use context dcic2024
include csv
include data-source

#Task 1
#|1. Load the table and turn number columns into numbers
  2. Blank tailnum -> "UNKNOWN"
  3. Negative delays -> 0
  4. Make a key for each flight: flight-CARRIER-HH:MM
  5. Count the keys. A count of 2 or more = duplicate
  6. Add the full airline name
  7. Remove outliers
  8. Draw 3 charts
  9. Get total, average and max distance with a loop
|#

#Task 2
# Load the csv into a table called flights_53.
flights_53 =
  load-table: rownames, dep_time, sched_dep_time, dep_delay, arr_time, sched_arr_time, arr_delay, carrier, flight, tailnum, origin, dest, air_time, distance, hour, minute, time_hour
    source: csv-table-file("flights_sample53.csv", default-options)
      
      #| csv stores everything as text
         sanitizer turn the columns into numbers
      |#
    sanitize rownames using num-sanitizer
    sanitize dep_time using num-sanitizer
    sanitize sched_dep_time using num-sanitizer
    sanitize dep_delay using num-sanitizer
    sanitize arr_time using num-sanitizer
    sanitize sched_arr_time using num-sanitizer
    sanitize arr_delay using num-sanitizer
    sanitize flight using num-sanitizer
    sanitize air_time using num-sanitizer
    sanitize distance using num-sanitizer
    sanitize hour using num-sanitizer
    sanitize minute using num-sanitizer
  end

#Blank tailnum -> "UNKNOWN"
fun blank-to-unknown(s :: String) -> String:
  doc: "if s is empty, return UNKNOWN, otherwise return s"
  if s == "":
    "UNKNOWN"
  else:
    s
  end
  
#examples that test the function
where:
  blank-to-unknown("") is "UNKNOWN"
  blank-to-unknown("N123") is "N123"
end

# transform-column runs the function on every value in the tailnum column
step1 = transform-column(flights_53, "tailnum", blank-to-unknown)

#| A negative delay means the flight
   was early -> count it as 0
|#
fun neg-to-zero(n :: Number) -> Number:
  doc: "if n is below 0, return 0, otherwise return n"
  if n < 0:
    0
  else:
    n
  end
where:
  neg-to-zero(-5) is 0
  neg-to-zero(7) is 7
end

#|Applies the function to both delay 
   columns one after the other
|#
step2 = transform-column(step1, "dep_delay", neg-to-zero)
cleaned = transform-column(step2, "arr_delay", neg-to-zero)

#| # The key joins flight: carrier and time
   example: (1997-DL-14:55)
   Two rows with the same key are the same flight
|#

# Removes spaces so " b6 " becomes "b6"
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
where:
  trim(" UA ") is "UA"
end

#| Makes a number into text with 2 digits
   example: 5 becomes 05
|#
fun two-digits(n :: Number) -> String:
  doc: "turn a number into text with 2 digits"
  if n < 10:
    "0" + num-to-string(n)
  else:
    num-to-string(n)
  end
where:
  two-digits(5) is "05"
  two-digits(17) is "17"
end

#Turns a time like 517 into 05:17
fun format-time(t :: Number) -> String:
  doc: "turn a time like 517 into text like 05:17"
  hours = num-floor(t / 100)      # 517 / 100 -> 5
  minutes = num-modulo(t, 100)    # leftover -> 17
  two-digits(hours) + ":" + two-digits(minutes)
where:
  format-time(517) is "05:17"
  format-time(1800) is "18:00"
end

#|Builds the key for one row by 
  joining three pieces of text with "-"
|#
fun make-key(r :: Row) -> String:
  doc: "make a key like 1997-DL-14:55 from one row"
  flight-text = num-to-string(r["flight"]) # flight number as text
  carrier-text = string-to-upper(trim(r["carrier"])) # no spaces, capitals
  time-text = format-time(r["dep_time"]) # time as HH:MM
  flight-text + "-" + carrier-text + "-" + time-text
end

#| build-column adds a new column called dedup_key 
   using make-key on each row
|#
with-key = build-column(cleaned, "dedup_key", lam(r): make-key(r) end)


# count makes a table of each key and how many times it appears
key-counts = count(with-key, "dedup_key")

# keep only keys that appear more than once
duplicates = filter-with(key-counts, lam(r): r["count"] > 1 end)


#Task 3

#| Turns a carrier code into the full airline name
   example: UA -> United Airlines
|#
fun carrier-to-airline(code :: String) -> String:
  doc: "turn a carrier code into the airline name"
  if code == "UA":
    "United Airlines"
  else if code == "AA":
    "American Airlines"
  else if code == "B6":
    "JetBlue"
  else if code == "DL":
    "Delta Air Lines"
  else if code == "EV":
    "ExpressJet"
  else if code == "WN":
    "Southwest Airlines"
  else if code == "OO":
    "SkyWest Airlines"
  else:
    "Other" #any code not listed above
  end
  
where:
  carrier-to-airline("UA") is "United Airlines"
  carrier-to-airline("ZZ") is "Other"
end

#| Add an "airline" column
   clean the carrier first 
   example: " wn " matches "WN"
|#
with-airline = build-column(with-key, "airline",
  lam(r): carrier-to-airline(string-to-upper(trim(r["carrier"]))) end)


#| Remove outliers: values too big to be real
   The data has air_time 2000 and 3000 and distance 10000    and 20000.
   filter-with keeps only rows where test is true
|#
final = filter-with(with-airline,
  lam(r): (r["distance"] <= 5000) and (r["air_time"] <= 500) end)

#Task 4

# Bar chart: how many flights each airline has
freq-bar-chart(final, "airline")

# Histogram: how distances are spread out (bins of 100 miles)
histogram(final, "distance", 100)

# Scatter plot: each dot is a flight, distance across, air_time up
scatter-plot(final, "distance", "air_time")


# get the distance column as a list
distances = final.get-column("distance")

# Total: start at 0, add each distance to it
fun total-distance(lst :: List<Number>) -> Number block:
  doc: "add up all the numbers in the list"
  var total = 0
  for each(d from lst):
    total := total + d
  end
  total
where:
  total-distance([list: 1, 2, 3]) is 6
end

# Max: start with the first one, replace it if we see a bigger one
fun max-distance(lst :: List<Number>) -> Number block:
  doc: "find the biggest number in the list"
  var biggest = lst.first
  for each(d from lst):
    when d > biggest:
      biggest := d
    end
  end
  biggest
where:
  max-distance([list: 4, 9, 2]) is 9
end

# Average: total divided by how many there are
fun average-distance(lst :: List<Number>) -> Number:
  doc: "total divided by the number of items"
  total-distance(lst) / length(lst)
where:
  average-distance([list: 2, 4]) is 3
end

total-distance(distances)
average-distance(distances)
max-distance(distances)
