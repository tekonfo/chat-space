json.messages @messages.each do |message|
  json.name     message.user.name
  json.date     message.time
  json.image    message.image
  json.id       message.id
  json.text     message.text
end
