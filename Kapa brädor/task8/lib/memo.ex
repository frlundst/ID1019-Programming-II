defmodule Memo do
    def new() do %{} end
    def add(mem, key, val) do
        Map.put(mem, :binary.list_to_bin(key), val) 
    end

    def lookup(mem, key) do
        Map.get(mem, :binary.list_to_bin(key))
    end

    def newSpecialTree() do [] end
    #def addSpecialTree([], key, val) do [{key, val, []}] end
    #key = [1,2,3]
    def addSpecialTree(mem, [head | tail], val) do 
        mem ++ [{head, :nil, addSpecialTree(mem , tail, val)}]


        #mem ++ addSpecialTree(head , tail, val)


        #if elem(head, 0) == key do
        #    [head | addSpecialTree(tail, key, val)]
        #else
        #    [head | tail] ++ [{key, val, []}] 
        #end
    end
end