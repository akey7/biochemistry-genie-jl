module App

using GenieFramework

@genietools

@app begin
    @in name = "Genie"
end

function ui()
    [
        h1("My first Genie app")
        input("Enter your name", :name)
        p("Hello {{message}}")
    ]
end

@page("/", ui)

end