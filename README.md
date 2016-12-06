![Build](https://travis-ci.org/matheusazzi/simple-messenger.svg?branch=master)
[![Code Climate](https://codeclimate.com/github/matheusazzi/simple-messenger/badges/gpa.svg)](https://codeclimate.com/github/matheusazzi/simple-messenger)
[![Test Coverage](https://codeclimate.com/github/matheusazzi/simple-messenger/badges/coverage.svg)](https://codeclimate.com/github/matheusazzi/simple-messenger/coverage)

# Simple messenger

- [See it live!](https://simple-messenger-rails.herokuapp.com/)

## How it was done

- Previous messages are rendered when user access the page, after it, when user sends a message, user will send it to an API endpoint `POST (/api/v1/messages)`.

- When a message arrives in that endpoint the `MessageBroadcastJob` is started, and responds the client-side immediately with a `:no_content` status. It uses the job because I think a real-time chat should not block the I/O.

- The `MessageBroadcastJob` broadcasts the message to all users. It uses the `MessageService`, that will create the message in database and return the rendered message.

- After a message is created the `AttachmentBroadcastJob` is started, this job will use `AttachmentService` to look for URLs in the message body. It'll visit each URL to get its contents.

- **Again**, it's on a job, the message gets immediately back to the user (real-time), and through the job that is created later, user will receive those attachments.

This way we've a real-time asynchronous chat. The user receives every message almost instantaneously and a few microseconds/seconds later, user will see the attachments.

## Dependencies

 * Ruby 2.3.1
 * Rails 5.0.x
 * PostgreSQL 9.3
 * Redis for production

## Installation

*There's a setup file, so you can just use:*

```
git clone https://github.com/matheusazzi/simple-messenger.git
cd simple-messenger
./bin/setup
```
