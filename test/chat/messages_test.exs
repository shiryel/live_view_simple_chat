defmodule Chat.MessagesTest do
  use Chat.DataCase

  alias Chat.Messages

  describe "messages" do
    alias Chat.Messages.Messager

    @valid_attrs %{content: "some content", user: "some user"}
    @update_attrs %{content: "some updated content", user: "some updated user"}
    @invalid_attrs %{content: nil, user: nil}

    def messager_fixture(attrs \\ %{}) do
      {:ok, messager} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_messager()

      messager
    end

    test "list_messages/0 returns all messages" do
      messager = messager_fixture()
      assert Messages.list_messages() == [messager]
    end

    test "get_messager!/1 returns the messager with given id" do
      messager = messager_fixture()
      assert Messages.get_messager!(messager.id) == messager
    end

    test "create_messager/1 with valid data creates a messager" do
      assert {:ok, %Messager{} = messager} = Messages.create_messager(@valid_attrs)
      assert messager.content == "some content"
      assert messager.user == "some user"
    end

    test "create_messager/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_messager(@invalid_attrs)
    end

    test "update_messager/2 with valid data updates the messager" do
      messager = messager_fixture()
      assert {:ok, %Messager{} = messager} = Messages.update_messager(messager, @update_attrs)
      assert messager.content == "some updated content"
      assert messager.user == "some updated user"
    end

    test "update_messager/2 with invalid data returns error changeset" do
      messager = messager_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_messager(messager, @invalid_attrs)
      assert messager == Messages.get_messager!(messager.id)
    end

    test "delete_messager/1 deletes the messager" do
      messager = messager_fixture()
      assert {:ok, %Messager{}} = Messages.delete_messager(messager)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_messager!(messager.id) end
    end

    test "change_messager/1 returns a messager changeset" do
      messager = messager_fixture()
      assert %Ecto.Changeset{} = Messages.change_messager(messager)
    end
  end
end
