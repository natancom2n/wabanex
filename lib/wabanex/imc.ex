defmodule Wabanex.IMC do
  def calculate(%{"filename" => filename}) do
    #funcao para ler um arquivo
    #result = File.read(filename)
    #handle_file(result)
    filename
    |> File.read()
    |> handle_file()

  end

  defp handle_file({:ok, content}) do
      data =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end)
      #change list for map
      |> Enum.into(%{})

      {:ok, data}

  end
  defp handle_file({:error, _reason}) do
    {:error, "Error while opening the file"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    # o 1 é do primeiro item da lista
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
    |> IO.inspect()
  end
  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}

end
