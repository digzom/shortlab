defmodule Shortlab.RollbaxConfig do
  def config(config) do
    config
    |> Keyword.put(:access_token, System.get_env("ROLLBAR_ACCESS_TOKEN"))
    |> Keyword.put(:environment, System.get_env("ROLLBAR_ENVIRONMENT"))
  end
end
