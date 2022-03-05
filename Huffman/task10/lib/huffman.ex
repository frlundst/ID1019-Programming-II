defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text() do
        'this is something that we should encode'
    end

    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        #decode = decode_table(tree)
        #text = text()
        #seq = encode(text, encode)
        #decode(seq, decode)
    end

    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end

    def freq(sample) do
        freq(sample, [])
    end
    def freq([], freq) do
        Enum.sort_by(freq, &(elem(&1, 1)))
    end
    def freq([char | tail], freq) do
        freq(tail, addFreq(freq, char))
    end

    def addFreq([], key) do [{key, 1}] end
    def addFreq([{k, v} | tail], key) do
        if k == key do
            [{k, v+1}] ++ tail
        else
            [{k, v}] ++ addFreq(tail, key)
        end
    end

    def huffman([{tree, _}]) do tree end
    def huffman([{c1, f1} | [{c2, f2} | tail]]) do
        sortedList = insert({c1, f1}, {c2, f2}, tail)
        huffman(sortedList)
    end

    def insert({k1, v1}, {k2, v2}, []) do 
        [{{k1, k2}, v1 + v2}]
    end
    def insert({k1, v1} , {k2, v2}, [{k3, v3} | tail])do
        if(v1 + v2 < v3) do
            [{{k1, k2}, v1+v2}] ++ [{k3, v3} | tail]
        else
            [{k3, v3}] ++ insert({k1, v1}, {k2, v2}, tail)
        end
    end

    def encode_table(tree) do 
        encode_table(tree, []) 
    end
    def encode_table({left, right}, path) do
        encode_table(left, path ++ [0]) ++ encode_table(right, path ++ [1])
    end
    def encode_table(char, path) do 
        [{char, path}]
    end

    def decode_table(tree) do
        encode_table(tree)
    end

    def encode([], _) do [] end
    def encode([head | tail], table) do
        get_code(head, table) ++ encode(tail, table)
    end
    
    def get_code(char, [{table_char, code} | tail]) do
        if char == table_char do
            code
        else
            get_code(char, tail)
        end
    end

    def decode([], table) do [] end
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char | decode(rest, table)]
    end
    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {char, _} ->
                {char, rest};
            nil ->
                decode_char(seq, n + 1, table)
        end
    end

    def read(file) do
        {:ok, file} = File.open(file, [:read, :utf8])
        binary = IO.read(file, :all)
        File.close(file)
        length = byte_size(binary)
        case :unicode.characters_to_list(binary, :utf8) do
            {:incomplete, list, rest} ->
                {list, length - byte_size(rest)}
            list ->
                {list, length}
        end
    end

    def bench() do
        {text, length} = read("lib/data.txt")
        {tree, tree_time} = time(fn -> tree(text) end)
        {encode_table, encode_table_time} = time(fn -> encode_table(tree) end)
        {decode_table, decode_table_time} = time(fn -> decode_table(tree) end)
        {encode, encode_time} = time(fn -> encode(text, encode_table) end)
        {_, decoded_time} = time(fn -> decode(encode, decode_table) end)

        e = div(length(encode), 8)
        r = Float.round(e / length, 3)

        IO.puts("Tree Build Time: #{tree_time} us")
        IO.puts("Encode Table Time: #{encode_table_time} us")
        IO.puts("Decode Table Time: #{decode_table_time} us")
        IO.puts("Encode Time: #{encode_time} us")
        IO.puts("Decode Time: #{decoded_time} us")
        IO.puts("Compression Ratio: #{r}")
    end

    def time(func) do
        {func.(), elem(:timer.tc(fn () -> func.() end), 0)}
    end
end
