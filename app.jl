module App

using GenieFramework
@genietools

@app begin
  @in foo = "Genie"
end

function ui()
  [
    h1("My First Genie App")
    input("Enter your name", :foo)
    p("Hello {{foo}}!")
  ]
end

@page("/", ui)
end
