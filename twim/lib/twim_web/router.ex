defmodule TwimWeb.Router do
  use TwimWeb, :router
  import Twim.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwimWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    delete "/sessions", SessionController, :logout
  end

  scope "/api", TwimWeb do
    pipe_through :api
  
    get "/tweets", TweetController, :search
  end
end
