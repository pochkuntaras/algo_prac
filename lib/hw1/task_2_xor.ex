defmodule AlgoPrac.Hw1.Task2Xor do
  @moduledoc """
  Sample functions with distinct time complexities
  (`log2(n)`, `100n`, `~n^3`, `n log2(n) + n`).
  """

  import Bitwise, only: [bxor: 2]

  @doc """
  It runs in log2(n)
  """
  @spec b(number()) :: non_neg_integer()
  def b(n) when n > 0, do: b(n, 0, 0)

  defp b(n, _, acc) when n <= 1, do: acc
  defp b(n, i, acc), do: b(n / 2, i + 1, bxor(acc, i))

  @doc """
  It runs in n * 100
  """
  @spec b(non_neg_integer()) :: non_neg_integer()
  def d(n) when is_integer(n) and n > 0 do
    Enum.reduce(1..n, 0, fn i, acc ->
      Enum.reduce(1..100, acc, fn j, acc ->
        bxor(acc, i * j)
      end)
    end)
  end

  def d(_), do: 0

  @doc """
  It runs in ~ n^3
  """
  @spec b(non_neg_integer()) :: non_neg_integer()
  def g(n) when is_integer(n) and n > 0 do
    Enum.reduce(1..n, 0, fn i, acc ->
      Enum.reduce(1..i, acc, fn j, acc ->
        Enum.reduce(1..j, acc, fn k, acc ->
          bxor(acc, i + j + k)
        end)
      end)
    end)
  end

  def g(_), do: 0

  @doc """
  It runs in n * log2(n) + n
  """
  @spec j(non_neg_integer()) :: non_neg_integer()
  def j(n) when is_integer(n) and n > 0, do: j(n, 0)

  defp j(n, acc) when n > 0 do
    acc = j(0, n, acc)
    n2  = trunc(n / 2)

    acc = j(n2, acc)
    acc = j(n2, acc)

    acc
  end

  defp j(_, acc), do: acc

  defp j(i, n, acc) when i < n, do: j(i + 1, n, bxor(acc, i))
  defp j(_, _, acc), do: acc
end
