module LinearPathwayPage
using GenieFramework
@genietools

function ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Linear pathway!")
    ]
    
end

@page("/linear", ui)
end
