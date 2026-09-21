use context starter2024
#5 identical t-shirt designs
(12 * 5) + 3

#7 identical T-shirts for a design.
(12 * 7) + 3

# the difference was $24

#perimeter of poster
2 * (420  + 594)

#cost of poster
(2 * (420  + 594)) * 0.10

#if you foget the oarethesis the program will do the problem in the wrong order or give an error

#Saving a Tagline
string-tagline = "Designs for everyone!"
string-tagline

#Colour Inventory
string-red = "red"
string-blue = "blue"
string-gold = "gold"

string-red
string-blue
string-gold 

(string-red + string-blue)

# (1 + string-blue) doesnt work becuase it is using a string and a numerical value, i would need to make the "1" into a string for this to work 

#Make a Traffic Light frame
above(overlay-align("middle", "middle", above(circle(20, "solid", "red"), above(circle(20, "solid", "yellow"), circle(20, "solid", "green"))), rectangle(50, 130, "solid", "black")),rectangle(10,60,"solid","grey"))

#Broken Code Hunt
# Goal: A rectangle with width 50 and height 20, solid black
rectangle(50, 20, "solid", "black")

#Broken code cirle
circle(30, "solid", "red")

#Invented a simple flag design
overlay-align("middle", "middle",
  overlay-align("middle", "middle",
    star(30, "solid", "blue"),
    circle(40, "solid", "red")),
  rectangle(200, 120, "solid", "white"))

#sheild

overlay(circle(30,"solid","red"), rotate(45, square(100, "solid", "gray")))