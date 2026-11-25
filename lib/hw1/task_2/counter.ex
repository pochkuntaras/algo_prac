defmodule AlgoPrac.Hw1.Task2.Counter do
  @moduledoc """
  Counts exact operation counts for functions with
  `log2(n)`, `100n`, `~n^3`, and `n log2(n) + n` time complexities.
  """

  @doc """
  It runs in log2(n)

  ## Examples

      iex> 1..12 |> Enum.map(& :math.log2(&1) |> Float.ceil() |> trunc())
      [0, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4]
      iex> 1..12 |> Enum.map(&AlgoPrac.Hw1.Task2.Counter.b/1)
      [0, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4]
  """
  @spec b(pos_integer()) :: non_neg_integer()
  def b(n) when is_integer(n) and n > 0, do: b(n, 0)

  defp b(1, ops), do: ops
  defp b(n, ops), do: b(div(n + 1, 2), ops + 1)

  @doc """
  It runs in n * 100

  ## Examples

    iex> 1..12 |> Enum.map(& &1 * 100)
    [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200]
    iex> 1..12 |> Enum.map(&AlgoPrac.Hw1.Task2.Counter.d/1)
    [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200]
  """
  @spec j(non_neg_integer()) :: non_neg_integer()
  def d(n) when is_integer(n) and n > 0 do
    Enum.reduce(1..n, 0, fn _i, ops ->
      Enum.reduce(1..100, ops, fn _j, ops ->
        ops + 1
      end)
    end)
  end

  def d(_), do: 0

  @doc """
  It runs in ~ n^3

  ## Examples

    iex> [2, 4, 8, 16] |> Enum.map(& div(&1 * (&1 + 1) * (&1 + 2), 6))
    [4, 20, 120, 816]
    iex>  [2, 4, 8, 16] |> Enum.map(&AlgoPrac.Hw1.Task2.Counter.g/1)
    [4, 20, 120, 816]
  """
  @spec j(non_neg_integer()) :: non_neg_integer()
  def g(n) when is_integer(n) and n > 0 do
    Enum.reduce(1..n, 0, fn i, ops ->
      Enum.reduce(1..i, ops, fn j, ops ->
        Enum.reduce(1..j, ops, fn _k, ops ->
          ops + 1
        end)
      end)
    end)
  end

  def g(_), do: 0

  @doc """
  It runs in n * log2(n) + n

  ## Examples

      iex> [2, 4, 8, 16] |> Enum.map(& (&1 * :math.log2(&1) + &1) |> Float.ceil() |> trunc())
      [4, 12, 32, 80]
      iex> [2, 4, 8, 16] |> Enum.map(&AlgoPrac.Hw1.Task2.Counter.j/1)
      [4, 12, 32, 80]
  """
  @spec j(non_neg_integer()) :: non_neg_integer()
  def j(n) when is_integer(n) and n > 0, do: j(n, 0)

  defp j(n, ops) when n > 0 do
    ops = j(0, n, ops)
    n2 = trunc(n / 2)

    ops = j(n2, ops)
    ops = j(n2, ops)

    ops
  end

  defp j(_, ops), do: ops

  defp j(i, n, ops) when i < n, do: j(i + 1, n, ops + 1)
  defp j(_i, _n, ops), do: ops
end
