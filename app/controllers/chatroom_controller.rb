# frozen_string_literal: true

class ChatroomController < ApplicationController
  def show
    @messages = Message.all
  end
end
