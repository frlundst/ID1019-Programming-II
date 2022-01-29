defmodule Program do
    
    def load(prgm) do
        {List.to_tuple(prgm), List.to_tuple(LinkedList.new())}   #{:prgm, code(), data()}
    end
    
    # read instruction from program counter
    def read_instruction(code, pc) do 
        elem(code, pc)
    end
    
    # read from data segment
    def read_data(data, segment) do 
        elem(data, segment)
    end
    
    # write to data segment
    def write_data(data, segment, value) do
        data.insert(value)
        elem(data, segment)
    end
end