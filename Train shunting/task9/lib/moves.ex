defmodule Moves do
  def test() do
    #single({:two, 2},{[:a,:b],[:c, :d, :e],[:f, :g]}) 
    move([{:one,1},{:two,1},{:one,-1}],{[:a,:b],[],[]})
  end

  def single({track, n}, {main, one, two}) do
    case track do
      :one ->
        cond do
          n > 0 ->
            {
              TrainList.drop(main, -n), 
              TrainList.append(TrainList.take(main, -n), one), 
              two
            }
          n < 0 ->
            {
              TrainList.append(main, TrainList.take(one, -n)), # Måste ta negativa eftersom om n redan är negativt så måste
              TrainList.drop(one, -n),                         # vi få det positivt för att kunna flytta på den mest vänstra vagnen i listan
              two
            }
          true ->
            {main, one, two}
        end
      :two ->
        cond do
          n > 0 ->
            {
              TrainList.drop(main, -n), 
              one, 
              TrainList.append(TrainList.take(main, -n), two)
            }
          n < 0 ->
            {
              TrainList.append(main, TrainList.take(two, -n)),
              one,                         
              TrainList.drop(two, -n)
            }
          true ->
            {main, one, two}
        end
    end
  end

  def move([], state) do [state] end
  def move([head | tail], state) do
    [state] ++ move(tail, single(head, state))
  end
end
