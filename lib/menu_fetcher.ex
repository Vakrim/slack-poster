defmodule MenuFetcher do
  def requestFB do
    url = Application.get_env(:slack_poster, :facebook_page_url)
    headers = [ 'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.98 Safari/537.36' ]
    HTTPotion.get url, [ headers: headers ]
  end

  def getHTML(request) do
    request.body
  end

  def parseForImages(html) do
    selector = "[rel=theater] img"
    Floki.find(html, selector)
  end

  def getFirstImage do
    requestFB
    |> getHTML
    |> parseForImages
    |> List.first
    |> (fn {"img", img, []} -> img end).()
  end

  def call do
    Enum.find_value getFirstImage, fn
      {"src", src} -> src
      _ -> false
    end
  end
end
