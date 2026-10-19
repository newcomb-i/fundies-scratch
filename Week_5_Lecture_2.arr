use context dcic2024
import math as M
import statistics as S

#|
   filter-with
   transform-column
   t.row-n
   t.lengthh
   
   linked-list
|#

cafe-data = 
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

sales = cafe-data.get-column("drinks-sold")

#some basic stats
M.max(sales)
S.mean(sales)
S.median(sales)
M.sum(sales)

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]
unique-codes = distinct(discount-codes) 

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end
real-codes = filter(is-real-code, unique-codes)
first-code = real-codes.get(0)
lower-codes = map(string-to-lower, real-codes)

#|new-lower-codes = map(string-to-lower, discount-codes)

new-real-codes = map(is-real-code, new-lower-codes)

new-first-code = new-real-codes.get(0)
|#

distinct(filter(is-real-code, map(string-to-lower, discount-codes)))
#dis

#to sort a list in acccending order
sales.sort()
#to sort a list in decending order
sales.sort().reverse()

#variables that can change
var total = 1
total := total + 10
total # -> 11

fun my-sum(num-list :: List) -> Number block:
  doc: "a decent docstring here..."
  var running = 0
  for each(n from num-list):
    running := running + n
  end
  running
  where: 
  my-sum([list: 0, 1, 2, 3]) is 6
  my-sum([list: ]) is 0
end

my-sum(sales)

#produce a new list
fun add-two(numbers :: List<Number>) -> List<Number> block:
  doc: "adds two to each number if a list"
  var added-two = [list: ]
  for each(n from numbers):
    added-two := added-two.append([list: n + 2])
  end
  added-two
where:
  add-two([list: 1, 2, 3]) is [list: 3, 4, 5]
end

fun vat-amounts(prices :: List<Number>) -> List<Number> block: 
  doc: "returns the 20% VAT on each price in a list"
  var vats = [list: ]
  for each(p from prices):
    vats := vats.append([list: p * 0.2])
  end
  
  vats
  
fun vat-amounts(prices :: List<Number>) -> List<Number> block: 
  doc: "returns the 20% VAT on each price in a list"
    var final-prices [list: ]
  for each(p from prices):
        final-prices:= vats.append([list: p * 0.2])
  end
where: 
  vats-amounts([list: 10, 50, 100] is [list: 2, 10, 20])
  vat-amounts([list: ]) is [list: ]
end
final-prices
where:
with-vat([list: 10, 50, 100]) is [list: 12, 60, 120]
with-vat([list: ]) is [list: ]
end

with-vat(sales)

#with lambda
map(lam(p): p + (p * 0.2) end, sales)

#fold: the loop template without the var
#fold :: (f :: (Basm Elt -> Base), base :: tst :: List <Elt>) ->

#three imputs:
#a starting value
#a rule
#the list

fun my-sum-fold(num-list :: List<Number>) -> Number:
  doc: "a good doctring here..."
  fold(lam(acc, n): acc + n end, 0, num-list)
where:
  my-sum-fold([list: 0, 1, 2, 3]) is 6
  my-sum-fold([list: ]) is 0
end

#| fold(lam(acc, n): acc + n end, 0, [list 45, 30, 55] #130
   
   answers so far: 0, 45, 75
   next item: 45, 30, 55
   mew ans