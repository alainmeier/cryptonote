# CryptoNote

[![CryptoNote in action](https://dl.dropboxusercontent.com/u/640957/GitHub/cryptonote.png)](https://cryptonote.me)

CryptoNote is a very simple open source web application that lets users encrypt and share messages. If you'd like to see an example of the site running, go to https://cryptonote.me

* All data is encrypted client side so that the server never sees what's on it.
* Messages are deleted from the server once the recipient has viewed it.
* Bots like Facebook are blocked so that they do not invalidate messages.

## Motivation

Sometimes you need to send something to somebody and be sure that they're the only person reading the message. So I decided to make a simple, open source, encrypted messaging system that anybody can pull and deploy to Heroku in minutes. Don't trust me? That's cool, install your own. Don't trust your web host? That's cool, they'll never be able to read your messages.

## Known Weaknesses

* The generated encryption password is currently being sent to the server (but isn't stored), so SSL is required for each install to ensure nobody reads your message. In the future I will remove this limitation. It also means the person hosting the site could potentially be decrypting your message on the server side.
* [The weaknesses of javascript and the browser in crypto](http://log.nadim.cc/?p=33) and [discussion surrounding that article](https://news.ycombinator.com/item?id=5768837)

## Getting Started

### System dependencies

- Ruby 2.2.0 or higher
- Rails 4.1.8 or higher
- Postgres 9.2.4 or greater

### Configuration

Ensure that you have Postgres installed, preferably through the [Heroku Postgres App](http://postgresapp.com) as we use it in both production and development.

Then, open your terminal to the project folder and run:

```
rake db:setup
rake db:migrate
```

### Ideas for the future

* Limit viewing by http referrer. For example, only people who clicked the link on Facebook or Twitter can view the message
* Time-based expiry. Make messages automatically die after x period of time.
* Javascript submission so we can carry over the password variable client-side instead of sending it to the server.
* The application.js file has some horrendously bad javascript that I may or may not rewrite soon depending on time. Don't hate the player, hate the time constraint. 
* Allow Markdown in decrypted messages.
* Allow code highlighting in decrypted messages.
* An API endpoint for creating new CryptoNotes + javascript package to do the crypto easily.

## License

CryptoNote is released under the terms of the MIT license. See LICENCE for more information or see http://opensource.org/licenses/MIT.

## Special Thanks

For the client-side encryption, all of the heavy lifting is done by the [Stanford Javascript Crypto Library](https://crypto.stanford.edu/sjcl/). Part of the reason I make this project was to help spread the word about the simple, but extremely well made library that anybody can use. Thanks to the team who made it!
