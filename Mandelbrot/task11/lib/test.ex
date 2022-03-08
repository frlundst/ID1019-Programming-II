defmodule Test do
    def demo() do
        small2(-2.6, 1.2, 1.2)
    end

    def small(x0, y0, xn) do
        width = 960
        height = 540
        depth = 64
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        Print.start("small.ppm", width, height)
    end
    def small2(x0, y0, xn) do
        width = 960
        height = 540
        depth = 64
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        PPM.write("small.ppm", image)
    end

end