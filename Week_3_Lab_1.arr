use context starter2024
import file("lab2-support.arr") as support

#problem 1
support.encryptor1("Hello, World!")
support.encryptor1("Ahoy, World! ")

#Repeats the word 5 times

fun my-encryptor1(s :: String) -> String:
  string-repeat(s, 5)
end

support.test-encryptor1(my-encryptor1)

#problem 2
support.encryptor2("Hello, World!")
support.encryptor2("Northeastern")

#subtrings 0-4

fun my-encryptor2(s :: String) -> String:
  string-substring(s, 0, 4)
end

support.test-encryptor2(my-encryptor2)

#problem 3

support.encryptor3("Hello, World!")
support.encryptor3("In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters. And God said, 'Let there be light,' and there was light. God saw that the light was good, and he separated the light from the darkness. God called the light 'day,' and the darkness he called 'night.' And there was evening, and there was morning—the first day.")

#Replaces periods with exclamation points

fun my-encryptor3(s :: String) -> String:
  string-replace(s, ".", "!")
end

support.test-encryptor3(my-encryptor3)

#problem 4

support.encryptor4("Hello, World!")
support.encryptor4("In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters. And God said, 'Let there be light,' and there was light. God saw that the light was good, and he separated the light from the darkness. God called the light 'day,' and the darkness he called 'night.' And there was evening, and there was morning—the first day.")

#subtrings 0-4 and repeat 5 times
fun my-encryptor4(s :: String) -> String:
  string-repeat(string-substring(s, 0, 4), 5)
end

support.test-encryptor4(my-encryptor4)

#Problem 5 
support.encryptor5("Hello, World!")
support.encryptor5("In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters. And God said, 'Let there be light,' and there was light. God saw that the light was good, and he separated the light from the darkness. God called the light 'day,' and the darkness he called 'night.' And there was evening, and there was morning—the first day.")

#Replaces all vowels to the following letter 

fun my-encryptor5(s :: String) -> String:
  s1 = string-replace(s, "a", "b")
  s2 = string-replace(s1, "e", "f")
  s3 = string-replace(s2, "i", "j")
  s4 = string-replace(s3, "o", "p")
  s5 = string-replace(s4, "u", "v")
  s6 = string-replace(s5, "A", "B")
  s7 = string-replace(s6, "E", "F")
  s8 = string-replace(s7, "I", "J")
  s9 = string-replace(s8, "O", "P")
  string-replace(s9, "U", "V")
end

support.test-encryptor5(my-encryptor5)


#Problem 6
support.encryptor6("Hello, World!")
support.encryptor6("In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters. And God said, 'Let there be light,' and there was light. God saw that the light was good, and he separated the light from the darkness. God called the light 'day,' and the darkness he called 'night.' And there was evening, and there was morning—the first day.")

#Puts all upcase letters lowercase and removes "r's"

fun my-encryptor6(s :: String) -> String:
  string-replace(string-to-lower(s), "r", "")
end

support.test-encryptor6(my-encryptor6)

#Problem 7
support.encryptor7("Hello, World!")
support.encryptor7("In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters. And God said, 'Let there be light,' and there was light. God saw that the light was good, and he separated the light from the darkness. God called the light 'day,' and the darkness he called 'night.' And there was evening, and there was morning—the first day.")

#Counted the number of characters in the sentance and displayed it

fun my-encryptor7(s :: String) -> Number:
  string-length(s)
end

support.test-encryptor7(my-encryptor7)

#Problem 8
support.encryptor8("Hello, World!")
support.encryptor8("In the beginning. ")

#ends every sentance with 3 exclimation points and repeats the sentance

fun my-encryptor8(s :: String) -> String:
  string-repeat(string-append(s, "!!!"), 3)
end

support.test-encryptor8(my-encryptor8)

#Problem 9
support.encryptor9("Hello, World!")
support.encryptor9(" ")
support.encryptor9("a")
support.encryptor9("A")

#takes first character and displays the ascii number for it, ignores the rest

fun my-encryptor9(s :: String) -> Number:
  string-to-code-point(string-substring(s, 0, 1))
end

support.test-encryptor9(my-encryptor9)

#Problem 10
support.encryptor10("Hello, World!")
support.encryptor10("Northeastern")
support.encryptor10("ISABELLA")
support.encryptor10("Clemson ")

#all lower case, substring 0-4, replace vowels with next letter

fun my-encryptor10(s :: String) -> String:
  lower = string-to-lower(s)
  substring = string-substring(lower, 0, 4)
  s1 = string-replace(substring, "a", "b")
  s2 = string-replace(s1, "e", "f")
  s3 = string-replace(s2, "i", "j")
  s4 = string-replace(s3, "o", "p")
  s5 = string-replace(s4, "u", "v")
  s5
end

support.test-encryptor10(my-encryptor10)





