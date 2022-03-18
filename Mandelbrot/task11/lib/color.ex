defmodule Color do
    def convert(depth, max) do
        f = depth / max
        a = f * 4
        x = trunc(a)
        y = trunc(255 * (a - x))
        case x do
            0 ->
                {0, 0, y}
            1 ->
                {0, y, 255}
            2 ->
                {0, 255, 255-y}
            3 ->
                {y, 255, 0}
            4 -> 
                {255, 255 - y, 0}
        end
    end
end