Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C823ACA41;
	Mon, 20 Jul 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559383; cv=none; b=iFtEJVE5LdbLlphchzOjEvBKwV7aUjA/rdjiCVc9LoUgnHrLZISl+XoCOpexnftqcPQXpBNcHFAvrc2ErN/kzSTY4e4auqx6Qcaih+hRG7cILs0uIP491l4ajTzvtK+nlrn7+IzzzELcMQ7Ka6B1OJc/qEZSKVznbcFeGFtKpS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559383; c=relaxed/simple;
	bh=NETP1+3tyE6dgBZ92DHW2hoY0kRsig+XMhV7skNcINQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5JCXlFML0DjL0+OqZuXGXFL3fg4m2mmArQ4r9AziRVasEuIQBh2iKFR7x9pBtX9c0+SSOICg4Fj9NQ36qUfZPaFrMYCNtdhDH2xiAg4HkYMfISwdajadiiw3oU1U1BXuXRFd/3D8eJoNYm4RRktdlkUCLpOke+jOJUtd6mwh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQnuB6sL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQnuB6sL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B584A1F000E9;
	Mon, 20 Jul 2026 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559381;
	bh=dbzHRhzW+ulGZerQ30J2qwBhBhYxhsNlqDw/nn5yzw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WQnuB6sLBoTTYK/Qdu9whSgK96ICBI0XJr96lsyvkCbgZhul9xWBU65Aa7KHbbZ2d
	 hdog8zpFhk5NiRkxvNcWP4EgkYcKTaFl6q09cghD+xxOcPolWVMWJ/Gkoak1ISSenQ
	 DbqGWrKIKuq2CoQvQpRcrNh1LNuUHVR6+EFbYCAFZv26lEKBgB9GmBmmxncivEPo6s
	 Ql+PXnYD0JHiOJ3T0V+rSM3/v1VpAdSvFug1fXV5zQFvTPWYL8SEJYZSUypvs4sA70
	 KRKKSvCd0UQW9jtVTdjaFN8nZA75Udoc0SeNwPlnYiwg1VKJu6NtLjioKmrU3Imcf+
	 xvYqwYd8xnVKQ==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net v3 13/14] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation
Date: Mon, 20 Jul 2026 15:54:23 +0100
Message-ID: <20260720145422.195990-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713081022.2186481-14-dhowells@redhat.com>
References: <20260713081022.2186481-14-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713081022.2186481-8-dhowells@redhat.com?part=13
---
--- Patch [13]: [PATCH net v3 13/14] rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation ---
commit ebc5bb53c96c167e2d7c2726bed42c09fd3a97d1
Author: David Howells <dhowells@redhat.com>

rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE generation

This commit removes the out-of-band queueing mechanism for rxrpc challenge
packets, moving instead to a preemptively supplied application data key.
The event processor now parses the challenge and generates the response
directly using this key.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com

> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -405,7 +405,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  
>  	trace_rxrpc_recvmsg(0, rxrpc_recvmsg_enter, 0);
>  
> -	if (flags & (MSG_OOB | MSG_TRUNC))
> +	if (flags & MSG_TRUNC)
>  		return -EOPNOTSUPP;

[Severity: Medium]
Does removing MSG_OOB from this check cause out-of-band requests to silently
fall through and return in-band data?

By not returning -EOPNOTSUPP for MSG_OOB, the socket might violate standard
semantics by returning regular data when the caller explicitly requested
out-of-band data.

> --- a/net/rxrpc/rxgk.c
> +++ b/net/rxrpc/rxgk.c
> @@ -936,7 +937,7 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
>  	if (IS_ERR(gk))
>  		return PTR_ERR(gk);
>  
> -	auth_len = 20 + (4 + appdata->len) + 12 + (1 + 4) * 4;
> +	auth_len = 20 + (4 + appdata->datalen) + 12 + (1 + 4) * 4;

[Severity: Critical]
Is auth_len calculated incorrectly here by missing the padding for
appdata->datalen?

It looks like this unpadded length is used to calculate authx_len, which
determines the size of the skb and the scatterlist allocation.

Later, rxgk_construct_authenticator() uses rxgk_pad_out() to correctly
round up the written bytes:

ret = rxgk_pad_out(response, appdata->datalen, offset);

Since the written padded size is larger than the unpadded alloc_len
passed to rxgk_encrypt_authenticator(), will this cause the crypto layer
to write past the end of the scatterlist and corrupt memory?

[ ... ]

> @@ -1011,24 +1012,36 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
>   * Respond to a challenge packet.
>   */
>  static int rxgk_respond_to_challenge(struct rxrpc_connection *conn,
> -				     struct sk_buff *challenge,
> -				     struct krb5_buffer *appdata)
> +				     struct sk_buff *challenge)
>  {
> -	_enter("{%d,%x}", conn->debug_id, key_serial(conn->key));
> +	struct user_key_payload dummy = {}, *appdata = &dummy;
> +	int ret;
> +
> +	_enter("{%d,%u,%x,%x}",
> +	       conn->debug_id, conn->service_id,
> +	       key_serial(conn->key), key_serial(conn->bundle->app_data));
>  
>  	if (key_validate(conn->key) < 0)
>  		return rxrpc_abort_conn(conn, NULL, RXGK_EXPIRED, -EPROTO,
>  					rxgk_abort_chall_key_expired);
>  
> -	return rxgk_construct_response(conn, challenge, appdata);
> -}
> +	if (conn->bundle->app_data) {
> +		rcu_read_lock();
> +		appdata = (struct user_key_payload *)
> +			user_key_payload_rcu(conn->bundle->app_data);
> +		if (appdata && !refcount_inc_not_zero(&appdata->ref))
> +			appdata = NULL;
> +		rcu_read_unlock();

[Severity: Critical]
Is it safe to blindly cast the payload of conn->bundle->app_data to
a struct user_key_payload here?

If a non-user key like a keyring or logon key was somehow attached to
the call, this cast will interpret the alien key payload as a
user_key_payload. For example, if rxrpc_sendmsg_cmsg() in
net/rxrpc/sendmsg.c has an inverted type check that inadvertently accepts
non-user keys:

if (key_ref_to_ptr(key)->type == &key_type_user) {
    key_ref_put(key);
    return -EINVAL;
}

Calling refcount_inc_not_zero() on a mismatched type could corrupt memory
by incrementing whatever happens to be at that offset. Furthermore, reading
the data length from this corrupted structure could leak arbitrary kernel
memory into the network via the response packet.
