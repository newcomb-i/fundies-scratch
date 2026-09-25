use context starter2024
#Cost for 5 identical custom T‑shirts
(5 * 12) + 3

#Cost for 7 identical custom T‑shirts
(7 * 12) + 3

#Rectangular Poster
2 * (420 + 594)

#£0.10 per mm
2 * (420 + 594) * 0.10

#No parethesis gives an error "The * and + operations are at the same grouping level. Add parentheses to group the operations, and make the order of operations clear." 

#Strings
"Designs for everyone!"
"red" + "blue"

#Traffic Light
above(
  overlay(
    above(circle(20, "solid", "red"),
          above(circle(20, "solid", "yellow"),
                circle(20, "solid", "green"))),
    rectangle(40, 100, "solid", "black")),
  rectangle(20, 60, "solid", "gray"))

#Broken Code Fixes
rectangle(50, 20, "solid", "black")
circle(30, "solid", "red")

#Flag
overlay(
  circle(40, "solid", "red"),
  beside(
    rectangle(60, 200, "solid", "white"),
    rectangle(300, 200, "solid", "blue")))

#Shield
overlay(
  star(50, "solid", "gold"),
  rotate(45, square(120, "solid", "gray"))
)