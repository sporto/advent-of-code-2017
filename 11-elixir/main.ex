defmodule Main do
    def move(dir, %{ :current => {cr, cc}, :max => maxSteps}) do
        {cr, cc} = case dir do
            "n" ->
                {cr - 2, cc}
            "ne" ->
                {cr - 1, cc + 1}
            "se" ->
                {cr + 1, cc + 1}
            "s" ->
                {cr + 2, cc}
            "sw" ->
                {cr + 1, cc - 1}
            "nw" ->
                {cr - 1, cc - 1}
            _ ->
                {cr, cc}
        end

        steps = ((abs cr) + (abs cc)) / 2

        %{ :current => {cr, cc}, :max => max(steps, maxSteps) }
    end

    def run do
        case File.read "input.txt" do
            {:ok, content} ->
                initial = %{ :current => {0,0}, :max => 0 }

                result = String.split(content, ",")
                    |> List.foldl(initial, &Main.move/2)

                %{ :current => {cr, cc} , :max => maxSteps } = result

                ((abs cr) + (abs cc)) / 2 |> IO.puts  

                # Max
                IO.puts  maxSteps
        end
    end
end

Main.run