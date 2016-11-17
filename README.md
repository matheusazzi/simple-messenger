![Build](https://travis-ci.org/matheusazzi/simple-messenger.svg?branch=master)
[![Code Climate](https://codeclimate.com/github/matheusazzi/simple-messenger/badges/gpa.svg)](https://codeclimate.com/github/matheusazzi/simple-messenger)
[![Test Coverage](https://codeclimate.com/github/matheusazzi/simple-messenger/badges/coverage.svg)](https://codeclimate.com/github/matheusazzi/simple-messenger/coverage)

# Simple messenger

## How it was done

All previous messages are rendered when user access the site, after it, when user sends a message, he will sent it to an API endpoint `POST (/api/v1/messages)`.

When a message arrives in that endpoint I start the `MessageBroadcastJob`, and respond immediately the client-side with a `:no_content` status. I use the job because I think a real-time should not block the I/O.

The `MessageBroadcastJob` broadcasts the message to all users. It uses the `MessageService`, that will create the message in database and returns the rendered message.

After a message is created the `AttachmentBroadcastJob` is started, this job will use `AttachmentService` to look for URLs in the message. It'll visit each URL to get its contents.

But **again**, it's on a job, so the message gets immediately back to the user (real-time), and through the job that is created after, the user will get the attachments.

This way we've a real-time asynchronous chat. The user receives every message almost instantaneously and a few microseconds/seconds later, he will see the attachments.

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
