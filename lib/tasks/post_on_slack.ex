defmodule Mix.Tasks.PostOnSlack do
  use Mix.Task

  def run(_) do
    App.call
  end
end
