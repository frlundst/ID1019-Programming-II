defmodule SlowSolution do
    def test() do
        #split([1,2,3,4,5])
        cost([1,2,3,4])
    end

    def split(seq) do split(seq, 0, [], []) end
    def split([], l, left, right) do
        [{left, right, l}]
    end
    def split([s|rest], l, left, right) do
        split(rest, l+s, [s | left], right) ++ split(rest, l+s, left, [s | right])
    end

    def cost([]) do 0 end
    def cost([_]) do 0 end
    def cost(seq) do cost(seq, 0, [], []) end
    def cost([], l, left, right) do
        cost(left) + cost(right) + l
    end
    def cost([s], l, [], right) do
        s + l + cost(right)
    end
    def cost([s], l, left, []) do
        s + l + cost(left)
    end

    def cost([s|rest], l, left, right) do
        cost1 = cost(rest, l+s, [s|left], right)
        cost2 = cost(rest, l+s, left, [s|right])
        if cost1 < cost2 do
            cost1
        else
            cost2
        end
    end
end


defmodule FastSolution do
    @moduledoc """
    In this solution we make use of a tree to map and "remember" 
    the costs of all of the recurring sequences. The costs are added
    to a tree. 
    """
    def test() do
        cost([1,2,3])
    end

    def cost([]) do {0, :na} end
    def cost(seq) do
        {cost, tree, _} = cost(seq, Memo.new())
        {cost, tree}
    end

    @doc """
    First calculate the cost of the sequence and then make a new memory of the tree
    by adding the sequence cost to the old memory. The sequence will be the key for the val
    which is the cost.
    """
    def cost([s], mem) do {0, s, mem} end
    def cost(seq, mem) do
        {c, t, mem} = cost(seq, 0, [], [], mem)
        {c, t, Memo.add(mem, seq, {c, t})}
    end
    def cost([], l, left, right, mem) do
        {c1, t1, mem} = check(left, mem)
        {c2, t2, mem} = check(right, mem)
        {c1 + c2 + l, {t1, t2}, mem}
    end
    def cost([s], l, [], right, mem) do
        {c, t, mem} = check(right, mem)
        {c + s + l, {s, t}, mem}
    end
    def cost([s], l, left, [], mem) do
        {c, t, mem} = check(left, mem)
        {c + s + l, {t, s}, mem}
    end

    def cost([s|rest], l, left, right, mem) do
        {c1, t1, mem} = cost(rest, l+s, [s|left], right, mem)
        {c2, t2, mem} = cost(rest, l+s, left, [s|right], mem)
        if c1 < c2 do
            {c1, t1, mem}
        else
            {c2, t2, mem}
        end
    end

    @doc """
    The check method is always called when calculating the cost of a sequence.
    Maybe the sequence cost exists in our tree? If it don't we just calculate the
    cost and add it to the tree instead of returning the cost.
    """
    def check(seq, mem) do
        case Memo.lookup(mem, seq) do
            nil ->
                cost(seq, mem)
            {c, t} ->
                {c, t, mem}
        end
    end
end

defmodule FastestSolution do
    def test() do
        cost([1,2,3])
    end

    def cost([]) do {0, :na} end
    def cost(seq) do
        {cost, tree, _} = cost(Enum.sort(seq), Memo.newSpecialTree())
        {cost, tree}
    end

    def cost([s], mem) do {0, s, mem} end
    def cost([s | rest] = seq, mem) do
        {c, t, mem} = cost(rest, s, [s], [], mem)
        {c, t, Memo.add(mem, seq, {c, t})}
    end
    def cost([], l, left, right, mem) do
        {c1, t1, mem} = check(Enum.reverse(left), mem)
        {c2, t2, mem} = check(Enum.reverse(right), mem)
        {c1 + c2 + l, {t1, t2}, mem}
    end
    def cost([s], l, [], right, mem) do
        {c, t, mem} = check(Enum.reverse(right), mem)
        {c + s + l, {s, t}, mem}
    end
    def cost([s], l, left, [], mem) do
        {c, t, mem} = check(Enum.reverse(left), mem)
        {c + s + l, {t, s}, mem}
    end

    def cost([s|rest], l, left, right, mem) do
        {c1, t1, mem} = cost(rest, l+s, [s|left], right, mem)
        {c2, t2, mem} = cost(rest, l+s, left, [s|right], mem)
        if c1 < c2 do
            {c1, t1, mem}
        else
            {c2, t2, mem}
        end
    end

    def check(seq, mem) do
        case Memo.lookup(mem, seq) do
            nil ->
                cost(seq, mem)
            {c, t} ->
                {c, t, mem}
        end
    end
end
