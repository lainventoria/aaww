# Aaww

A simple Authentise API Wrapper using HTTMultiParty for uploads

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aaww'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aaww

## Usage

Start a new transaction:

    transaction = Aaww::Transaction.new key: 'your_api_key'

Generate a token for this transaction:

    transaction.create_token

Upload a file and get a link to send the user to:

    transaction.upload File.new('some.stl'), 'some@email.com', 3.99

or just `upload!` if you instantiated the Transaction with everything needed:

    transaction = Aaww::Transaction.new key: 'your_api_key', file: File.new('some.stl'), email: 'some@email.com', value: 3.99
    transaction.upload!

Then, you can access the token links created by Authentise with:

    transaction.link
    transaction.ssl_link

## Contributing

1. Fork it ( https://github.com/lainventoria/aaww/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
