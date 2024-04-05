defmodule RealDealApiWeb.Router do
  use RealDealApiWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug RealDealApiWeb.Auth.Pipeline
    plug RealDealApiWeb.Auth.SetAccount
  end

  scope "/api", RealDealApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/accounts", AccountController, :create
    post "/sign_in", AccountController, :sign_in
  end

  scope "/api", RealDealApiWeb do
    pipe_through [:api, :auth]

    # account
    get "/accounts/current", AccountController, :current_account
    get "/accounts/:id", AccountController, :show
    get "/sign_out", AccountController, :sign_out
    get "/refresh", AccountController, :refresh_session
    put "/accounts", AccountController, :update

    # user
    put "/users", UserController, :update
  end
end
