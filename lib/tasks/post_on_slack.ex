defmodule Mix.Tasks.PostOnSlack do
  use Mix.Task

  def run(_) do
    HTTPotion.start
    App.call
  end
end
