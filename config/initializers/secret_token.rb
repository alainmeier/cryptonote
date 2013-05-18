# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Cryptonote::Application.config.secret_key_base = 'e104a73b418529254d1da90ffcb3b24428e9f2727aa11f2015fcad5fd290f8a0d29672a503aa1913bf98319ffc37b59fa4e285c802bc33f4a5bafa44056971d5'
