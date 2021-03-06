defmodule Radpath.Files do
   defmacro __using__([]) do
     quote do

       @doc """
  Returns all of the files in the given path, and if ext is
  given will filter by that extname.

  ### Examples
  
  Listing all of the contents of the folder /home/lowks/Documents

     Radpath.files("/home/lowks/Documents")

  If you wanted to apply a filter on that search:

      Radpath.files("/home/lowks/Documents", "doc")

  If you wanted to apply a list filter on that search:

      Radpath.files("/home/lowks/Documents", ["doc", "pdf"])

  Paths that do not exists will return an empty list:

      iex(2)> Radpath.files("/heck/i/do/not/exist")
      []

  """

    def files(path, ext) when (is_bitstring(ext) or is_list(ext)) do
      file_ext = case String.valid? ext do
        true -> [ext]
        false -> ext
      end
      expanded_path = Path.expand(path)
      case File.exists? expanded_path do
        true -> Finder.new() |>
                Finder.only_files() |>
                Finder.with_file_endings(file_ext) |>
                Finder.find(expanded_path) |>
                Enum.to_list
        false -> []
      end
    end

    @doc """
Radpath.files(path) will list down all files in the path without filtering

### Examples

Listing down all files in the "ci" folder without filtering: 

     Radpath.files("ci")
     ["/Users/lowks/Projects/src/elixir/Radpath/ci/script/circleci/prepare.sh"]

"""

    def files(path) do
      expanded_path = Path.expand(path)
      case File.exists? expanded_path do
        true -> Finder.new() |>
                Finder.only_files() |>
                Finder.find(expanded_path) |>
                Enum.to_list
        false -> []
      end
    end

  end
 end
end
