defmodule Program do
    
    def load({:prgm, code, data}) do
        {List.to_tuple(code), data}
    end
    
    # read instruction from program counter
    def read_instruction(code, pc) do 
        elem(code, div(pc, 4))
    end

    #read an address and get the value
    def read_address(data, key) do
        Tree.tree_search(data, key)
    end
    
    # write to data segment
    def write_data(data, name, address) do
        Tree.tree_insert(name, address, data)
    end
end