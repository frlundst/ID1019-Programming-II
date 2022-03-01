defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end

    def text() do
        'this is'
    end

    def test do
        sample = sample()
        tree = tree(text())
        #encode = encode_table(tree)
        #decode = decode_table(tree)
        #text = text()
        #seq = encode(text, encode)
        #decode(seq, decode)
    end

    def tree(sample) do
        freq = freq(sample)
        #huffman(freq)
    end
    
    #[102,111,111]
    #[{102, 1}, {111, 2}]

    def freq(sample) do
        freq(sample, [])
    end
    def freq([], freq) do
        Enum.sort_by(freq, &(elem(&1, 1)))
    end
    def freq([char | rest], freq) do
        freq(rest, addFreq(freq, char))
    end

    def addFreq([], key) do [{key, 1}] end
    def addFreq([{k, v} | rest], key) do
        if k == key do
            [{k, v+1}] ++ rest
        else
            [{k, v}] ++ addFreq(rest, key)
        end
    end
    def huffman([{c1, f1} | []])
    def huffman([{c1, f1} | [{c2, f2} | rest]]) do 
        [{{c1, c2}, f1 + f2}] ++ huffman(rest)
    end
    def huffman([], tree) do tree end

    def encode_table(tree) do

    end

    def decode_table(tree) do

    end

    def encode(text, table) do

    end

    def decode(sequence, table) do
    
    end
end
