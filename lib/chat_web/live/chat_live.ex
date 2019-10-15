defmodule ChatWeb.ChatLive do
  use Phoenix.LiveView
	alias Chat.Messages.Messager

  def render(assigns) do
    ChatWeb.ChatView.render("show.html", assigns)
  end

  def mount(_conn, socket) do
		if connected?(socket) do
			Phoenix.PubSub.subscribe(:pubsub, "messages")
		end
    {:ok,
      assign(socket,
        chat_messages: [],
        user: "vinicius"
        )
    }
  end

	def handle_event("send", %{"message" => message}, socket) do
		Phoenix.PubSub.broadcast(:pubsub, "messages", {:append, message})

		{:noreply, socket}
	end

	def handle_info({:append, message}, socket) do
		messages = [message | socket.assigns.chat_messages]

		{:noreply, assign(socket, chat_messages: messages)}
	end
end
