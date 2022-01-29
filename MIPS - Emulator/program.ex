defmodule Program do
    
    def load(prgm) do
        {:prgm, {:code, List.to_tuple(prgm)}, {:data, List.to_tuple([])}}   #{:prgm, code(), data()}
    end
    
    # read instruction from program counter
    def read_instruction(code, pc) do 
        IO.write("#{pc} : #{elem(code, pc)}\n") 
        elem(code, pc)
    end
    
    # read from data segment
    def read_data(data, segment) do 
        IO.write("#{segment} : #{elem(data, segment)}\n")
        elem(data, segment)
    end
    
    # write to data segment
    def write_data(data, segment) do 
        elem(data, segment)
    end
end