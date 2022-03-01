defmodule TrainList do
  def take(xs, n) do Enum.take(xs, n) end
  def drop(xs,n) do Enum.drop(xs, n) end
  def append(xs,ys) do xs ++ ys end
  def member(xs,y) do Enum.member?(xs, y) end
  def position(xs,y) do Enum.find_index(xs, fn x -> x == y end) + 1 end
end