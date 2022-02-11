defmodule Primtal do
    def test(n) do
        list = Enum.to_list(2..n)
        list1 = solution_one(list)
        IO.inspect(list1)

        list2 = solution_two(list, [])
        IO.inspect(list2)

        list3 = solution_three(list, [])
        IO.inspect(list3)
    end

    def bench() do bench(100) end
    def bench(l) do
        ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024,16*1024]

        time = fn (i, f) ->
            elem(:timer.tc(fn () -> loop(l, fn -> f.(i) end) end),0)
        end

        bench = fn (i) ->
            solution_one = fn(n) ->
                solution_one(Enum.to_list(2..n))
            end

            solution_two = fn(n) ->
                solution_two(Enum.to_list(2..n), [])
            end

            solution_three = fn(n) ->
                solution_three(Enum.to_list(2..n), [])
            end

            timeOne = time.(i, solution_one)
            timeTwo = time.(i, solution_two)
            timeThree = time.(i, solution_three)

            IO.write("  #{timeOne}\t\t\t#{timeTwo}\t\t\t#{timeThree}\n")
        end

        Enum.map(ls, bench)
        :ok
    end

    def loop(0,_) do :ok end
    def loop(n, f) do 
        f.()
        loop(n-1, f)
    end

    def solution_one(list) do
        [head | tail] = list
        if tail == [] do
            list
        else
            tail = Enum.filter(tail, fn(x) ->
                    rem(x, head) != 0
                end)
            [head | solution_one(tail)]
        end
    end

    def solution_two([], found_primes) do found_primes end
    def solution_two([head | tail], found_primes) do
        if Enum.any?(found_primes, fn(x) -> rem(head, x) == 0 end) do
            solution_two(tail, found_primes)
        else
            solution_two(tail, found_primes ++ [head])
        end
    end

    def solution_three([], found_primes) do Enum.reverse(found_primes) end
    def solution_three([head | tail], found_primes) do
        if Enum.any?(found_primes, fn(x) -> rem(head, x) == 0 end) do
            solution_three(tail, found_primes)
        else
            solution_three(tail, [head | found_primes])
        end
    end
end