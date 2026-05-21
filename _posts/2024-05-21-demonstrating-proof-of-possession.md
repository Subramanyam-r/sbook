---
title: "Demonstrating Proof of Possession [DPoP]"
description: "A comprehensive exploration of Demonstrating Proof of Possession (DPoP) tokens, examining their core security mechanisms and guiding you through a practical implementation."
cover_image: "assets/images/blogs/dpop/dpop-thumbnail.png"
published: false
---

# **Demonstrating Proof of Possession (DPoP)**

- In today's systems, access tokens are very common. Although we do our best measures to make sure that the token's are handled securely, ultimately the tokens end up in the client applications and are exposed to leaks and voluntary sharing of the tokens.

- I'd like to picturize Access Tokens as Debit Cards.
  Both have an expiry but it's important to keep them safe until the expiry. Sharing them to others is going to cause illegitimate use of them.

- One beautiful security feature about debit cards is that, even if you lose the card, no one will be able to use them, since you need to prove your identity by entering the OTP/PIN when trying to use the card.

- DPoP is somewhere similar to this security feature. Here, DPoP will be the OTP/PIN that you use along with your access tokens.

Well, DPoP's can also be leaked? We got that covered. Keep reading!

## So, What's a DPoP?

- A DPoP is a JWT token, that is signed by keys from the TPM (Trusted Platform Module).

- A TPM is a hardware module, where you can create, maintain keys and sign data with them. The keys created in TPM will never leave it. You can only send data that needs to be signed and TPM would sign it internally and return the signed / encrypted data. No where in the memory shall you find traces of the private key ever. Now you see where this is going?

- This DPoP Token is sent in the header along with the access token. Something like this:

| Header Name   | Value                 |
| :------------ | :-------------------- |
| DPoP          | \<dpop_token\>        |
| Authorization | DPoP \<access_token\> |

- Notice how we are passing `DPoP` in Authorization header instead of `Bearer`.

{: .note-title}

> NOTE
>
> One important detail about DPoP is that the client must generate a new **DPoP proof** (a JWT) for _every_ API request made with the access token. These proofs have a very short validity window—typically 10 seconds to 1 minute, which is configurable based on business needs. The shorter the expiry window, the stronger the security against replay attacks.

## Syntax of a DPoP JWT Token

### JWT Header

| Header | Data Type  | Schema    | Value                                      | Example               |
| :----- | :--------- | :-------- | :----------------------------------------- | :-------------------- |
| typ    | String     | Mandatory | Type of the JWT token                      | `dpop+jwt`            |
| alg    | String     | Mandatory | Signing Algorithm used for signing the JWT | `RS256`               |
| jwk    | JWK Object | Mandatory | Public Key for Signature verification      | _See Snippet 1 below_ |

**Snippet 1: Example JWK Object**

```json
{
    "kty": "RSA",
    "n": "qPfgaTEWEP3S9w0tgsicURfo-nLW09_0KfOPinhYZ4ouzU-3xC4pSlEp8Ut9FgL0AgqNslNaK34Kq-NZjO9DAQ",
    "e": "AQAB"
}
```

### JWT Claims | Payload

| Header | Data Type | Schema                                              | Value                                         | Example                                      |
| :----- | :-------- | :-------------------------------------------------- | :-------------------------------------------- | :------------------------------------------- |
| jti    | String    | Mandatory                                           | Unique ID for the DPoP                        | 20a868e2-9019-472f-b092-28c4a28a53d4         |
| htm    | String    | Mandatory                                           | HTTP Method where the DPoP is being used for. | POST                                         |
| htu    | String    | Mandatory                                           | HTTP URL where the DPoP is being used for.    | https://example.com/api/v1/token/resource    |
| iat    | Integer   | Mandatory                                           | Token issuance timestamp in epoch seconds.    | 1779384166                                   |
| ath    | String    | Mandatory when DPoP is used along with access_token | SHA256(access_token) as base64 string         | z6uttrN1hluH6QC1csrlo75jUO9+c6hJXbsavMVbNs4= |

## Usage of DPoP

- DPoP is required and validated both when issuing the access token, as well as while using the issued access token.
- As discussed earlier, A DPoP Token needs to be generated freshly every time it's used and has a very low expiry.
- The DPoP token itself doesn't have a expiry in payload (Since client is generating it). But the expiry is configured at the backend and calculated by using the `iat` field.

Let's try to Visualize the usage of DPoP:

![Image]({{ site.baseurl }}/assets/images/blogs/dpop/fig1.png){: width="600" .d-block .mx-auto }

_Fig 1. Usage of DPoP_{: .d-block .text-center }
