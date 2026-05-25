---
title: "Demonstrating Proof of Possession [DPoP]"
description: "A comprehensive exploration of Demonstrating Proof of Possession (DPoP) tokens, examining their core security advantages."
cover_image: "assets/images/blogs/dpop/dpop-thumbnail.png"
published: false
---

# **Demonstrating Proof of Possession (DPoP)**

- In today's systems, access tokens are very common. Although we do our best measures to make sure that the tokens are handled securely, ultimately the tokens end up in the client applications and are exposed to leaks and voluntary sharing of the tokens.

- In this article, I'll discuss how we can secure the access tokens by binding them to the TPM's public key. This article will only cover the high level concept of DPoP.

- I'd like to picture Access Tokens as Debit Cards.Both have an expiry but it's important to keep them safe until the expiry. Sharing them to others is going to cause illegitimate use of them.

- One beautiful security feature about debit cards is that, even if you lose the card, no one will be able to use them, since you need to prove your identity by entering the OTP/PIN when trying to use the card.

- DPoP is somewhere similar to this security feature. Here, DPoP will be the OTP/PIN that you use along with your access tokens.

Well, DPoPs can also be leaked? We got that covered. Keep reading!

## So, What's a DPoP?

- A DPoP is a JWT token, that is signed by keys from any hardware or software backed key stores like TPM (Trusted Platform Module). In this article, I'll talk about using TPM for generating the DPoPs.

- A TPM is a hardware module, where you can create, maintain keys and sign data with them. Once a keypair is created in the TPM, the private key never leaves the TPM. Only the public key can be exported to do signature verification. You can only send data that needs to be signed and TPM would sign it internally and return the signed / encrypted data. Nowhere in the memory shall you find traces of the private key ever. See where this is going?

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

## Binding of access token to the public key

- When the access token is being generated, we also add a new claim in the access token: `cnf.jkt`.

```json
{
    // all other access token claims,
    "cnf": {
        "jkt": "<thumbprint of the public key>"
    }
}
```

_Example of public key bound access token claims_{: .d-block .text-center }

- The value of this claim is the thumbprint of the public key.

- By doing this, we are binding the issued access tokens to a single public key and client will only be able to access resources from our server by providing a valid DPoP signed by a private key whose public key is bound to the access token.

- As we discussed earlier, private keys never leave TPM and this binding procedure locks and prevents any users from misusing the access token even if they get their hands on it. Only the system that generated the access token will be able to use the access token.

## Validation of DPoP

### Client Registration

- A DPoP is a client generated token. It can be generated by anyone with their TPM.

- In order to make sure that we know which client is using the dpop, we need to register the client details in our system. As a part of registration, we need to create a key pair for our application inside the TPM and get the public key and store it in our database.

- Along with DPoP, the client also need to pass a uniquely identifiable record (like machine code), which allows us to store and fetch the corresponding public key from our system and validate the dpop signature.

### Signature Validation

- As with any JWT, the first thing to validate is the DPoP's signature. Once we fetch the public key from our system based on the machine code or any other uniquely identifiable record, we validate the JWT signature.

### Header Validation

- As discussed above, there are 3 fields in the dpop header all of which needs to be validated.
    - `typ` - Type of DPoP: Needs to be exactly `dpop+jwt`
    - `alg` - Algorithm used to sign the DPoP - Configurable based on business needs. We can restrict to usage of certain algorithms alone and validate the same.
    - `jwk` - Public key's JWK, needs to match the public key stored in the system.

{: .note-title}

> NOTE
>
> In scenarios where the system allows multiple signing algorithms, it would be best to validate the dpop header first to know the signing algorithm and also check for public key mismatches, and then proceed with the signature validation with for the given algorithm.

### Claims Validation

- Claims of a DPoP needs to be validated based on the following standard practice.
    - `jti` - Needs to be unique, JTI's of used / already validated DPoP needs to be persisted either in-memory or in Redis (Recommended). This will help us identify already used DPoP's and prevent their usage thus preventing **Replay Attacks**. The persisted JTIs can have configurable TTL based on the business needs. Since the expiry of DPoP is very less, the TTL for the JTIs can be the same as expiry or a little longer.

    - `htm` - Method where the DPoP is being used. Needs to match with the method where the DPoP is being validated.

    - `htu` - Full URL where the DPoP is being used. Needs to match with the URL where the DPoP is being validated.

    - `iat` - Should not be in future and expiry validation needs to be done based on the configured DPoP expiry.

    - `ath` - Hash of the Access Token. This field needs to be populated and validated only when the DPoP is being used along with the access_token. Generate a `Base64(SHA256(access_token))`. The generated value needs to match the `ath` claim.

### Binding Validation

- The access tokens as discussed earlier will have a `cnf.jkt` claim which is the thumbprint of the public key of the system that generated the access token.

- The value of this claim needs to match with the public key of the DPoP that's being passed along with the access token (jwk field of DPoP header).

## Security advantages of using DPoP

- **Mitigation of Token Theft**: Access token is secured and bound to the party that generates it. If leaked, access token cannot be misused.

- **Prevention of Replay attacks**: Even if an attacker manages to get both DPoP and access token over network, it still can't be used as DPoP is a single-use token and has a very short validity (ideally 10 seconds).

- **API Endpoint Level Security**: Each DPoP is signed with `htm` and `htu` claims making it useable only for the intended endpoint.

## Customizations

- Business requirements always requires customizations. The above mentioned concept for DPoP is merely just a foundation layer and a standard practice for a basic implementation.

- The DPoP token can be customized to add in any more custom claims and add more validations to add more security to your applications.

## Concluding Note

DPoP adds a crucial layer of defense for modern APIs. I hope it was a good read. This is my first blog and if you have any suggestions, feel free to write to <a href="javascript:void(0)" onclick="navigator.clipboard.writeText('subramanyam.r.2001@gmail.com'); alert('Email copied to clipboard!');">subramanyam.r.2001@gmail.com</a> or get in touch over linkedin: [linkedin.subramanyam.dev](https://linkedin.subramanyam.dev)
