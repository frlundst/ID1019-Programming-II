defmodule Test do
    def demo(x0, y0, xn) do
        small2(x0, y0, xn)
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