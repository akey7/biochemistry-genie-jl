module App
using Main.StatisticAnalysis
using GenieFramework, PlotlyBase
@genietools

@app begin
    @out trace1 = [histogram(x=[])]
    @out trace2 = [PlotlyBase.scatter(x=[1,2,3], y=[1,2,3])]
    @out layout1 = PlotlyBase.Layout(title="Histogram plot")
    @out layout2 = PlotlyBase.Layout(title="Line plot")
    @in N = 0
    @out m = 0.0
    @onchange N begin
        x = gen_numbers(N)
        m = calc_mean(x)
        trace1 = [histogram(x=x)]
    end
end

function ui()
    row([
    cell(class="st-col col-6", [
        h1("A simple dashboard"),
        slider(1:1000, :N),
        p("The average of {{N}} random numbers is {{m}}", class="st-module"),
        plot(:trace1, layout=:layout1),
        plot(:trace2, layout=:layout2)
    ])
])
end


@page("/", ui)
end
