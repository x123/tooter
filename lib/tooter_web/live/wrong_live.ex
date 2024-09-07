defmodule TooterWeb.WrongLive do
  use TooterWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       answer: :rand.uniform(10),
       score: 0,
       message: "Make a guess:"
     )}
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
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {message, score} = if socket.assigns.answer == String.to_integer(guess) do
      {"Your guess: #{guess}. Real answer is #{socket.assigns.answer}. Correct!", socket.assigns.score + 1}
    else
      {"Your guess: #{guess}. Wrong. Real answer is #{socket.assigns.answer}. Guess again. ", socket.assigns.score - 1}
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
