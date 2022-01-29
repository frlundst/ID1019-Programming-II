defmodule Program do
    @type code() :: {:code, number()}

    def load(prgm) do
        {:prgm, {:code, List.to_tuple(prgm)}, {:data, List.to_tuple([])}}
    end

    def read_instruction(code, pc) do
        IO.write("#{pc} : #{elem(code, pc)}\n") #Print instruction
        elem(code, pc) #Look at the instruction at program counter
    end
end