defmodule Program do
    
    def load({:prgm, code, data}) do
        {List.to_tuple(code), data}
    end
    
    # read instruction from program counter
    def read_instruction(code, pc) do 
        elem(code, div(pc, 4))
    end

    def read_address([[]], _) do 0 end
    def read_address([[{:label, value}, {:word, address}] | tail], imm) do
        if imm == value do
            address
        else
            read_address(tail, imm)
        end
    end

    def read_value([], _) do raise "Register Empty" end
    def read_value([[{:label, value}, {:word, address}] | tail], imm) do
        if imm == address do
            value
        else
            read_value(tail, imm)
        end
    end
    
    # write to data segment
    def write_data(data, name, address) do
        data ++ [[{:label, name},{:word, address}]]
    end
end