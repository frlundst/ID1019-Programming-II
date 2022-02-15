defmodule Primes do
  defstruct [:next]
  
  #def primes() do
  #  fn() -> {2, fn() -> sieve(z(3), 2) end} end
  #end

  def primes() do
    %Primes{next: fn() -> {2, fn() -> sieve(z(3), 2) end} end}
  end

  def next(primes) do
    {prime, function} = primes.next.()
    {prime, %Primes{next: function}}
  end

  def z(n) do fn() -> {n, z(n+1)} end end

  def filter(function, f) do
    {first, second} = function.()

    if rem(first , f) != 0 do
      {first, fn() -> filter(second, f) end}
    else
      filter(second, f)
    end
  end

  def sieve(n, p) do
    {first, second} = filter(n, p)
    {first, fn() -> sieve(second, first) end}
  end

end

defimpl Enumerable, for: Primes do
  def count(_) do {:error, __MODULE__} end
  def member?(_, _) do {:error, __MODULE__} end
  def slice(_) do {:error, __MODULE__} end

  def reduce(_, {:halt, acc}, _fun) do {:halted, acc} end
  def reduce(primes, {:suspend, acc}, fun) do
    {:suspended, acc, fn(cmd) -> reduce(primes, cmd, fun) end}
  end
  def reduce(primes, {:cont, acc}, fun) do
    {p, next} = Primes.next(primes)
    reduce(next, fun.(p,acc), fun)
  end
end

defmodule Test do
  def test() do
    Enum.take( Stream.map(Primes.primes(), fn(x) -> x end), 100)
  end
end
