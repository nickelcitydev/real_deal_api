defmodule RealDealApiWeb.AccountJSON do
  alias RealDealApiWeb.UserJSON
  alias RealDealApi.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  def show(%{account: account, token: token}) do
    %{data: data(account, token)}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      user: UserJSON.show(%{user: account.user})
    }
  end

  defp data(%Account{} = account, token) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
