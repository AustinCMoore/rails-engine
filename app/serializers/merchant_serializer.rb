class MerchantSerializer
  include JSONAPI::Serializer
  attributes :id, :name
end

# {
#   'data': mechants.map do |merchant|
#     {
#       'id': merchant.id,
#       'type': 'merchant'
#       'attributes': {
#         'name': merchant.name
#       },
#       'relationships': {
#         'merchants': {
#           'data': [
#             {
#               'id': '1',
#               'type': 'merchant'
#             },
#             {
#               'id': '4',
#               'type': 'merchant'
#             }
#           ]
#         }
#       }
#     }
#   end
# }
