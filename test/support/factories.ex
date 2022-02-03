defmodule MyApp.Factories do
  use ExMachina.Ecto, repo: MyApp.Repo
  use Timex

  def organization_factory do
    %MyApp.Accounts.Organization{
      name: sequence(:name, &"name-#{&1}")
    }
  end

  @spec user_factory :: MyApp.Accounts.User.t()
  def user_factory do
    %MyApp.Accounts.User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "hello world!",
      hashed_password: Bcrypt.hash_pwd_salt("hello world!"),
      timezone: "America/Los_Angeles",
      confirmed_at: DateTime.utc_now(),
      role: "user",
      organization: build(:organization)
    }
  end

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "hello world!"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      email: unique_user_email(),
      password: valid_user_password()
    })
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
