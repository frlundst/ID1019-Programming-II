defmodule Brot do
    def mandelbrot(c, m) do
        z0 = Cmplx.new(0, 0)
        i = 0
        test(i, z0, c, m)
    end

    def test(i, z, c, m) do
        cond do
            i >= m ->
                0
            Cmplx.abs(z) < 2 ->
                z = Cmplx.add(Cmplx.sqr(z), c)
                test(i + 1, z, c, m)
            true ->
                i
        end
    end
end