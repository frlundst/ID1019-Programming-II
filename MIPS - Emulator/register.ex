defmodule Register do
    def new() do # a register has 10 slots
        {0,0,0,0,0,0,0,0,0,0}
    end

    def read(  _, 0) do 
        0 
    end 
    
    def read(reg, slot) do
        elem(reg, slot)        
    end

    def write(reg, 0, _) do 
        reg
    end

    def write(reg, slot, val) do
        put_elem(reg, slot, val)
    end  
end