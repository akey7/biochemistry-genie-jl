module LinearPathwayPage

using GenieFramework
using PlotlyBase
using Main.LinearPathway

@genietools

function trajectory_layout(config::Dict{Symbol, Any})
    off_minute = step_to_minutes(config[:input_2_turn_off_step])
    on_minute = step_to_minutes(config[:input_2_turn_on_step])
    title = "Input 2: off at $off_minute minutes, on at $on_minute minutes."
    
    PlotlyBase.Layout(title = title)
end

function trajectory_traces(config::Dict{Symbol, Any})
    x = trajectory(config)[:x]
    time_range = collect(range(start = 0, stop = 100, length = length(x[:, 1])))

    trace1 = scatter(x=time_range, y = x[:, 1], mode = "lines", name = "G6P")
    trace2 = scatter(x=time_range, y = x[:, 2], mode = "lines", name = "FBP")
    trace3 = scatter(x=time_range, y = x[:, 3], mode = "lines", name = "3-PGA")
    trace4 = scatter(x=time_range, y = x[:, 4], mode = "lines", name = "PEP")
    trace5 = scatter(x=time_range, y = x[:, 5], mode = "lines", name = "Pyruvate")

    [trace1, trace2, trace3, trace4, trace5]
end

@app begin
    initial_config = fig_5a_defaults()
    initial_input_2_off_minute = step_to_minutes(initial_config[:input_2_turn_off_step])
    initial_input_2_on_minute = step_to_minutes(initial_config[:input_2_turn_on_step])

    @in Range_r = RangeData(initial_input_2_off_minute:initial_input_2_on_minute)

    @out input_2_off_minute = 10
    @out input_2_on_minute = 60
    @out layout = trajectory_layout(initial_config)
    @out traces = trajectory_traces(initial_config)

    @onchange Range_r begin
        input_2_off_minute = Range_r["min"]
        input_2_on_minute = Range_r["max"]
    end
end

function ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Linear pathway!"),
        p("Select Input 2 availability (in minutes):"),
        plot(:traces, layout = :layout),
        GenieFramework.range(5:5:90, :Range_r, label = true),
        p("Input 2 turns off at {{input_2_off_minute}} minutes and turns on at {{input_2_on_minute}} minutes.")
    ]
    
end

@page("/linear", ui)
end
