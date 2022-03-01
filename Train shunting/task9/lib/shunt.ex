defmodule Shunt do
  # transform the state {xs,[],[]} into {ys,[],[]}
  # and list all moves 
  def find(_, []) do [] end
  def find(xs, [y | ys]) do #take y from ys (the desired train form) since we want y on the front position on the main track
    {hs, ts} = split(xs, y) #then split the xs train where the desired train form first wagon is positioned
    [
      {:one, Enum.count(ts) + 1}, 
      {:two, Enum.count(hs)}, 
      {:one, -Enum.count(ts) - 1}, 
      {:two, -Enum.count(hs)}
    ] ++ find(hs ++ ts, ys)
  end

  def split(xs, y) do
    index = TrainList.position(xs, y)
    {TrainList.take(xs, index-1), TrainList.drop(xs, index)}
  end

  def few(_, []) do [] end
  def few(xs, [y | ys]) do
    {hs, ts} = split(xs,y)

    if Enum.count(hs) == 0 do
      few(ts, ys)
    else
      [
        {:one, Enum.count(ts) + 1}, 
        {:two, Enum.count(hs)}, 
        {:one, -Enum.count(ts) - 1}, 
        {:two, -Enum.count(hs)}
      ] ++ few(hs ++ ts, ys)
    end
  end

  def compress(ms) do
    ns = rules(ms)
    cond do
      ns == ms -> ms
      true -> compress(ns)
    end
  end

  def rules([]) do [] end
  def rules([move | []]) do [move] end
  def rules([{_, 0} | tail]) do rules(tail) end
  def rules([{track, n} | tail]) do
      [{nextTrack, m} | nextTail] = tail
      cond do
        nextTrack == track ->
          if n + m != 0 do
            [{track, n+m}] ++ rules(nextTail)
          else
            rules(nextTail)
          end
        true ->
          [{track , n}] ++ rules(tail)
      end
  end
end