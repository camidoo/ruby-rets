# Overview

## 2.0.7

Confirmed to work with Ruby 2.0.0-p0

### Fixes
  * `RETS-Version` is no longer set to `RETS/1.7` unless an error `20037` is returned and no other one is specified
  * `RETS-Version` can be set based on a HTTP 200 response for systems which only pass it after authentication (Innovia)

## 2.0.6

### Features
  * System name added to `rets_data[:system_id]` when pulling metadata out
  * `client.request_size` and `client.request_hash` can be used when streaming is disabled in `client.search`
  * Added `client.request_time` which gives the time taken in seconds for a `client.search` or `client.get_object` to run

### Fixes
  * Fixed an authentication issue when using Retsiq where it would return 20041 in place of HTTP 401
  * Fixed errors when streaming with an unknown Content-Length and chunked encoding
  * Fixed a block being required when making a `client.search` call with `:count_mode => :only`
  * Fixed character encoding that was causing issues on some RETS servers (Paul Trippett)
  * Fixed an exception when Rapattoni RETS servers returned a "RETS-STATUS" XML tag on a multipart `client.get_object` call
  * Fixed a `RETS::APIError` code 0 error under some RETS systems when making a call to `client.get_object` with `:location`

## 2.0.5

### Features
  * Make `client.rets_data` available immediately when calling `client.search` rather than having to wait until it finishes (Paul Trippett)
  * `:rets_version` can be passed to `client.login` without the User-Agent fields being set, for RETS servers that require the version to be passed initially

### Fixes
  * Default to HTTP Digest authentication when Digest and Basic are provided (Paul Trippett)
  * Fixed authentication header parser if a server returns Basic/Digest and the Digest data goes stale (Paul Trippett)
  * Fixed query strings from the initial login request not being saved when discovery service URLs (Paul Trippett)

## 2.0.4

### Features
  * Added support for RETS servers that use digest authentication without the quality of protection flag (MRIS)
  * Added SSL support (Paul Trippett)

### Fixes
  * Fixed metadata parsing breaking if a field wasn't filled out (Paul Trippett)
  * Fixed multipart parsing for `client.get_object` if a part is blank

## 2.0.3

### Fixes
  * Fixed a stack overflow due to how Interealty handles User-Agent authentication errors

## 2.0.2

### Features
  * Dropped support for TimeoutSeconds, instead if an HTTP 401 is received after a successful request then a reauthentication is forced. Provides better compatibility with how some RETS implementations handle sessions

### Fixes
  * Client methods no longer return the HTTP request
  * Requests will correctly be called after a HTTP digest becomes stale

## 2.0.1

### API Changes
  * `client.login` will now raise `ResponseError` errors if the RETS tag cannot be found in the response
  * `client.login` added the ability to pass `:rets_version` to force the RETS Version used in HTTP requests. Provides a small speedup as it can skip one HTTP request depending on the RETS implementation
  * `client.get_object` can return both Content-Description or Description rather than just Description. Also will return Preferred

### Features
  * Added support for TimeoutSeconds, after the timeout passes the gem seamlessly reauthenticates
  * Improved the edge case handling for authentication requests to greatly increase compatability with logging into any RETS based system

### Fixes
  * Object multipart parsing no longer fails if the boundary is wrapped in quotes
  * Response parsing won't fail if the RETS server uses odd casing for the "ReplyText" and "ReplyCode" args in RETS

## 2.0.0

### API Changes
  * `client.logout` will now raise `CapabilityNotFound` errors if it's unsupported
  * `client.get_object` now requires a block which is yielded to rather than returning an array of the content
  * `client.get_object` headers are now returned in lowercase form ("content-id" not "Content-ID" and so on)
  * `RETS::Client.login` now uses `:useragent => {:name => "Foo", :password => "Bar"}` to pass User Agent data
  * `RETS::Client.login` no longer implies the User-Agent username or password by the primary username and password

### Features
  * Added support for Count, Offset, Select and RestrictedIndicators in `client.search`
  * Added support for Location in `client.get_object`
  * RETS reply code, text and other data such as count or delimiter can be gotten through `client.rets_data` after the call is finished

### Fixes
  * Redid how authentication is handled, no longer implies HTTP Basic auth when using RETS-UA-Authorization
  * RETS-Version is now used for RETS-UA-Authorization when available with "RETS/1.7" as a fallback
  * Exceptions are now raised consistently and have been simplifed to `APIError`, `HTTPError`, `Unauthorized` and `CapabilityNotFound`
  * `HTTPError` and `APIError` now include the reply text and code in `reply_code` and `reply_text`
