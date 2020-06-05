module PayjpMock
  def self.prepare_customer_information # Payjp::Customerのレスポンス
    {
      "id": "cus_2550eaa818b11c91ff28790eba09",
      "cards": {"count":1,"data":[{"id": "car_95b05b54b6353ba542209c22fe10","address_city": nil,"address_line1": nil,"address_line2": nil,"address_state": nil,"address_zip":nil,"address_zip_check":"unchecked","brand":"Visa","country":nil,"created":1591089336,"customer":"cus_2550eaa818b11c91ff28790eba09","cvc_check":"passed","exp_month":1,"exp_year":2021,"fingerprint":"e1d8225886e3a7211127df751c86787f","last4":"4242","livemode":false,"metadata":{},"name":nil,"object":"card","three_d_secure_status":nil}],"has_more":false,"object":"list","url":"/v1/customers/cus_2550eaa818b11c91ff28790eba09/cards"},
      "created": 1591089336,
      "default_card": "car_95b05b54b6353ba542209c22fe10",
      "description": nil,
      "email": nil,
      "livemode": false,
      "metadata": {"user_id":"2"},
      "object": "customer",
      "subscriptions": {"count":0,"data":[],"has_more":false,"object":"list","url":"/v1/customers/cus_2550eaa818b11c91ff28790eba09/subscriptions"}
    }
  end
end