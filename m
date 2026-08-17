Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A653E49D3
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004709; cv=none; b=YqOUz1OeuI71g4iG3OBgDvK4/DiCaCH0xuG/Z8xOJJ3PW4RxNH5t3RCoQ3Hv5bZ4HgewY/DATI0a3YAgTcM/BoU40NXqP6tGVZrNEx09u/CA5uPr2PmFzMrY9iecFcLpOgYu3PAEBqxLQlF0IJk5K194Ar2RBy3bupXPVOdAggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004709; c=relaxed/simple;
	bh=l4cbqfhMRpbQx0j9Zj302rpSj0NFgfnkvyhXRayjYbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOKt6o4/iCD2La9a6M4z9QnDGETXilTsE9IXlAptXFF39qaFXRrwduu3t6QXQr8ffZaAt97chnmXjDrv5Hgz1TV3m9Mc6D11KXlOniO4T4BMlvAyNJR0kT/7Zl3fDcTg3Hlc5r4Z7JfkuOS3C5CUnEzdQaLaq3dZVjNlH54Of3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7u673U/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7u673U/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5AF1F00A3D;
	Mon, 17 Aug 2026 22:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787004708;
	bh=HDDP7QJSLLuiEst7tBNTNTwBMzuYzFK4pBhEg/7qU+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7u673U/y+j4OC96Xbjyy8VFv8Nv/cTdcWwi0RXWXA1yvm7F/nDdBbv14/7BZ8RkK
	 oBFu66i2hiY3P4LrKTbib6gTvveSiT3f1/NjclkSOesJsrtZaA2s4St47cwYNnV5u9
	 2YH2Vlp4LFbaaJ3cApzvkKE/eRCFslR5MxQpdrZVARz7k/LzIfirRaES6kJd/4Nct0
	 jlYdViVWwV1Ji56DC2FM1OP8PkWc5oN287ylDvOONUCdKs6OTHuM6FvfiRsmagleUw
	 I4NaKQWRCAuVYyIu477HXnSwrhArE3rgdb9ib+1oXWcU4+us7BbsWI5d+bSaiSCuWk
	 f0UEQindaT1Xw==
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
Subject: Re: [PATCH v16 09/10] tls: device: add tracepoints for the KeyUpdate path
Date: Mon, 17 Aug 2026 15:11:46 -0700
Message-ID: <20260817221146.3666526-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807183853.2288959-10-rjethwani@purestorage.com>
References: <20260807183853.2288959-10-rjethwani@purestorage.com>
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
tls: device: add tracepoints for the KeyUpdate path

This adds four trace events to net/tls/trace.h and wires them into the
RX and TX rekey paths in net/tls/tls_device.c. The events are intended to
let an operator follow the KeyUpdate state machine: rekey start, the
old-key reencrypt pass, boundary crossing, and TX rekey completion
failure in sendmsg.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index c34268cd9531..9a4c121dbebb 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -760,8 +760,14 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	lock_sock(sk);
>  
>  	/* Old-key records all ACKed; switch back to HW. */
> -	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> -		tls_device_complete_rekey(sk, tls_ctx, true);
> +	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags)) {
> +		rc = tls_device_complete_rekey(sk, tls_ctx, true);
> +		/* On failure the READY bit is left set; the next sendmsg
> +		 * retries.
> +		 */
> +		if (rc)
> +			trace_tls_device_complete_rekey_fail(sk, rc);
> +	}

[Severity: Low]
Can this event ever fire for an actual HW rekey failure?

tls_device_complete_rekey() has only one non-zero return, the drain at
the top:

net/tls/tls_device.c:tls_device_complete_rekey() {
	...
	rc = tls_sw_drain_tx(sk, ctx);
	if (rc)
		return rc;
	...
}

Every other failure (netdev gone, crypto_alloc_aead(),
crypto_aead_setkey(), crypto_aead_setauthsize(), tls_device_dev_add_tx())
goes to release_lock and then rekey_fail, which returns success:

net/tls/tls_device.c:tls_device_complete_rekey() {
rekey_fail:
	...
	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
	...
	return 0;
}

So the case that permanently drops the connection to SW encryption emits
nothing, while the case that does emit the event named _fail is
tls_sw_drain_tx() returning -EAGAIN:

net/tls/tls_sw.c:tls_sw_drain_tx() {
	if (rc < 0 || tls_is_partially_sent_record(ctx) ||
	    tls_is_pending_open_record(ctx))
		return rc < 0 ? rc : -EAGAIN;
}

