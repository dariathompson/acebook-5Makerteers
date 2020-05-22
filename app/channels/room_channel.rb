# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  # This is when a person is connected to the channel
  def subscribed
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! user_id: current_user.id, body: data['message']
  end
end
