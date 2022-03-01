defmodule Tree do

    # a tree with only key (for benchmarking)
    def new() do :nil end
  
    def insert(e, :nil) do {:leaf, e} end

    def insert(e, {:node, value, left, right}) do
        if e < value do
            {:node, value, insert(e, left), right}
        else
            {:node, value, left, insert(e, right)}
        end
    end

    def insert(e, {:leaf, value}) do
        if e < value do
            {:node, value, :nil, {:leaf, e}}
        else
            {:node, value, {:leaf, e}, :nil}
        end
    end

    #------------------------------------------------------------------
    # tree with both key and value
  
    def insert(k, e, :nil) do {:leaf, k, e} end

    def insert(k, e, {:node, key, value, left, right}) do
        if(k == key) do
            {:node, k, e, left, right}
        end
        if key > k do
            {:node, key, value, insert(k, e, left), right}
        else
            {:node, key, value, left, insert(k, e, right)}
        end
    end

    def insert(k, e, {:leaf, key, value}) do
        if(k == key) do
            {:leaf, k, e}
        end
        if k > key do
            {:node, key, value, :nil, {:leaf, k,e}}
        else
            {:node, key, value, {:leaf, k, e}, :nil}
        end
    end

    #-----------------------------------------------------------------
    # search for key in a binary tree and return value

    def search(:nil, _) do "empty" end
    def search({:node, key, value, left, right}, key_to_find) do
        cond do
            key == key_to_find -> value
            key_to_find < key -> search(left, key_to_find)
            key_to_find > key -> search(right, key_to_find)
        end
    end

    def search({:leaf, k, e}, key_to_find) do
        if(k == key_to_find) do
            e
        else
            "not found"
        end
    end

    #------------------------------------------------------------------
    # traverse for value in a binary tree and return key

    def traverse(:nil, _) do "empty" end
    def traverse({:node, key, value, left, right}, value_to_find) do
        if value == value_to_find do
            key
        else
            traverse(left, value_to_find)
            traverse(right, value_to_find)
        end
    end

    def traverse({:leaf, key, value}, value_to_find) do
        if value == value_to_find do
            key
        else
            "not found"
        end
    end
end