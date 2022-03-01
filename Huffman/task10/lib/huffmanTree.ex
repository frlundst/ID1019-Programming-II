defmodule HuffmanTree do
    def new() do :nil end

    def insert(k, e, :nil) do {:leaf, k, e} end

    def insert(k, e, {:leaf, key, value}) do

    end

    def insert(k, e, {:node, key, value, left ,right}) do
        
    end
end