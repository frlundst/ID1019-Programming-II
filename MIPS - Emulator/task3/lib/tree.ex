defmodule Tree do
    def tree_new() do :nil end
  
    def tree_insert(k, e, :nil) do {:leaf, k, e} end

    def tree_insert(k, e, {:node, key, value, left, right}) do
        if(k == key) do
            {:node, k, e, left, right}
        end
        if key > k do
            {:node, key, value, tree_insert(k, e, left), right}
        else
            {:node, key, value, left, tree_insert(k, e, right)}
        end
    end

    def tree_insert(k, e, {:leaf, key, value}) do
        if(k == key) do
            {:leaf, k, e}
        end
        if k > key do
            {:node, key, value, :nil, {:leaf, k,e}}
        else
            {:node, key, value, {:leaf, k, e}, :nil}
        end
    end

    def tree_search(:nil, _) do 0 end
    def tree_search({:node, key, value, left, right}, key_to_find) do
        cond do
            key == key_to_find -> value
            key_to_find < key -> tree_search(left, key_to_find)
            key_to_find > key -> tree_search(right, key_to_find)
        end
    end

    def tree_search({:leaf, k, e}, key_to_find) do
        if(k == key_to_find) do
            e
        else
            0
        end
    end
end