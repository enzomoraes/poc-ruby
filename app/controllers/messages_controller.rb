class MessagesController < ApplicationController

  def create
    message = params[:message]

    $kafka.produce(
      topic: 'messages',
      payload: message.to_s,
    )

    render json: { message: 'Message published successfuly'} , status: :ok

  rescue => e 
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
