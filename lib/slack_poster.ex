defmodule SlackPoster do
  def post(text) do
    url = "https://slack.com/api/chat.postMessage"
    query = %{
      token: Application.get_env(:slack_poster, :slack_token),
      channel: Application.get_env(:slack_poster, :slack_channel),
      text: text,
      icon_emoji: Application.get_env(:slack_poster, :slack_icon_emoji),
      username: Application.get_env(:slack_poster, :slack_name)
    }
    HTTPotion.post url, query: query
  end
end
