defmodule AlgoPrac.Hw1.Task2.Plot do
  alias VegaLite, as: Vl

  def build(data) do
    Vl.new(width: 650, height: 400, title: "Plot of T (n) vs n on log–log axes")
    |> Vl.data_from_values(data)
    |> Vl.mark(:line, point: true)
    |> Vl.encode_field(:x, "n",
      type:  :quantitative,
      scale: [type: :log],
      title: "N"
    )
    |> Vl.encode_field(:y, "time_ns",
      type:  :quantitative,
      scale: [type: :log],
      title: "T(N)"
    )
    |> Vl.encode_field(:color, "function",
      type:  :nominal,
      title: "Complexity"
    )
    |> VegaLite.Convert.save!("tmp/plot_#{System.system_time(:second)}.svg")
  end
end
