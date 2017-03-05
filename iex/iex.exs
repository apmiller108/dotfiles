Application.put_env(:elixir, :ansi_enabled, true)
IEx.configure(
  colors: [
    eval_result: [:green, :bright],
    eval_error:  [[:red, :bright]],
    eval_info:   [:yellow, :bright],
  ],
  default_prompt: [
    "\e[G",    # ANSI CHA, move cursor to column 1
    :green,
    "%prefix",:white,"|",
    :blue,
    "%counter",
    :white,
    "|",
    :blue,
    ">",
    :white,
    ">>",
    :reset
  ] 
  |> IO.ANSI.format |> IO.chardata_to_string
)
