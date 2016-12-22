defmodule App do

  def call do
    presence_checker_task = Task.async(fn -> PeoplePresenceChecker.call end)
    menu_fetch_task = Task.async(fn -> MenuFetcher.call end)
    post_on_slack {Task.await(presence_checker_task), Task.await(menu_fetch_task)}
  end

  defp post_on_slack({true, menu_url}), do: SlackPoster.post(menu_url)
  defp post_on_slack({false, _}), do: IO.puts "Too many absent people"
end
