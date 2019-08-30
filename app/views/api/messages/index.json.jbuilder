json.array! @messages do |message|
  json.content message.content
  json.id message.id
  json.name message.user.name
  json.image message.image.url
  json.date message.created_at.strftime("%Y/%m/%d %H:%M")
end
