# use @info "message" for logging!

module LinearPathwayPage

using GenieFramework
using PlotlyBase
using Main.LinearPathway

@genietools

function trajectory_layout(config::Dict{Symbol, Any})
    off_minute = step_to_minutes(config[:input_2_turn_off_step])
    on_minute = step_to_minutes(config[:input_2_turn_on_step])
    title = "Input 2: off at $off_minute minutes, on at $on_minute minutes."
    PlotlyBase.Layout(; title = title)
end

function trajectory_traces(config::Dict{Symbol, Any})
    # x = trajectory(config)[:x]
    # time_range = collect(range(start = 0, stop = 100, length = length(x[:, 1])))

    # trace1 = scatter(x=time_range, y = x[:, 1], mode = "lines", name = "G6P")
    # trace2 = scatter(x=time_range, y = x[:, 2], mode = "lines", name = "FBP")
    # trace3 = scatter(x=time_range, y = x[:, 3], mode = "lines", name = "3-PGA")
    # trace4 = scatter(x=time_range, y = x[:, 4], mode = "lines", name = "PEP")
    # trace5 = scatter(x=time_range, y = x[:, 5], mode = "lines", name = "Pyruvate")

    # [trace1, trace2, trace3, trace4, trace5]

    @info "trajectory_traces(): $(string(config))"
    inputs = trajectory(config)[:inputs]
    @info "trajectory_traces(): $(inputs[config[:input_2_turn_off_step]-1, 2]) -> $(inputs[config[:input_2_turn_off_step]+1, 2])"

    time_range = collect(range(start = 0, stop = 100, length = length(inputs[1:10:end, 2])))
    trace1 = PlotlyBase.scatter(x=time_range, y=inputs[1:10:end, 2], mode="lines", name="Input 2")
    [trace1]
end

@app begin
    initial_config = fig_5a_defaults()
    initial_input2OffMinute = step_to_minutes(initial_config[:input_2_turn_off_step])
    initial_input2OnMinute = step_to_minutes(initial_config[:input_2_turn_on_step])

    @in minuterange = RangeData(initial_input2OffMinute:initial_input2OnMinute)

    @out input2OffMinute = 10
    @out input2OnMinute = 60
    @out layout = trajectory_layout(initial_config)
    @out traces = trajectory_traces(initial_config)

    @onchange minuterange begin
        input2OffMinute = minuterange["min"]
        input2OnMinute = minuterange["max"]

        new_config = fig_5a_defaults()
        new_config[:input_2_turn_off_step] = minutes_to_step(input2OffMinute)
        new_config[:input_2_turn_on_step] = minutes_to_step(input2OnMinute)
        traces = trajectory_traces(new_config)
        layout = trajectory_layout(new_config)

        @info "@onchange minuterange $(string(traces))"
    end
end

function ui()
    [
        a("Return to demonstration list", href = "/"),
        h4("Linear pathway!"),
        p("Select Input 2 availability (in minutes):"),
        plot(:traces, layout = :layout),
        GenieFramework.range(5:5:90, :minuterange, label = true),
        p("Input 2 turns off at {{input2OffMinute}} minutes and turns on at {{input2OnMinute}} minutes.")
    ]
    
end

@page("/linear", ui)
end
