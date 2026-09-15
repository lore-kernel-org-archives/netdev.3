Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A23537CE;
	Tue, 15 Sep 2026 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513066; cv=none; b=hSHo3shBU5ynxK8WBM4JdXYYQZ48bGZ4ofy/R9IJBjrXrRtYsmVGU/xHYLogUQ4rMU93YAkC4pMjx6L2kV+FgRkcEs2GVlwFKTGFhVBEqK4fW7eME/q888IWu8nEKbzqEGGfUuQgCk7BCp7BRFjKELb8H6sdFuSHiZAv3fDacbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513066; c=relaxed/simple;
	bh=40J3JuuggyXycxuu4XOC2srqPAHxluq5HBafWVrMUeA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6/PVMuXrZGv58xGD/HyckuWQOFrWd9sIQ+NfTWbCk+1lKxBI1bwXvbY+xcxL9ZATQ/W+fDlQaePtbcHcwbd0faofgOnfXpHUbU3h7uAKzHb3nN3P9U+Rxet1j49U8q22mdxz9Y58u0ofTmRlPWf3TcKDIk2qeuoBJEMlK/xKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+dZitYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+dZitYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47821F0089A;
	Tue, 15 Sep 2026 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513064;
	bh=qedofXm9C6w9CwQAzJ5pVL+YdLbVAXTt8Ap9srmkuZU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R+dZitYk5q5a4ykKK6bzYXRTvDVqhRnlk4A+Co7psinRWA9jqV0oOq5zx45N2XRVs
	 FfnkNiT8q1ilXfA1QsAUxwzkJrV95/Q0PFjVelqMEC0VbEdzyxSJNGdpBsgffgSnaY
	 wc9mWRyz6Mbw1FDU+jI+9GHtjbq3y8fukaZN6w+jEX3V4gMiVjpC6Q7xrew7GB+BWW
	 l7RVhZCXrQa88QPN3As/Y6b4UX0Ayk5lH+fTkurBHR2H5UwjlHsfFalNZ8YjyaFATN
	 bKjUsLihM+kOn1L5qVP1i7oDrAlMH0+FeFIyic/An4qI2qk/ziGPzsyZOfc1vcVvRo
	 Gsj608NyFMlVg==
Subject: Re: [PATCH net v10 10/14] rxrpc: Fix RxGK key parser to check enctype
 is supported
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:43 +0000
Message-ID: <178951306345.22033.3166494756326322419@kernel.org>
In-Reply-To: <20260914151340.3227501-11-dhowells@redhat.com>
References: <20260914151340.3227501-11-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] rxrpc_preparse_xdr_yfs_rxgk() charges the full token cost to
  prep->quotalen at net/rxrpc/key.c:209 (`prep->quotalen += datalen +…

--

rxrpc: Fix RxGK key parser to check enctype is supported

The RxGK key parser now looks up the userspace-supplied encryption type
with crypto_krb5_find_enctype() and rejects the token if the enctype is
unknown or if the supplied key length does not match the enctype.  The
RxGK-specific token handling is also made conditional on CONFIG_RXGK.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
> index cbd26da449510..cdef609996d28 100644
> --- a/net/rxrpc/key.c
> +++ b/net/rxrpc/key.c

[ ... ]

> @@ -166,12 +167,14 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  				       size_t datalen,
>  				       const __be32 *xdr, unsigned int toklen)
>  {
> +	const struct krb5_enctype *enc;
>  	struct rxrpc_key_token *token, **pptoken;
>  	time64_t expiry;
>  	size_t plen;
>  	const __be32 *ticket, *key;
>  	s64 tmp;
>  	size_t raw_keylen, raw_tktlen, keylen, tktlen;
> +	int ret = -EKEYREJECTED;
>  
>  	_enter(",{%x,%x,%x,%x},%x",
>  	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),

[ ... ]

> @@ -229,6 +232,17 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	token->rxgk->key.data	= token->rxgk->_key;
>  	token->rxgk->ticket.len = raw_tktlen;
>  
> +	/* Check the enctype is supported. */
> +	enc = crypto_krb5_find_enctype(token->rxgk->enctype);
> +	if (!enc) {
> +		ret = -ENOPKG;
> +		goto reject_token;
> +	}

[Severity: Medium]
Can this new -ENOPKG path leave prep->quotalen charged for memory that
was freed?

Earlier in rxrpc_preparse_xdr_yfs_rxgk() the whole token cost is added to
the quota before any of these checks run:

	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
	prep->quotalen += datalen + plen;

with tktlen bounded only by AFSTOKEN_GK_TOKEN_MAX (16384).  The
reject_token label then does kfree(token->rxgk) and kfree(token) without
subtracting that amount again.

Every pre-existing reject path here returned -EKEYREJECTED, -EKEYEXPIRED
or -ENOMEM, and rxrpc_preparse_xdr() turns those into an abort:

		switch (ret2) {
		case 0:
			ret = 0;
			break;
		case -EPROTONOSUPPORT:
			break;
		case -ENOPKG:
			if (ret != 0)
				ret = -ENOPKG;
			break;
		default:
			ret = ret2;
			goto error;
		}

-ENOPKG is the soft case: if another token in the same payload (for
example an RXKAD token) parsed successfully, ret stays 0 and the key is
still instantiated, so __key_instantiate_and_link() ->
key_payload_reserve(key, prep->quotalen) commits the inflated value
against the owner's key quota:

security/keys/key.c:key_payload_reserve() {
	...
		if (delta > 0 &&
		    (key->user->qnbytes + delta > maxbytes ||
		     key->user->qnbytes + delta < key->user->qnbytes)) {
			ret = -EDQUOT;
	...
}

Since key_quota_maxbytes defaults to 20000 bytes, a single crafted
add_key("rxrpc", "afs@...", ...) payload containing one valid RXKAD token
plus an RxGK token with an unsupported enctype appears to be able to
charge roughly 16KB that is not actually held, making later add_key()
calls for that uid fail with -EDQUOT.

Would it be better to do the enctype lookup and key length check before
the prep->quotalen += datalen + plen accounting, or to subtract
datalen + plen on the -ENOPKG path?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
