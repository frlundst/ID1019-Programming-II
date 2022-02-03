defmodule Primtal do
    def test(n) do
        list = Enum.to_list(2..n)
        list = lösning1(list)

    end

    def lösning1(list) do
        [head | tail] = list
        if tail == [] do
            list
        else
            tail = Enum.filter(tail, fn(x) ->
                    rem(x, head) != 0
                end)
            [head | lösning1(tail)]
        end
    end
    def lösning2 do

    end

    def lösning3 do

    end
end