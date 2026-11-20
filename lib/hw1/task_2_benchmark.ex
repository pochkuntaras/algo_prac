defmodule AlgoPrac.Hw1.Task2Benchmark do
  @moduledoc """
  Runs `Benchee` doubling experiments (`n`, `2n`, `4n`, `8n`) on `AlgoPrac.Hw1.Task2Xor`
  functions and prints the resulting `T(2n) / T(n)` execution time ratios.
  """

  import Benchee, only: [run: 2]

  @n 10 ** 2

  @start_n %{
    b: 1_000_000,
    d: 1_000,
    g: 25,
    j: 2_000
  }

  alias AlgoPrac.Hw1.Task2Xor

  @doc """
  Benchmarks all sample functions (`:b`, `:d`, `:g`, `:j`).
  """
  @spec run_all() :: :ok
  def run_all do
    all_opts() |> bench()

    :ok
  end

  @doc """
  Runs a doubling benchmark (`n`, `2n`, `4n`, `8n`) for
  the given function and prints its `T(2n) / T(n)` ratios.
  """
  @spec run(:b | :d | :g | :j) :: :ok
  def run(f_name) when f_name in [:b, :d, :g, :j] do
    "\nfunc [#{f_name}] -> \n" |> String.upcase() |> IO.puts()

    f_name
    |> f()
    |> f_opts(@start_n[f_name])
    |> bench()
    |> print_ratios()
  end

  defp f(f_name) do
    fn n -> apply(Task2Xor, f_name, [n]) end
  end

  defp f_opts(f, n) do
    %{
      "(n)"     => fn -> f.(n)     end,
      "(n x 2)" => fn -> f.(n * 2) end,
      "(n x 4)" => fn -> f.(n * 4) end,
      "(n x 8)" => fn -> f.(n * 8) end
    }
  end

  defp all_opts do
    %{
      "(b) log2(n)"         => fn -> f(:b).(@n) end,
      "(d) n * 100"         => fn -> f(:d).(@n) end,
      "(g) ~ n^3"           => fn -> f(:g).(@n) end,
      "(j) n * log2(n) + n" => fn -> f(:j).(@n) end
    }
  end

  defp bench(opts) do
    run(
      opts,
      print: [
        benchmarking:  false,
        configuration: false,
        fast_warning:  false
      ],
      time:        3,
      memory_time: 1
    )
  end

  defp print_ratios(%Benchee.Suite{scenarios: scenarios}) do
    order = ["(n)", "(n x 2)", "(n x 4)", "(n x 8)"]

    sorted =
      scenarios
      |> Enum.sort_by(fn s -> Enum.find_index(order, &(&1 == s.name)) end)

    IO.puts("\nDoubling ratios T(2n) / T(n):")

    sorted
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.each(fn [prev, curr] ->
      t1 = prev.run_time_data.statistics.average
      t2 = curr.run_time_data.statistics.average

      ratio = Float.round(t2 / t1, 2)

      IO.puts("#{prev.name}\t-> #{curr.name}: #{ratio}x")
    end)
  end
end
