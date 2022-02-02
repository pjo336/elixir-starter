# elixir-starter
A short guide running through how I configure my apps in elixir/phoenix when I first start them.

#### Create App
`mix phx.new <app-name> --live --binary-id`

#### Generate docker-compose to run postgres db
```
version: '3'

services:
    database:
        image: postgres:14
        ports:
            - "5453:5432"
        volumes:
            - ./postgresql/data:/var/lib/postgresql/data
        environment:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: postgres
            POSTGRES_DB: <app-name>_dev
```

#### Update dev.exs and test.exs to match
```elixir
config :app_name, AppName.Repo,
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", "postgres"),
  port: System.get_env("POSTGRES_PORT", "5453"),
  hostname: System.get_env("DATABASE_HOST", "localhost"),
  database: "<app-name>_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

```elixir
config :app_name, AppName.Repo,
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", "postgres"),
  port: System.get_env("POSTGRES_PORT", "5453"),
  hostname: System.get_env("DATABASE_HOST", "localhost"),
  database: "<app-name>_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox
```

#### Setup Auth
Auth is now built into phoenix 1.6
- Run command:

    `mix phx.gen.auth Identity UserIndentity user_identities --binary-id`
- Fetch new deps

    `mix deps.get`
- Migrate db

    `mix ecto.migrate`
    
#### Add libraries for testing
##### excoveralls
    {:excoveralls, "~> 0.14", only: :test}
    add to project block in mix.exs
    ```
        test_coverage: [tool: ExCoveralls],
    preferred_cli_env: [
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test
    ]
    ```
    
##### ex_machina
`{:ex_machina, "~> 2.7", only: :test}`
add to the start of test_helper.exs
`{:ok, _} = Application.ensure_all_started(:ex_machina)`
