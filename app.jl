module App
using Main.StatisticAnalysis
using GenieFramework, PlotlyBase
@genietools

@app begin
    #reactive code goes here
end

function ui()
    p("") #initialized to an empty paragraph
end

@page("/", ui)
end
