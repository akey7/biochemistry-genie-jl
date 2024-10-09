module LinearPathwayPage
using GenieFramework
@genietools

@app begin
    @in Range_r = RangeData(1:5)
end

function ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Linear pathway!"),
        p("Select Input 2 availability:"),
        GenieFramework.range(1:1:30, :Range_r, label = true)
    ]
    
end

@page("/linear", ui)
end
