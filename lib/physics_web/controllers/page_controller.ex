defmodule PhysicsWeb.PageController do
  use PhysicsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
