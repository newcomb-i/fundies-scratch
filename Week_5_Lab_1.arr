use context dcic2024

include csv
include data-source

#exercise 1
flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier:: Number,
  flight :: Number,
  tailnum :: Number,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String

  source: csv-table-file("flights(1).csv", default-options)

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

fun is_long_flight(row :: Row) -> Boolean:
  row["distance"] >= 1500
end

long-flights = filter-with(flights, is_long_flight)

sorted-long-flights = order-by(long-flights, "air_time", false)

top-row = sorted-long-flights.row-n(0)

top-carrier = top-row["carrier"]
top-origin = top-row["origin"]
top-dest = top-row["dest"]

top-carrier
top-origin
top-dest

#exercise 2
fun is_delayed_departure(row :: Row) -> Boolean:
  doc: "True if the departure delay is at least 30 minutes"
  row["dep_delay"] >= 30
end

fun is_morning_sched_dep(row :: Row) -> Boolean:
  doc: "True if the scheduled departure is before noon"
  row["sched_dep_time"] < 1200
end

delayed = filter-with(flights, lam(r): r["dep_delay"] >= 30 end)
morning = filter-with(delayed, lam(r): r["sched_dep_time"] < 1200 end)
far = filter-with(morning, lam(r): r["distance"] > 500 end)
worst = order-by(far, "dep_delay", false)

w = worst.row-n(0)
w["flight"]
w["origin"]
w["dep_delay"]

#exercise 3
fixed-dep = transform-column(flights, "dep_delay",
  lam(v): if v < 0: 0 else: v end end)
fixed-both = transform-column(fixed-dep, "arr_delay",
  lam(v): if v < 0: 0 else: v end end)

with-speed = build-column(fixed-both, "effective_speed",
  lam(r):
    if r["air_time"] > 0:
      r["distance"] / (r["air_time"] / 60)
    else:
      0
    end
  end)

by-speed = order-by(with-speed, "effective_speed", false)
f = by-speed.row-n(0)
f["carrier"]
f["origin"]
f["dest"]

#exercise 4
fun apply-arrival-discount(t :: Table) -> Table:
  doc: "Reduces arr_delay by 20% when 0 <= arr_delay <= 45"
  transform-column(t, "arr_delay",
    lam(v):
      if (v >= 0) and (v <= 45):
        v * 0.8
      else:
        v
      end
    end)
where:
  test-t = table: arr_delay
    row: -10
    row: 0
    row: 30
    row: 60
  end
  expected = table: arr_delay
    row: -10
    row: 0
    row: 24
    row: 60
  end
  apply-arrival-discount(test-t) is expected
end

discounted = apply-arrival-discount(flights)

scored = build-column(discounted, "on_time_score",
  lam(r):
    dep = num-max(0, r["dep_delay"])
    arr = num-max(0, r["arr_delay"])
    raw = 100 - (dep - arr) - (r["air_time"] / 30)
    if raw < 0: 0 else: raw end
  end)

# Sort by the tie-breaker first, then the main key
by-distance = order-by(scored, "distance", true)
ranked = order-by(by-distance, "on_time_score", false)

first = ranked.row-n(0)
second = ranked.row-n(1)
first["carrier"]
first["flight"]
first["origin"]
first["dest"]
second["carrier"]
second["flight"]
second["origin"]
second["dest"]