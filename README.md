# AlgoPrac

## HW 1 / Task 2

### Metrics

```ex
iex 1 ▶  [:b, :d, :g, :j] |> Enum.each(&AlgoPrac.Hw1.Task2Benchmark.run/1)

FUNC [B] ->


Name              ips        average  deviation         median         99th %
(n)            4.06 M      246.06 ns  ±1952.33%         250 ns         333 ns
(n x 2)        3.87 M      258.36 ns  ±1645.70%         250 ns         334 ns
(n x 4)        3.69 M      271.23 ns  ±2090.00%         250 ns         375 ns
(n x 8)        3.65 M      273.99 ns  ±1466.66%         250 ns         375 ns

Comparison:
(n)            4.06 M
(n x 2)        3.87 M - 1.05x slower +12.30 ns
(n x 4)        3.69 M - 1.10x slower +25.17 ns
(n x 8)        3.65 M - 1.11x slower +27.93 ns

Memory usage statistics:

Name       Memory usage
(n)               320 B
(n x 2)           336 B - 1.05x memory usage +16 B
(n x 4)           352 B - 1.10x memory usage +32 B
(n x 8)           368 B - 1.15x memory usage +48 B

**All measurements for memory usage were the same**

Doubling ratios T(2n) / T(n):
(n)     -> (n x 2): 1.05x
(n x 2) -> (n x 4): 1.05x
(n x 4) -> (n x 8): 1.01x

FUNC [D] ->


Name              ips        average  deviation         median         99th %
(n)            2.89 K        0.35 ms     ±3.69%        0.34 ms        0.40 ms
(n x 2)        1.41 K        0.71 ms     ±5.28%        0.69 ms        0.84 ms
(n x 4)        0.72 K        1.39 ms     ±3.57%        1.37 ms        1.59 ms
(n x 8)        0.36 K        2.77 ms     ±2.94%        2.75 ms        3.11 ms

Comparison:
(n)            2.89 K
(n x 2)        1.41 K - 2.05x slower +0.36 ms
(n x 4)        0.72 K - 4.02x slower +1.05 ms
(n x 8)        0.36 K - 8.02x slower +2.43 ms

Memory usage statistics:

Name       Memory usage
(n)            23.49 KB
(n x 2)        46.93 KB - 2.00x memory usage +23.44 KB
(n x 4)        93.80 KB - 3.99x memory usage +70.31 KB
(n x 8)       187.55 KB - 7.98x memory usage +164.06 KB

**All measurements for memory usage were the same**

Doubling ratios T(2n) / T(n):
(n)     -> (n x 2): 2.05x
(n x 2) -> (n x 4): 1.97x
(n x 4) -> (n x 8): 1.99x

FUNC [G] ->


Name              ips        average  deviation         median         99th %
(n)           68.27 K       14.65 μs    ±17.52%       14.38 μs       20.04 μs
(n x 2)        8.19 K      122.13 μs    ±33.24%       91.71 μs      206.38 μs
(n x 4)        1.53 K      652.69 μs     ±4.01%      641.50 μs      748.00 μs
(n x 8)        0.21 K     4856.84 μs     ±2.99%     4805.21 μs     5458.29 μs

Comparison:
(n)           68.27 K
(n x 2)        8.19 K - 8.34x slower +107.48 μs
(n x 4)        1.53 K - 44.56x slower +638.04 μs
(n x 8)        0.21 K - 331.59x slower +4842.19 μs

Memory usage statistics:

Name       Memory usage
(n)            29.94 KB
(n x 2)       113.53 KB - 3.79x memory usage +83.59 KB
(n x 4)       441.85 KB - 14.76x memory usage +411.91 KB
(n x 8)      1743.02 KB - 58.22x memory usage +1713.09 KB

**All measurements for memory usage were the same**

Doubling ratios T(2n) / T(n):
(n)     -> (n x 2): 8.34x
(n x 2) -> (n x 4): 5.34x
(n x 4) -> (n x 8): 7.44x

FUNC [J] ->


Name              ips        average  deviation         median         99th %
(n)           22.10 K       45.24 μs     ±7.38%       44.46 μs       60.67 μs
(n x 2)       10.49 K       95.36 μs     ±4.81%       94.08 μs      116.71 μs
(n x 4)        4.94 K      202.36 μs     ±5.38%      198.25 μs      253.04 μs
(n x 8)        2.37 K      422.26 μs     ±3.52%      417.17 μs      482.21 μs

Comparison:
(n)           22.10 K
(n x 2)       10.49 K - 2.11x slower +50.12 μs
(n x 4)        4.94 K - 4.47x slower +157.12 μs
(n x 8)        2.37 K - 9.33x slower +377.02 μs

Memory usage statistics:

Name       Memory usage
(n)            31.98 KB
(n x 2)        63.98 KB - 2.00x memory usage +32 KB
(n x 4)       127.98 KB - 4.00x memory usage +96 KB
(n x 8)       255.98 KB - 8.00x memory usage +224 KB

**All measurements for memory usage were the same**

Doubling ratios T(2n) / T(n):
(n)     -> (n x 2): 2.11x
(n x 2) -> (n x 4): 2.12x
(n x 4) -> (n x 8): 2.09x
:ok

```

### Analysis

| Function | Formula | Initial $n_0$ | $T(n_0)$ | $T(2n_0)$ | $T(4n_0)$ | $T(8n_0)$ | $T(2n)/T(n)$ | Predicted Factor |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **`:b`** | $\log_2(n)$ | $1\,000\,000$ | 246.06 ns | 258.36 ns | 271.23 ns | 273.99 ns | **1.05x -> 1.05x -> 1.01x** | **~1.05x** (-> 1.0{x}$) |
| **`:d`** | $n \cdot 100$ | $1\,000$ | 0.35 ms | 0.71 ms | 1.39 ms | 2.77 ms | **2.05x -> 1.97x -> 1.99x** | **2.00x** |
| **`:g`** | $\approx n^3$ | $25$ | 14.65 μs | 122.13 μs | 652.69 μs | 4856.84 μs | **8.34x -> 5.34x -> 7.44x** | **8.00x** |
| **`:j`** | $n \log_2(n) + n$ | $2\,000$ | 45.24 μs | 95.36 μs | 202.36 μs | 422.26 μs | **2.11x -> 2.12x -> 2.09x** | **~2.15x** |

### Comparison

All four functions matched their theoretical formulas pretty closely: :b stayed around 1.01x–1.05x, :d doubled right around 2.00x, :j grew at ~2.11x, and :g got close to the expected 8x jump (8.34x and 7.44x). The only weird dip was in :g between n=50 and n=100, where the average ratio dropped to 5.34x. Any remaining tiny differences from the pure math formulas just come from normal runtime overhead and the fact that our input sizes n aren't infinite.
