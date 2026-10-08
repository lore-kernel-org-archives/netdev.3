Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691D3AD524;
	Thu,  8 Oct 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476017; cv=none; b=Gq+Fbk5driZZcrRWDxbgaZnhH3Nkcceh+IWDX/ng8eRkfqEODVaJEbM5yi9jC2H7l0QWja3Ou3k3YpxrPGUs+E1ULMgx0uCwI9bOKQcHITOPKSoAuYdzZYoVt5Xc8/Isrl0XNmYdXJYaGPeyhMDSM8Sl6+LdV2vOO5B+jmKjOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476017; c=relaxed/simple;
	bh=u859W4su+QcLuFKbfr1flJpm9tWwZs2jVCDjMClNRWE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLV5J9cB143hyaAy8SXNHNGgcvDHtYjxd0y2+YQ1sUiMk4ymWVpyqNfreDlvlQNYyuF1wr3vn8JA2qcjixEFKn57BF6iWv7anmCFdjzNbUT/WABhgFoG65SIHpZjpKp8xJiFyxj20dz4NmiErgsoyi12mxsL8l4UXyv6+H8II/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEBnfmgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEBnfmgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4FC1F0089A;
	Thu,  8 Oct 2026 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476012;
	bh=UPhf6SEUUNz8uyNHVl3Ju/fey1kkhAAA2gvcBBSzhmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MEBnfmgqFGyZ46WJ17WemSZAQPo+ecR4XoVoDDODsBuEk5SjZ2i4DO6nEsEb9Cc9m
	 EUZwtl6QHCaWdAiwyTYx406QT08dJ6QEt4E0oHFCif5H3ru8gtdN2tjrmrBF5lPjtl
	 ZUDQeoqAPTgk5tu2HC4QElK2KeCzNSkZ1UgIQk2xxOcRjbpMSIq22gy92aSsHgvzFd
	 2Z1UGMrErebKzz7Tef/8/8mwSjZllqxzLtAITkazYOW2OOOvCY/LxabyC7wGUwgF6C
	 5thaQlooYQBJ+//e97ospz+YQ9nI9WL6BTFfWzJpJjBbJTpLCrjpZlJoAX8ExSOTSc
	 sePcq135/fhNg==
Subject: Re: [PATCH net v12 14/15] rxrpc: Fix RxGK key parser to check enctype
 is supported
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:31 +0000
Message-ID: <179147601139.434549.14218294714340800213@kernel.org>
In-Reply-To: <20261006133011.531806-15-dhowells@redhat.com>
References: <20261006133011.531806-15-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch moves the RxGK quota charge in
  rxrpc_preparse_xdr_yfs_rxgk() (net/rxrpc/key.c) to the success path,…
- [Medium] The patch adds a new -EKEYREJECTED return to
  rxrpc_preparse_xdr_yfs_rxgk() when `raw_keylen != enc->key_len`.

--

rxrpc: Fix RxGK key parser to check enctype is supported

The RxGK XDR key parser now looks up the enctype with
crypto_krb5_find_enctype(). It also rejects keys whose length does not
match that enctype. The RxGK key handling is put under CONFIG_RXGK, and
both parsers now charge a token to the quota only once the token is
attached.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
> index cbd26da449510..904da3fe7e478 100644
> --- a/net/rxrpc/key.c
> +++ b/net/rxrpc/key.c

[ ... ]

> @@ -229,6 +226,17 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	token->rxgk->key.data	= token->rxgk->_key;
>  	token->rxgk->ticket.len = raw_tktlen;
>  
> +	/* Check the enctype is supported. */
> +	enc = crypto_krb5_find_enctype(token->rxgk->enctype);
> +	if (!enc) {
> +		ret = -ENOPKG;
> +		goto reject_token;
> +	}
> +	if (raw_keylen != enc->key_len) {
> +		ret = -EKEYREJECTED;
> +		goto reject_token;
> +	}

[Severity: Medium]
How does this new -EKEYREJECTED return interact with the server-side
ticket path?

rxgk_yfs_decode_ticket() in net/rxrpc/rxgk_app.c builds an XDR payload
from the decrypted ticket. It copies the ticket's enctype and key length
as-is, then calls key_instantiate_and_link(), which reaches this code:

rxgk_extract_token()
  rxgk_yfs_decode_ticket()
    key_instantiate_and_link()
      rxrpc_preparse()
        rxrpc_preparse_xdr()
          rxrpc_preparse_xdr_yfs_rxgk()

rxrpc_preparse_xdr() passes -EKEYREJECTED back up. The cant_get_token
switch in rxgk_extract_token() only handles three error codes:

net/rxrpc/rxgk_app.c:rxgk_extract_token() {
    ...
cant_get_token:
	switch (ret) {
	case -ENOMEM:
		goto temporary_error;
	case -EINVAL:
		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EKEYREJECTED,
					rxgk_abort_resp_tok_internal_error);
	case -ENOPKG:
		return rxrpc_abort_conn(conn, skb, KRB5_PROG_KEYTYPE_NOSUPP,
					-EKEYREJECTED, rxgk_abort_resp_tok_nopkg);
	}

temporary_error:
	/* Ignore the response packet if we got a temporary error such as
	 * ENOMEM.  We just want to send the challenge again.  ...
}

So -EKEYREJECTED falls through to temporary_error. rxgk_verify_response()
then does goto out without an abort, and rxrpc_do_process_connection()
ignores the return value of rxrpc_process_event().

Before this patch, a ticket whose K0 length did not match its enctype
still got through key creation. It failed later instead:

- in rxgk_generate_transport_key() or rxgk_set_up_ciphers(), aborted with
  RXGK_NOTAUTH
- or in authenticator decryption, aborted with RXGK_SEALEDINCON

With this patch, is the RESPONSE silently dropped, so the connection keeps
re-challenging until it times out instead of being aborted? The gap in
the switch was already there, but this patch adds a new way to reach it.

Should rxgk_extract_token() handle -EKEYREJECTED explicitly?

[ ... ]

> @@ -257,6 +265,8 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	_debug("TICK: %*phN",
>  	       min_t(u32, token->rxgk->ticket.len, 32), token->rxgk->ticket.data);
>  
> +	prep->quotalen += sizeof(*token) + datalen + tktlen + keylen;

[Severity: Medium]
Is sizeof(*token->rxgk) meant to be left out here? The removed code
charged it:

	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
	prep->quotalen += datalen + plen;

The struct rxgk_key header is still allocated by
kzalloc_flex(struct rxgk_key, _key, raw_keylen), and it lives as long as
the key. That means each RxGK token is now under-charged by
sizeof(struct rxgk_key), which is 72 bytes on 64-bit.

In this same patch, the RxKAD parser still counts sizeof(*token->kad) in
plen. The commit message only says a token should be charged when it is
used. It does not mention charging less.

The datalen term does not make up the difference, because
rxrpc_preparse_xdr() only calls the per-token parsers once the remaining
datalen has reached 0. generic_key_instantiate() then passes
prep->quotalen directly to key_payload_reserve().

A key can hold up to AFSTOKEN_MAX tokens. Could an unprivileged user use
this to pin more memory in rxrpc keys than their key quota allows?

>  	/* count the number of tokens attached */
>  	prep->payload.data[1] = (void *)((unsigned long)prep->payload.data[1] + 1);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
