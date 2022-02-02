defmodule Bench do

    # this is a benchmark for a simple list and a binary search tree

    def bench() do

        ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

        time = fn (i, f) ->
            seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
            elem(:timer.tc(fn () -> f.(seq) end),0)
        end

        bench = fn (i) ->
            list = fn (seq) ->
                List.foldr(seq, MyList.new(), fn (e, acc) -> MyList.insert(e, acc) end)
            end

            tree = fn (seq) ->
                List.foldr(seq, Tree.new(), fn (e, acc) -> Tree.insert(e, acc) end)
            end      

            tl = time.(i, list) 
            tt = time.(i, tree)     

            IO.write("  #{tl}\t\t\t#{tt}\n")
        end

        IO.write("# benchmark of lists and tree \n")
        Enum.map(ls, bench)

        :ok
    end
end