which is a transient retry rather than a failure. Should the tracepoint
be emitted from the rekey_fail path instead, or in addition?

> @@ -1267,6 +1273,9 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  				return 0;
>  			}
>  
> +			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
> +							 ctx->rekey.old_nic_boundary);
> +
>  			/* rekey_fixup sets decrypted flags in case the NIC clears
>  			 * decrypted flags on auth failure
>  			 */
> @@ -1277,6 +1286,8 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  							    sw_ctx, tls_ctx);
>  		}
>  
> +		trace_tls_device_rekey_done(sk, rec_start_seq,
> +					    ctx->rekey.old_nic_boundary);
>  		crypto_free_aead(ctx->rekey.old_aead_recv);
>  		ctx->rekey.old_aead_recv = NULL;
>  
> @@ -1923,6 +1934,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
>  					netdev->tlsdev_ops->tls_dev_rx_rekey_fixup;
>  				context->dev_add_pending = 1;
>  			}
> +			trace_tls_device_rekey_start(sk, copied_seq, rcv_nxt,
> +						     before(copied_seq, rcv_nxt));
>  		}
>  	}

[Severity: Low]
Is this the only arm that should be traced?

The call sits inside the else arm of the RX rekey branch. The other arm
in tls_set_device_offload_rx() also accepts a rekey and defers dev_add,
and emits nothing:

net/tls/tls_device.c:tls_set_device_offload_rx() {
		if (context->rekey.old_aead_recv &&
		    before(copied_seq, context->rekey.old_nic_boundary)) {
			/* Previous rekey still draining. ... */
			context->dev_add_pending = 1;
		} else {
			...
			trace_tls_device_rekey_start(...);
		}
}

That first arm is the "old-key data is still queued, dev_add deferred"
state the commit message attributes to inflight=1. Since
tls_device_decrypted() emits trace_tls_device_rekey_done() for any
non-NULL ctx->rekey.old_aead_recv, wouldn't a second KeyUpdate arriving
while the previous one is still draining produce a rekey_done with no
preceding rekey_start?

Also, inside the traced arm the event fires even when
before(copied_seq, rcv_nxt) is false, in which case no old-key state is
created and rcv_nxt is never stored into ctx->rekey.old_nic_boundary.
Does the reported nic_boundary describe anything in that case?

[Severity: Low]
Are the start and done events meant to pair up?

trace_tls_device_rekey_start() is emitted here, before the rekey can
still be aborted. If the following tls_sw_ctx_init() fails, the
release_ctx path undoes the state that was just traced:

net/tls/tls_device.c:tls_set_device_offload_rx() {
release_ctx:
	...
		context->dev_add_pending = was_dev_add_pending;
		if (moved_aead_recv) {
			...
			sw_ctx->aead_recv = context->rekey.old_aead_recv;
			context->rekey.old_aead_recv = NULL;
		}
}

so a rekey_start is recorded for a rekey that did not take effect, with
no cancelling event.

In the other direction, rekey_done is emitted only at the free site in
tls_device_decrypted(). old_aead_recv is also freed because the boundary
was already crossed here:

net/tls/tls_set_device_offload_rx() {
			if (context->rekey.old_aead_recv) {
				crypto_free_aead(context->rekey.old_aead_recv);
				context->rekey.old_aead_recv = NULL;
			}
}

and on the RX teardown and context-free paths, none of which emit
rekey_done. Should those sites emit the event too, or should the commit
message avoid describing the events as a start/done pair?

> diff --git a/net/tls/trace.h b/net/tls/trace.h
> index 2d8ce4ff3265..2a90b77d75e8 100644
> --- a/net/tls/trace.h
> +++ b/net/tls/trace.h
> @@ -192,6 +192,104 @@ TRACE_EVENT(tls_device_tx_resync_send,
>  	)
>  );
>  
> +TRACE_EVENT(tls_device_rekey_start,
> +
> +	TP_PROTO(struct sock *sk, u32 copied_seq, u32 nic_boundary,
> +		 bool inflight),
> +
> +	TP_ARGS(sk, copied_seq, nic_boundary, inflight),
> +
> +	TP_STRUCT__entry(
> +		__field(	struct sock *,	sk		)
> +		__field(	u32,		copied_seq	)
> +		__field(	u32,		nic_boundary	)
> +		__field(	bool,		inflight	)
> +	),

[ ... ]
