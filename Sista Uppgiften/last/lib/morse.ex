defmodule Morse do
    def test() do
        tree = morse()
        encodeTable = getEncodeTable(tree, [])
        text = 'fredrik är mitt namn'
        morse = encode(text, encodeTable)
        
        rickRoll = ".- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... .... - - .--. ... ---... .----- .----- .-- .--
.-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-.
--- -- .----- .-- .- - -.-. .... ..--.. ...- .----.
-.. .--.-- ..... .---- .-- ....- .-- ----. .--.--
..... --... --. .--.-- ..... ---.. -.-. .--.--
..... .----"
        decodeTable = getDecodeTable(encodeTable)
        decode(String.split(rickRoll), decodeTable)
    end

    def morse() do
        {:node, :na,
        {:node, 116,
            {:node, 109,
            {:node, 111, {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
            {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
            {:node, 103, {:node, 113, nil, nil},
            {:node, 122, {:node, :na, {:node, 44, nil, nil}, nil}, {:node, 55, nil, nil}}}},
            {:node, 110, {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
            {:node, 100, {:node, 120, nil, nil},
            {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
        {:node, 101,
            {:node, 97,
            {:node, 119, {:node, 106, {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}}, nil},
            {:node, 112, {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}}, nil}},
            {:node, 114, {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
            {:node, 108, nil, nil}}},
            {:node, 105,
            {:node, 117, {:node, 32, {:node, 50, nil, nil}, {:node, :na, nil, {:node, 63, nil, nil}}},
            {:node, 102, nil, nil}},
            {:node, 115, {:node, 118, {:node, 51, nil, nil}, nil},
            {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
    end
    
    def getEncodeTable({:node, key, left, right}, list) do
        if(key == :na) do
            Map.merge(getEncodeTable(left, list ++ '-'), getEncodeTable(right, list ++ '.'))
        else
            Map.put(Map.merge(getEncodeTable(left, list ++ '-'), getEncodeTable(right, list ++ '.')), key, List.to_string(list))
        end
    end

    def getEncodeTable(:nil, _) do
        %{}
    end

    def encode([], _) do "" end
    def encode([char | tail], encodeTable) do
        Map.get(encodeTable, char) <> " " <> encode(tail, encodeTable)
    end

    def getDecodeTable(encodeTable) do
        Map.new(encodeTable, fn {key, value} -> {value, key} end)
    end

    def decode([], _) do [] end
    def decode([morse | tail], decodeTable) do
        [Map.get(decodeTable, morse)] ++ decode(tail, decodeTable)
    end
end