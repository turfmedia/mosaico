# Messenger

## Presentation

Messenger is a platform to centralize any communication from applications to users.

An _application_ should be able to send a _message_ to 1 user or to 1 _channel_. Users (_members_) must be subscribed to a _channel_ by an application prior to receive any channel's message. _Messages_ should be sent via a _media_ defined by application or associated with a _channel_. Messenger will provide communication via _email_, _sms_ and _in app_.

## Stage 1 - Simple Messenger

First stage is to build APIs to subscribe members and send them messages via emails.

### Admin Interface

A simple admin interface protected by a login would help to manage entities of a Messenger. This admin interface will be accessed and managed by Admin Users as an independant entity.

![Data Model](docs/images/Messenger.png)

* __Channels__: A channel is a topic to which members subscribe to receive messages from.
* __Groups__: Group of channels
* __Publishers__: A user (or application) allowed to publish messages. Has an API key to use from an application.
* __Permissions__: Permissions of Publishers to send message to permitted channels, can a publisher publish to a channel or not. A simple role management to manage admin and APIs access (subscriptions, messages). n-n relationship, 1 publisher can publish to many channels and 1 channel can have many publishers
* __Members__: People (email addresses) to receive messages
* __Subscriptions__: Member subscription (relationship entity) to channels
* __Messages__: Text messages with different parts (title/subject, body, ...) sent to a channel
* __Media__: means by which a message has been sent. It will be defined by its type and a configuration

### Subscriptions API

 _Subscription API_ for applications (_publishers_) to add or remove _members_ from permitted _channels_. A simple CRUD API with basic authentication.

    POST /channels/1/subscribers  #{email: 'stephane@example.com'}

    DELETE /channels/1/subscribers  #{email: 'stephane@example.com'}

#### Gem

A gem will be used by third party applicaiton to use Subscription API.

### Messages API

An Application should be able to send a _message_ to a targeted user (identified by his email address) or to channel's members. A simple CRUD API with basic authentication.

### Mailer

An extended Ruby Mailer for 1 recipient or broadcast delivery. Mailer should use background SMTP delivery with a queue and error handling. Every message sent should be logged.

* library to handle mails (send 1 email or bulk)
* template integration (liquid)
* multi configurations switch
* logging (what has been sent to whom)

#### Mail Media Configuration

* __from_name*__
* __from_email_address*__
* __reply_to_email_address__ (by default same as from)
* __bounced_email_address__ (by default same as from)
* __SMTP host__
* __SMTP username__
* __SMTP password__

#### JS Client Library

A basic JS library (could be Angular module) to manage (create, retrieve and delete) messages via API (CRUD). Need a publisher basic auth with its API key or with login token.

### Simple Messaging Interface

A simple interface (JS/HTML) using the JS Client Library to send messages to channels (first step). Publishers need to login first. Front End to publish messsages to a channel with a simple interface.

### Channel History

A page to display messages sent to a channel. Channel should have a publication history rule (for example, a message should be displayed only a day after being sent to a channel). Performance should be improved with a simple local html cache.

## Development Principles

* __Planned iterations__: write tasks that should be done and do what is written, 1 task at a time.
* __KISS__: every step is meant to be simple, complexity will come with succession of simple steps.
* __DRY__: no code is easier to maintain than no code. don't duplicate code and build object oriented structures.
* __Production Ready__: no TODO, no puts, no commented code, ... any code pushed should be final.
* __Tested__: every feature and public method should be tested properly. Think ETC: experiment, test, code.
* __Documented__: every method should have purpose, every purpose should be written. nothing is explicit.
