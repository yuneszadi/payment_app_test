Rails.configuration.stripe = {
  :publishable_key => 'pk_test_GTNkmDf9RGVDIU2Hd9GhJct90080mcsBGj',
  :secret_key      => 'sk_test_TMVeMJMKmc6D15FXYhoJib8k00j8HTPRYT'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
