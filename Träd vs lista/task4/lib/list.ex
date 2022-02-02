defmodule MyList do
    def new() do [] end
    
    def insert(e, l) do 
        case l do
            [] ->
                [e]
            [head | tail] ->
                if e < head do
                    [e | l]
                else
                    [head | insert(e, tail)]
                end
        end
    end
end