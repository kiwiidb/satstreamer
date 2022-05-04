# Satstreamer

Live version at https://satstreamer.vercel.app.

Interact with the audience of your livestream through Lightning donations.

- Lightning Address compatible
- Text-to-speech: comedy ensured by reading out the messages or questions from you audience
- I am using [Streamlabs](https://streamlabs.com) to overlay this web app on a livestream.

## Getting started
- Go to https://getalby.com/node and copy the LNDhub connection string.
- Paste the LNDhub connection string into the box at https://satstreamer.app. Also fill in your Alby Lightning Address.
- Click "Stream" to start streaming.
- Give access to your webcam.
- All incoming payments should show up on this page.

## Regtest setup
You can use Alby's regtest environment to test out payments.

Import 1 account in https://satstreamer.vercel.app

`lndhub://aW2Pl8oMZmnjEqnpshf4:Gbx1MRxsmLta6QEscaUl@https://clnhub.regtest.getalby.com`

The Lightning address associated with this account is `test@regtest-address.vercel.app`.

And import 1 account in [Alby](https://getalby.com) or [Bluewallet](https://bluewallet.io) for sending:

`lndhub://KxGvxBw1XqfD9LjfmdEO:TQuWImQ4fSueTunpzFGx@https://clnhub.regtest.getalby.com`

Your donation should then show up in the web application and the comment should be read aloud.