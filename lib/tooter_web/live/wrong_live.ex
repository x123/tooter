defmodule TooterWeb.WrongLive do
  use TooterWeb, :live_view
  alias Tooter.Accounts

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        answer: :rand.uniform(10),
        score: 0,
        message: "Make a guess:",
        session_id: session["live_socket_id"]
      )
    }
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score} =
      if socket.assigns.answer == String.to_integer(guess) do
        {"Your guess: #{guess}. Real answer is #{socket.assigns.answer}. Correct!",
         socket.assigns.score + 1}
      else
        {"Your guess: #{guess}. Wrong. Real answer is #{socket.assigns.answer}. Guess again. ",
         socket.assigns.score - 1}
      end

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end
end
