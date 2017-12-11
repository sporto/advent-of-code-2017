defmodule Main do
    def move(dir, {r, c}) do
        case dir do
            "n" ->
                {r - 2, c}
            "ne" ->
                {r - 1, c + 1}
            "se" ->
                {r + 1, c + 1}
            "s" ->
                {r + 2, c}
            "sw" ->
                {r + 1, c - 1}
            "nw" ->
                {r - 1, c - 1}
            _ ->
                {r, c}
        end
    end

    def run do
        case File.read "input.txt" do
            {:ok, content} ->
                {r, c} = String.split(content, ",")
                    |> List.foldl({0,0}, &Main.move/2)

                ((abs r) + (abs c)) / 2 |> IO.puts  
        end
    end
end

Main.run