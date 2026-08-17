Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC013D955F
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004705; cv=none; b=g5R8tBa4zpARFbDDNC+LkGavbzTnsGrcI09VcUlyBPVoF7pFiXpowXm/4KZnBWsWEr2p9i+J+vwRgAsHcu1ZmJmp9ONgtAT7jk2RsUM4fB40BXQ4Q5l/U6ds0U7cGbDMYUWlWh26bVT4FHBWYtkMudhTbQueyRC1LaGJaKxYqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004705; c=relaxed/simple;
	bh=vz2VMmFaVUamc0N3/ow2OX5eqEm7Jrf76TeTGkkQSDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8bKrTOeo53/9VfDmNI3bSh/qshICvuxmW21Bd+JNekF57Afc7Zmr17oLehOQHNjOSv+03ZPCYR4uSJL2jKA+z02qQCA8oE1vBV+Y+ZMpBVvJ4/CrcrEfbv6Jgv/wqlYVluY125UITJGIJXQz1Y8kdbIRTL4Dp6dixb4AO0SB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJRPeor6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJRPeor6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719051F000E9;
	Mon, 17 Aug 2026 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004704;
	bh=lCzOKx6ZnAH4zE1EDqPo5QDlU5cCIRQ5PzZgQwPdSuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJRPeor6JbUFymJuttX41iZeIRPna0jJ0WTLt5nnOqr5vA3FWbSptCsGhy/VfX0XD
	 iU78Gj9ZFJZVPQY+4DJU3McBxZ/4m9h0noF+eo2mrk2pH7CLm0Ff2+NFYefTsdZm0t
	 Wqi/IlDo4exRhLReYtGE0oNvgKcKCiX3S5ZT6paBnK8t2B4QHDnfb2f7U5dKcJi07a
	 hFjQvJ84zByvKeDkYdqtMnAOkGjnn2bWgWSIBqtY5p5JvzT9jg/gAHbGP5P9cjdj+e
	 ki97eW0dv2wb5HOJAKmoTIC3w8gzlypykiOIljNfQeBfSew2FrFv1fxTTvaMBg1CV3
	 slwOR+jyAFhZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rjethwani@purestorage.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v16 06/10] tls: prep helpers and refactors for HW offload KeyUpdate
Date: Mon, 17 Aug 2026 15:11:42 -0700
Message-ID: <20260817221142.3666425-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-7-rjethwani@purestorage.com>
References: <20260807183853.2288959-7-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
tls: prep helpers and refactors for HW offload KeyUpdate

This patch hoists cipher_context / tls_crypto_context above
tls_offload_context_tx, adds a tls_tx_cipher_ctx() accessor plus a
tls_sw_ctx_tx_init() helper, splits tls_set_device_offload() and factors out
tls_device_dev_add_tx() / tls_device_commit_start_marker(), and moves
crypto_aead_setauthsize() into the !*aead block.  It is described as no
functional change.

No Link: tags present in the commit header.

> diff --git a/include/net/tls.h b/include/net/tls.h
> index e57bef58851e..eb258bcd62bc 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h

[ ... ]

> @@ -392,6 +392,12 @@ static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
>  	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
>  }
>  
> +static inline struct cipher_context *tls_tx_cipher_ctx(
> +		const struct tls_context *tls_ctx)
> +{
> +	return (struct cipher_context *)&tls_ctx->tx;
> +}
> +

[Severity: Low]

The commit message says this accessor exists "so the TX path can redirect to
a temporary SW context during rekey", but only some TX-side users are
converted here.  Is the remaining set intentional?

tls_fill_prepend() in net/tls/tls.h still reads the explicit nonce straight
from ctx->tx:

	if (prot->version != TLS_1_3_VERSION &&
	    prot->cipher_type != TLS_CIPHER_CHACHA20_POLY1305) {
		pkt_len += iv_size;

		memcpy(buf + TLS_NONCE_OFFSET,
		       ctx->tx.iv + prot->salt_size, iv_size);
	}

and on the HW TX side tls_device.c's tls_push_record() advances
&ctx->tx while tls_device_resync_tx() reads tls_ctx->tx.rec_seq directly.
tls_sw_ctx_finalize() and do_tls_getsockopt_conf() also still use &ctx->tx.

