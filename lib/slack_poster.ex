defmodule SlackPoster do
  def post(text) do
    url = "https://slack.com/api/chat.postMessage"
    query = %{
      token: Application.get_env(:slack_poster, :slack_token),
      channel: "#bots_tests",
      text: text,
      icon_emoji: ":gutek:",
      username: "TOMSKI"
    }
    HTTPotion.post url, query: query
  end
end
