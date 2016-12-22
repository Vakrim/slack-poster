defmodule PeoplePresenceChecker do
  @people Application.get_env(:slack_poster, :slack_people)
  @present_statuses ["active", "away"]

  def requestSlack do
    token = Application.get_env(:slack_poster, :slack_token)
    url = "https://slack.com/api/users.list"
    query = %{
      token: token,
      presence: 1
    }
    HTTPotion.get(url, query: query)
  end

  def parseJSON(body) do
    Poison.Parser.parse! body
  end

  def in_stolowka_crew?(member) do
    Enum.member? @people, member["profile"]["real_name"]
  end

  def more_than_half_present?(members) do
    present_count = Enum.count(members, fn(x) -> Enum.member?(@present_statuses, x["presence"]) end)
    all_count = Enum.count(members)
    present_count / all_count >= 0.5
  end

  def call do
    requestSlack
    |> Map.get(:body)
    |> parseJSON
    |> Map.get("members")
    |> Enum.filter(&in_stolowka_crew?/1)
    |> more_than_half_present?
  end
end
