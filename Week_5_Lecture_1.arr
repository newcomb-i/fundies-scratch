use context dcic2024
include csv
include data-source
#|
   plan a task before coding it
   finding and cleaning dirty data
   visualization
|#

#task plan is a to-do list you can check off
#|
   input = the columns you start from
   output = a compcrete exple of what you want at the end
   steps = small enough tthat each one is a single function or table operation
   tools = the operation for each step: filter-with, transform-column 
   
|#

#load voters data
voter-data = load-table: VoterID, DOB, Party, Address, City, Country, Postcode
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options)
end

#confirm the party problem
filter-with(voter-data, lam(r): r["Party"] == "Laboour" end).length() #=>

voter-data.row-n(3)["Party"] # => Labour

order-by(count(voter-data, "Party"), "count", false)

#reading one value with get-column 
fun get-column(r :: Row, colname :: String):
  doc: "returns the value in row r for the column colname"
  r[colname]
where:
  get-column(voter-data.row-n(3), "Party") is "Labuor"
  get-column(voter-data.row-n(0), "VoterID") is "1"
end

filter-with(voter-data, lam(r): get-column(r, "Party") == "Labour" end).length()
# 4

get-column(voter-data.row-n(3), "Party")
# "Labuor"

with-year = build-column(voter-data, "BirthYear",
  lam(r): string-substring(get-column(r, "DOB"), 6, 10) end)

get-column(with-year.row-n(0), "BirthYear")
# "1980"

#fixing the typo
fun fix-labour(s :: String) -> String:
  doc: "corrects the one known misspelling of Labour"
  if s == "Labuor" : "Labour"  #misspelling of labour party
  else if s == "" : "No Party" #fill on missing values with 'No Party'
  else: s
  end
where:
  fix-labour("Labour") is "Labour"
  fix-labour("") is "No Party"
  fix-labour("Green Party") is "Green Party"
end

#try using transform-column
fixed = transform-column(voter-data, "Party", fix-labour)

freq-bar-chart(fixed, "Party")