module LinearPathwayPage
using GenieFramework
@genietools

function ui()
    [
        h4("Linear pathway!")
    ]
    
end

@page("/linear", ui)
end
