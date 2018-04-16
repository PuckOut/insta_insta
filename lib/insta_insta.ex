defmodule InstaInsta do
  use HTTPoison.Base
  # Date Limiter
  # Pages Limiter
  # Rows Limiter
  # ID's manager
  @doc """
    Use this function to generate the right url
  """
  def generate_url(type, params \\ nil)

  # User Profile
  # URL => https://www.instagram.com/#{username}/?__a=1
  def generate_url("user_profile", %{username: username}),
    do: "https://www.instagram.com/#{username}/"

  # User Media
  # URL => https://instagram.com/graphql/query/?query_id=17888483320059182&id=#{user_id}&first=#{count}&after=#{end_cursor}
  # URL2 => https://www.instagram.com/graphql/query/?query_hash=472f257a40c653c64c666ce877d59d2b&variables={"id":"#{user_id}","first":#{count},"after":"#{end_cursor}"}
  def generate_url("user_media", %{
        user_id: user_id,
        count: count,
        end_cursor: end_cursor
      }),
      do:
        "https://www.instagram.com/graphql/query/?query_id=17888483320059182&id=#{user_id}&first=#{
          count
        }&after=#{end_cursor}"

  # Search by Tag
  # URL => https://www.instagram.com/explore/tags/#{tag}/?__a=1&max_id=#{max_id}
  def generate_url("search_by_tag", %{tag: tag, max_id: max_id}),
    do: "https://www.instagram.com/explore/tags/#{tag}/?__a=1&after=#{max_id}"

  # Search by Location
  # URL => https://www.instagram.com/explore/locations/#{location_id}/?__a=1&max_id=#{max_id}
  def generate_url("search_by_location", %{location_id: location_id, max_id: max_id}),
    do: "https://www.instagram.com/explore/locations/#{location_id}/?__a=1&max_id=#{max_id}"

  # General User Search
  # URL => https://www.instagram.com/web/search/topsearch/?query=#{query}&context=#{context ex:blended}&rank_token=#{rank_token ex:0.4948977584648091}
  def generate_url("search_user", %{
        query: query,
        context: context,
        rank_token: rank_token
      }),
      do:
        "https://www.instagram.com/web/search/topsearch/?query=#{query}&context=#{context}&rank_token=#{
          rank_token
        }"

  # Media Info
  # URL => https://www.instagram.com/p/#{media_code}/?__a=1
  def generate_url("media_info", %{media_code: media_code}),
    do: "https://www.instagram.com/p/#{media_code}/?__a=1"

  # Media Comments
  # URL => https://www.instagram.com/graphql/query/?query_id=17852405266163336&shortcode=#{shortcode}&first=#{count}&after=#{end_cursor}
  # URL2 => https://www.instagram.com/graphql/query/?query_hash=33ba35852cb50da46f5b5e889df7d159&variables={"shortcode":"#{shortcode}","first":#{count},"after":"#{end_cursor}"}
  def generate_url("media_comments", %{
        shortcode: shortcode,
        count: count,
        end_cursor: end_cursor
      }),
      do:
        "https://www.instagram.com/graphql/query/?query_id=17852405266163336&shortcode=#{
          shortcode
        }&first=#{count}&after=#{end_cursor}"

  # Media Likes
  # URL => https://www.instagram.com/graphql/query/?query_id=17864450716183058&shortcode=#{shortcode}&first=#{count}&after=#{end_cursor}
  # URL2 => https://www.instagram.com/graphql/query/?query_hash=1cb6ec562846122743b61e492c85999f&variables={"shortcode":"#{shortcode}","first":#{count},"after":"#{end_cursor}"}
  def generate_url("media_likes", %{
        shortcode: shortcode,
        count: count,
        end_cursor: end_cursor
      }),
      do:
        "https://www.instagram.com/graphql/query/?query_id=17864450716183058&shortcode=#{
          shortcode
        }&first=#{count}&after=#{end_cursor}"

  # Followers List
  # URL => https://instagram.com/graphql/query/?query_id=17851374694183129&id=#{user_id}&first=#{count}&after=#{end_cursor}
  # URL2 => https://www.instagram.com/graphql/query/?query_hash=37479f2b8209594dde7facb0d904896a&variables={"id":"#{user_id}","first":#{count},"after":"#{end_cursor}"}
  def generate_url("followers_list", %{
        user_id: user_id,
        count: count,
        end_cursor: end_cursor
      }),
      do:
        "https://www.instagram.com/graphql/query/?query_id=17851374694183129&id=#{user_id}&first=#{
          count
        }&after=#{end_cursor}"

  # Following List
  # URL => https://instagram.com/graphql/query/?query_id=17874545323001329&id=#{user_id}&first=#{count}&after=#{end_cursor}
  # URL2 => https://www.instagram.com/graphql/query/?query_hash=58712303d941c6855d4e888c5f0cd22f&variables={"id":"#{user_id}","first":#{count},"after":"#{end_cursor}"}
  def generate_url("following_list", %{
        user_id: user_id,
        count: count,
        end_cursor: end_cursor
      }),
      do:
        "https://www.instagram.com/graphql/query/?query_id=17874545323001329&id=#{user_id}&first=#{
          count
        }&after=#{end_cursor}"

  def user_profile(username) do
    http_response = run("user_profile", %{username: username})

    Regex.scan(~r/(?<=\window._sharedData =)(.*\n?)(?=;<\/script>)/, http_response.body)
    |> List.first()
    |> List.first()
  end

  def user_media(user_id, count, end_cursor \\ ""),
    do:
      run(
        "user_media",
        %{
          user_id: user_id,
          count: count,
          end_cursor: end_cursor
        },
        fake_headers(true)
      )

  def search_by_tag(tag, max_id \\ ""), do: run("search_by_tag", %{tag: tag, max_id: max_id})

  def search_by_location(location_id, max_id \\ ""),
    do: run("search_by_location", %{location_id: location_id, max_id: max_id})

  def search_user(query, context \\ "blended", rank_token \\ 0.4948977584648091),
    do:
      run("search_user", %{
        query: query,
        context: context,
        rank_token: rank_token
      })

  def media_info(media_code), do: run("media_info", %{media_code: media_code})

  def media_comments(shortcode, count, end_cursor \\ ""),
    do:
      run(
        "media_comments",
        %{
          shortcode: shortcode,
          count: count,
          end_cursor: end_cursor
        },
        fake_headers(true)
      )

  def media_likes(shortcode, count, end_cursor \\ ""),
    do:
      run(
        "media_likes",
        %{
          shortcode: shortcode,
          count: count,
          end_cursor: end_cursor
        },
        fake_headers(true)
      )

  def followers_list(user_id, count, end_cursor \\ ""),
    do:
      run(
        "followers_list",
        %{
          user_id: user_id,
          count: count,
          end_cursor: end_cursor
        },
        fake_headers(true)
      )

  def following_list(user_id, count, end_cursor \\ ""),
    do:
      run(
        "following_list",
        %{
          user_id: user_id,
          count: count,
          end_cursor: end_cursor
        },
        fake_headers(true)
      )

  @doc false

  defp run(
         type,
         params,
         headers \\ fake_headers(),
         options \\ [timeout: 50_000, recv_timeout: 50_000]
       ) do
    generate_url(type, params)
    |> get!(headers, options)
  end

  defp post_login(%{username: username, password: password}) do
    login_body = "username=#{username}&password=#{password}"

    HTTPoison.post(
      "https://www.instagram.com/accounts/login/ajax/",
      login_body,
      fake_headers()
    )
  end

  def get_cookies(username, password) do
    {:ok, headers} = post_login(%{username: username, password: password})

    cookies =
      Enum.filter(headers.headers, fn
        {"Set-Cookie", _} -> true
        _ -> false
      end)
      |> Enum.map(fn x -> Enum.at(String.split(elem(x, 1), ";"), 0) end)
      |> Enum.join("; ")

    cookies
  end

  defp fake_headers(get_cookies \\ nil) do
    random = random_string()

    if get_cookies do
      cookies =
        get_cookies(
          Application.get_env(:insta_insta, :username),
          Application.get_env(:insta_insta, :password)
        )
    else
      cookies = "csrftoken=#{random};"
    end

    [
      "content-type": "application/x-www-form-urlencoded",
      "X-CSRFToken": random,
      cookie: cookies,
      Referer: "https://www.instagram.com/",
      "x-instagram-ajax": "1",
      "x-requested-with": "XMLHttpRequest"
    ]
  end

  defp random_string(length \\ 10) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> binary_part(0, length)
    |> String.replace(~r/[_-]/, "a")
  end
end
