defmodule LinkedList do
    def new() do [] end
    
    def insert(e, l) do 
        case l do
            [] ->
                [e]
            [head | tail] ->
                if e < head do
                    [e | l]
                else
                    [head | insert(e, tail)] # recursively sorts to the right spot 
                end
        end
    end
end