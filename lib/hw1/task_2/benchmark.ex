defmodule AlgoPrac.Hw1.Task2.Benchmark do
  @moduledoc """
  Runs `Benchee` doubling experiments (`n`, `2n`, `4n`, `8n`) on `AlgoPrac.Hw1.Task2.Xor`
  functions, prints `T(2n) / T(n)` ratios, and builds a log-log VegaLite chart.
  """

  import Benchee, only: [run: 2]

  alias AlgoPrac.Hw1.Task2.Xor

  @n 10 ** 2

  @start_n %{
    b: 10,
    d: 10,
    g: 10,
    j: 10
  }

  @labels %{
    b: "(b) log2(n)",
    d: "(d) n * 100",
    g: "(g) ~ n^3",
    j: "(j) n * log2(n) + n"
  }

  @doc """
  Benchmarks all sample functions (`:b`, `:d`, `:g`, `:j`) on a single `@n`.
  """
  @spec run_all() :: :ok
  def run_all do
    bench(all_funcs(), inputs: %{"#{@n}" => @n})
    :ok
  end

  @doc """
  Runs a doubling benchmark (`n`, `2n`, `4n`, `8n`) for
  the given function, prints its `T(2n) / T(n)` ratios, and returns the Benchee suite.
  """
  @spec run(:b | :d | :g | :j) :: Benchee.Suite.t()
  def run(f_name) when f_name in [:b, :d, :g, :j] do
    "\nfunc [#{f_name}] -> \n" |> String.upcase() |> IO.puts()

    funcs  = %{"#{f_name}" => f(f_name)}
    inputs = doubling_inputs(@start_n[f_name])

    funcs
    |> bench(inputs: inputs)
    |> print_ratios()
  end

  @doc """
  Runs doubling benchmarks for `funcs` and returns formatted data points for VegaLite.
  """
  @spec plot_data([:b | :d | :g | :j]) :: [%{String.t() => String.t() | number()}]
  def plot_data(funcs \\ [:b, :d, :g, :j]) do
    Enum.flat_map(funcs, fn f_name ->
      %Benchee.Suite{scenarios: scenarios} = run(f_name)

      Enum.map(scenarios, fn scenario ->
        %{
          "function" => @labels[f_name],
          "n"        => scenario.input,
          "time_ns"  => scenario.run_time_data.statistics.median
        }
      end)
    end)
  end

  defp f(f_name) do
    Function.capture(Xor, f_name, 1)
  end

  defp doubling_inputs(n) do
    %{
      "(n)"     => n,
      "(n x 2)" => n * 2,
      "(n x 4)" => n * 4,
      "(n x 8)" => n * 8
    }
  end

  defp all_funcs do
    %{
      @labels[:b] => f(:b),
      @labels[:d] => f(:d),
      @labels[:g] => f(:g),
      @labels[:j] => f(:j)
    }
  end

  defp bench(funcs, extra_opts) do
    opts =
      Keyword.merge(
        [
          print: [
            benchmarking:  false,
            configuration: false,
            fast_warning:  false
          ],
          time:        3,
          memory_time: 1
        ],
        extra_opts
      )

    run(funcs, opts)
  end

  defp print_ratios(%Benchee.Suite{} = suite) do
    %Benchee.Suite{scenarios: scenarios} = suite

    sorted = Enum.sort_by(scenarios, & &1.input)

    IO.puts("\nDoubling ratios T(2n) / T(n):")

    sorted
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.each(fn [prev, curr] ->
      t1 = prev.run_time_data.statistics.median
      t2 = curr.run_time_data.statistics.median

      ratio = Float.round(t2 / t1, 2)

      IO.puts("#{prev.input_name} (#{prev.input})\t-> #{curr.input_name} (#{curr.input}): #{ratio}x")
    end)

    suite
  end
end
