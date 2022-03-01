defmodule Bench do
    def benchSlow(n) do
        for i <- 1..n do
            {t,_} = :timer.tc(fn() -> SlowSolution.cost(Enum.to_list(1..i)) end)
            IO.puts(" n = #{i}\t t = #{t} us")
        end
    end

    def benchFast(n) do
        for i <- 1..n do
            {t,_} = :timer.tc(fn() -> FastSolution.cost(Enum.to_list(1..i)) end)
            IO.puts(" n = #{i}\t t = #{t} us")
        end
    end

    def benchFastest(n) do
        for i <- 1..n do
            {t,_} = :timer.tc(fn() -> FastestSolution.cost(Enum.to_list(1..i)) end)
            IO.puts(" n = #{i}\t t = #{t} us")
        end
    end
end