Walking the paths, none of these look reachable while the accessor points
somewhere else: do_tls_setsockopt_conf() rejects a second crypto info for
anything but TLS 1.3 with -EBUSY, so the TLS 1.2 nonce branch above cannot
run during a rekey, and the device record/resync paths are entered from
tls_push_data(), which the later series patch diverts to the SW helpers while
the rekey-pending flag is set.  So there does not appear to be a live
mismatch today.

Would it be worth a short comment on tls_fill_prepend()'s ctx->tx.iv use
noting that it is safe because rekey is TLS 1.3 only, so a future reader
does not have to redo this reasoning?

> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 5a6ee1ea00f8..e8b552c2f4fb 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -157,7 +157,10 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
>  void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
>  void tls_sw_strparser_done(struct tls_context *tls_ctx);
>  int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
> +void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
> +int tls_sw_push_pending_record(struct sock *sk, int flags);
>  void tls_sw_splice_eof(struct socket *sock);
> +void tls_sw_splice_eof_locked(struct socket *sock);

[Severity: Low]

The changelog lists five refactors, but two of the changes here are not among
them.  Could the commit message be extended to cover them?

tls_sw_push_pending_record() loses static and becomes a global symbol, and
tls_sw_splice_eof() is split into a new externally visible
tls_sw_splice_eof_locked() plus a locking wrapper.  Neither appears in the
bullet list.

tls_sw_splice_eof_locked() also gains an entry contract that is not written
down anywhere: the caller must already hold tls_ctx->tx_lock and the socket
lock, and is expected to have checked ctx->open_rec.  Would a comment above
it, or a lockdep assertion, be worth adding?

>  void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
>  void tls_sw_release_resources_tx(struct sock *sk);
>  void tls_sw_free_ctx_tx(struct tls_context *tls_ctx);

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 63c83247f9a3..7b6ab992c86e 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -555,11 +555,11 @@ static int tls_do_encryption(struct sock *sk,
>  		break;
>  	}
>  
> -	memcpy(&rec->iv_data[iv_offset], tls_ctx->tx.iv,
> +	memcpy(&rec->iv_data[iv_offset], tls_tx_cipher_ctx(tls_ctx)->iv,
>  	       prot->iv_size + prot->salt_size);
>  
>  	tls_xor_iv_with_seq(prot, rec->iv_data + iv_offset,
> -			    tls_ctx->tx.rec_seq);
> +			    tls_tx_cipher_ctx(tls_ctx)->rec_seq);
>  
>  	sge->offset += prot->prepend_size;
>  	sge->length -= prot->prepend_size;

[ ... ]

> @@ -676,7 +676,7 @@ static int tls_push_record(struct sock *sk, int flags,
>  	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
>  
>  	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
> -		     tls_ctx->tx.rec_seq, record_type, prot);
> +		     tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, prot);
>  
>  	tls_fill_prepend(tls_ctx,
>  			 page_address(sg_page(&msg_en->sg.data[i])) +

[ ... ]

> @@ -712,7 +712,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
>  	return err;
>  }
>  
> -static int tls_sw_push_pending_record(struct sock *sk, int flags)
> +int tls_sw_push_pending_record(struct sock *sk, int flags)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);

[ ... ]

> @@ -1028,7 +1028,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  /*
>   * Handle unexpected EOF during splice without SPLICE_F_MORE set.
>   */
> -void tls_sw_splice_eof(struct socket *sock)
> +void tls_sw_splice_eof_locked(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
> @@ -1039,21 +1039,15 @@ void tls_sw_splice_eof(struct socket *sock)
>  	bool retrying = false;
>  	int ret = 0;
>  
> -	if (!ctx->open_rec)
> -		return;
> -
> -	mutex_lock(&tls_ctx->tx_lock);
> -	lock_sock(sk);
> -
>  retry:
>  	/* same checks as in tls_sw_push_pending_record() */
>  	rec = ctx->open_rec;

[ ... ]

>  	/* Transmit if any encryptions have completed */
>  	if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
>  		cancel_delayed_work(&ctx->tx_work.work);
>  		tls_tx_records(sk, 0);
>  	}
> +}
> +
> +void tls_sw_splice_eof(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
>  
> -unlock:
> +	if (!ctx->open_rec)
> +		return;
> +
> +	mutex_lock(&tls_ctx->tx_lock);
> +	lock_sock(sk);
> +	tls_sw_splice_eof_locked(sock);
>  	release_sock(sk);
>  	mutex_unlock(&tls_ctx->tx_lock);
>  }

Both observations are documentation level; the code changes themselves look
equivalent to the previous behaviour.
