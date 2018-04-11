# InstaInsta

Scrapes Instagram JSON and HTML endpoints without a API key, inspired on InstaScrapex

Use at your own risk

## Installation

  1. Add `insta_insta` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:insta_insta, "~> 0.0.1"}]
    end
    ```

  2. Ensure `insta_insta` is started before your application:

    ```elixir
    def application do
      [applications: [:insta_insta]]
    end
    ```

## Usage
  All functions return a map in the `response[:body]`
  Functions wrap [HTTPoison.get!/3](https://hexdocs.pm/httpoison/HTTPoison.html#get/3) so you can pass headers and other options to them

### Endpoints

  ```elixir
  iex> InstaInsta.user_profile("nasa")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.user_media(12345, 20, "asdASD")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.search_by_tag("carnaval", "asd123")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.search_by_location(12345, "asd123")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.search_user(query)
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.media_info("BKgPf5ZgP97")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.media_comments("BKgPf5ZgP97", 20, "asdASD123")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.media_likes("BKgPf5ZgP97", 20, "asdASD123")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.followers_list(12345, 20, "asdASD123")
  %HTTPoison.Response{body: %{}, ...}
  ````

  ```elixir
  iex> InstaInsta.following_list(12345, 20, "asdASD123")
  %HTTPoison.Response{body: %{}, ...}
  ````


## License
	InstaInsta is released into the public domain. See [UNLICENSE](http://unlicense.org/) for more information or the accompanying UNLICENSE file.

## Contact
  [Mail me if you want](mailto:flavio.killstars@gmail.com).
