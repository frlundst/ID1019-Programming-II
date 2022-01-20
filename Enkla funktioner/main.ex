defmodule Simplefunctions do
    def reverse(string) do
        String.reverse(string)
    end

    def multiply(list) do
        Enum.reduce(list, fn x,y -> x * y end)
    end

    def sum(list) do
        Enum.reduce(list, fn x,y -> x + y end)
    end

    def flowers(flower1, flower2) do
        #if (rem(flower1, 2) == 0 and rem(flower2, 2) != 0) or (rem(flower1, 2) != 0 and rem(flower2, 2) == 0) do
        if(rem(flower1, 2) != rem(flower2, 2)) do
            true
        else
            false
        end
    end

    def to_camel_case(str) do
        list = String.split(String.replace(str, ~r/[[:punct:]]/, " "))
        Enum.join(Enum.map(list, fn x -> if x == "the" do 
                                            x
                                        else 
                                            String.capitalize(x) 
                                        end
        end))
    end

    def to_camel_case2(str) do
        [ first | tail ] = String.split(str, ["-", "_"])
        [ first | Enum.map(tail, &String.capitalize/1) ]
        |> Enum.join
    end

    def recursive_product(m, n) do
        if m == 0 do
            0
        else
            n + recursive_product(m-1, n)
        end
    end

    def recursive_product_case(m, n) do
        case m do
            0 ->
                0
            _ ->
                n + recursive_product_case(m-1, n)
        end
    end

    def recursive_product_clauses(0, _) do 0 end
    def recursive_product_clauses(m, n) do
        recursive_product_clauses(m-1, n) + n
    end

    def recursive_exp(x, n) do
        case n do
            0 ->
                1
            _ ->
                recursive_product(x, recursive_exp(x, n - 1))
        end
    end
end

#Reverse a string
IO.puts(Simplefunctions.reverse("HEJHEJ"))

#Multiply all of the values in a list together
IO.puts(Simplefunctions.multiply([1, 2, 3, 4]))

#Sum all of the values in a list together
IO.puts(Simplefunctions.sum([1, 2, 3, 4]))

# Timmy & Sarah think they are in love, but around where they live, 
# they will only know once they pick a flower each. If one of the flowers
# has an even number of petals and the other has an odd number of petals it means they are in love.
# The function will return true if they're in love and flase if they're not.
IO.puts(Simplefunctions.flowers(2,3))

#"the-stealth-warrior" gets converted to "theStealthWarrior"
#"The_Stealth_Warrior" gets converted to "TheStealthWarrior"
IO.puts(Simplefunctions.to_camel_case("The_Stealth_Warrior"))

#Better version of the first to_camel_case function.
#"the-stealth-warrior" gets converted to "theStealthWarrior"
#"The_Stealth_Warrior" gets converted to "TheStealthWarrior"
IO.puts(Simplefunctions.to_camel_case2("The_Stealth_Warrior"))

#Product with recursive function
IO.puts(Simplefunctions.recursive_product(2,10))

#Prodict with recursive function but with a case instead
IO.puts(Simplefunctions.recursive_product_case(6,6))

#Product with recursive function but with different clauses instead
IO.puts(Simplefunctions.recursive_product_clauses(6,10))

IO.puts(Simplefunctions.recursive_exp(4,2))

defmodule Insertion do
    def sort(list) when is_list(list) and length(list) <= 1 do
        list
    end

    def sort(list) when is_list(list) do
        [last_elem | first_part_reversed] = Enum.reverse(list)
        insert(last_elem, sort(Enum.reverse(first_part_reversed)))
    end

    defp insert(e, [min|rest]) do
        cond do
            min >= e -> [e,min|rest]
            true -> [min|insert(e, rest)]
        end
    end
    
    #Insert to e to list and return it
    defp insert(e, []) do
        [e]
    end

end

#IO.inspect(Insertion.sort([5,3,75,7,1,6,8,9,10]))