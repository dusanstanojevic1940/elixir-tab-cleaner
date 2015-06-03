defmodule CleanTabs do
  @moduledoc """
  Contains methods to work with files
  """

  @doc """
  Clears tabs from passed content if it contains any
  """
  def clear_tab(content) do  
    if String.contains?(content, "\t") do
      {:ok, String.replace(content, "\t", "  ")}
    else
      :error
    end
  end  
  
  @doc """
  Writes fixed text to file_name
  """
  def write_to_file(file_name, fixed) do
    write = File.write(file_name, fixed)
      case write do
        :ok -> IO.puts("File "<>file_name<>" was written well")
        {:error, _} -> IO.puts("There was an error writing to the file: "<>file_name)
      end
  end
  
  @doc """
  Removes tabs from file_name if possible
  """
  def clear_tabs_file(file_name) do
    if String.ends_with?(file_name, ".exs") or String.ends_with?(file_name, ".ex") do
      file = File.read(file_name)
      case file do
        {:ok, content} ->
          case FileProcessor.clear_tab(content) do
            {:ok, fixed} -> 
              write_to_file(file_name, fixed)
            :error ->
              IO.puts("File "<>file_name<>" did not require fixing")
          end
        {:error, _} -> IO.puts("The file "<>file_name<>" is not readable")
      end
    end
  end

  @doc """
  Recursively removes tabs from all files with itself
  """
  def clear_tabs_dir(file_name) do
    case File.ls(file_name) do
      {:ok, file_names} -> Enum.each(file_names, fn file_name -> clear_tabs(file_name) end)
      {:error, _} -> IO.puts("Files in "<>file_name<>" could not be read")
    end
  end

  @doc """
  Recursivly removes all tabs from files in location
  """
  def clear_tabs(location) do
    if (File.dir?(location)) do
      clear_tabs_dir(location)
    end
    if (File.regular?(location)) do
      clear_tabs_file(location)
    end
  end
end

Enum.each(System.argv(), fn file_name -> 
  CleanTabs.clear_tabs(file_name) 
end)