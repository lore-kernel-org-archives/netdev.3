Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316937FF48
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042174; cv=none; b=sMMJOzw8FhhdzFPO1aD1K+f//H78wm3DmsgR1fbJ3vUs1AXb84NZQq6ZGGxwe67Rp+mQOKGpq+qSgsGon3f3aaznOgLROo6o5NBBCJ+1ROKNmXYhv3bsR/p22PwRge/X6sUWgPWCpllP5XJdpqvNh2rKl9aaexv1mgZR9J/BgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042174; c=relaxed/simple;
	bh=DtAzR7sm2aKpXwgitSGLV415CV7fjZ3U4rFjURthl0A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9QfvEWjpfvOwuQV9iUkILnVRzVLVLZBYayHSieMsLS9wGcOFqLrDX7263ZdUlrkLpknWRvQcFIwH8Rr1eG18geGw6j4IlGdOMJogmtOAB59tSG9cTs4uNT9M+PI7fQc+cCnAyBhZLcRzfyhw69szzxVlDet/SWNrmbg5LTXjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krBUPNgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krBUPNgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CFE1F000FF;
	Tue, 22 Sep 2026 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042172;
	bh=/iWJ+3OOWGKkgnYEMkefJJ7skiQ0a4Jp1imCJlQoJKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=krBUPNgyv2XEA0VaKWhvgYB/bErGLa2r131oA/ygbONlpSAp5xd260vyQppk20RcT
	 wd2TsdxS+qeSjVq5KwQL/sLpaAwru06bxXvnYzQv37bmQjt4Z4N05fabrfxl37R3fo
	 RTiDYRQwUzLn4NzsHEFvauLVPXFAhhl/iHnSzKfnmto0OG063CfBVsKGxM7eYTlrIn
	 ZNSdQdizx6er+jg6Fzy3DVJ5o+bJDY2aaLTV182ymCVF33JU1RDd4itAUMNSESNeen
	 iY5PcmFHr1yCjkgaXv1TiisBcXcvxQAb4nGXT/AKEm34ENTFQV4KMb4wSqIZ7+kXmX
	 MsO/BR7XMHFSQ==
Subject: Re: [PATCH net-next v17 13/15] tls: device: add tracepoints for the
 KeyUpdate path
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org, andrew.gospodarek@broadcom.com
Date: Tue, 22 Sep 2026 01:56:11 +0000
Message-ID: <179004217163.2160803.15523440099876531858@kernel.org>
In-Reply-To: <20260917224355.2288021-14-rjethwani@purestorage.com>
References: <20260917224355.2288021-14-rjethwani@purestorage.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New tracepoint `tls_device_rekey_start`
  (net/tls/trace.h:195-221) declares and prints its sequence field as…
- [Low] The new comment added at the tls_device_sendmsg() call site
  (net/tls/tls_device.c:869-877) states "Non-zero here is the transient…

--

tls: device: add tracepoints for the KeyUpdate path

This adds five trace events to net/tls/trace.h covering the device
KeyUpdate/rekey state machine: rekey_start, rekey_reencrypt and
rekey_done on the RX side, plus complete_rekey_retry and
complete_rekey_fail on the TX side. The RX events are emitted from
tls_set_device_offload_rx() and tls_device_decrypted(), the TX ones from
tls_device_sendmsg() and the fallback path of
tls_device_complete_rekey().

No Link: tags were present in the commit header.

> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index ac09f356cff9..5f45c097bad3 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -866,8 +866,16 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	lock_sock(sk);
>  
>  	/* Old-key records all ACKed; switch back to HW. */
> -	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> -		tls_device_complete_rekey(sk, tls_ctx, true, msg->msg_flags);
> +	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags)) {
> +		rc = tls_device_complete_rekey(sk, tls_ctx, true, msg->msg_flags);
> +		/* Non-zero here is the transient -EAGAIN retry,
> +		 * the next sendmsg retries. Hard failures return 0 after
> +		 * falling back to SW and emit tls_device_complete_rekey_fail
> +		 * from the fallback path.
> +		 */
> +		if (rc)
> +			trace_tls_device_complete_rekey_retry(sk);
> +	}

[Severity: Low]
Is "Non-zero here is the transient -EAGAIN retry" the full set of
transient returns here?

tls_device_complete_rekey() passes three errors back to this caller:

net/tls/tls_device.c:tls_device_complete_rekey() {
	...
	/* -EAGAIN (sndbuf full) and a signal (-EINTR/-ERESTARTSYS from
	 * sk_stream_wait_memory()) are transient: leave the rekey PENDING and
	 * retry on the next sendmsg rather than permanently dropping HW offload.
	 */
	if (rc == -EAGAIN || rc == -EINTR || rc == -ERESTARTSYS)
		return rc;
	...
}

So a signal delivered to a sender blocked in sk_stream_wait_memory()
during a KeyUpdate also emits trace_tls_device_complete_rekey_retry(),
not only sndbuf pressure. Should the comment here (and the matching
"TX rekey completion hit the transient -EAGAIN retry in sendmsg" text in
the changelog) name -EINTR/-ERESTARTSYS too?

Related: the retry event carries only sk, while its sibling
tls_device_complete_rekey_fail(sk, rc) carries rc. Without rc on the
retry event, can a trace distinguish repeated sndbuf exhaustion from
repeated signal delivery when a TX rekey stays PENDING? Would adding rc
to tls_device_complete_rekey_retry make that visible?

>  
>  	if (tls_device_tx_uses_sw(tls_ctx)) {
>  		rc = tls_sw_sendmsg_locked(sk, msg, size);
> @@ -1430,10 +1438,15 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
>  				return 0;
>  			}
>  
> +			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
> +							 ctx->rekey.old_nic_boundary);
> +
>  			return tls_device_reencrypt_old_key(sk, ctx,
>  							    sw_ctx, tls_ctx);
>  		}
>  
> +		trace_tls_device_rekey_done(sk, rec_start_seq,
> +					    ctx->rekey.old_nic_boundary);
>  		crypto_free_aead(ctx->rekey.old_aead_recv);
>  		ctx->rekey.old_aead_recv = NULL;
>  

[ ... ]

> @@ -1890,6 +1903,13 @@ static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
>  	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
>  	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
>  
> +	/* Hard failure: HW rekey gave up and the connection is now pinned to
> +	 * SW encryption. The call site only sees the transient -EAGAIN retry
> +	 * (rc is not propagated here), so emit the trace from the fallback
> +	 * path itself; rc still holds the originating error.
> +	 */
> +	trace_tls_device_complete_rekey_fail(sk, rc);
> +
>  	return 0;
>  }
>  
> @@ -2195,11 +2215,21 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
>  			 * is installed once drain_start crosses rekey.old_nic_boundary.
>  			 */
>  			context->dev_add_pending = 1;
> +			trace_tls_device_rekey_start(sk, drain_start,
> +						     context->rekey.old_nic_boundary,
> +						     true);
>  		} else {
>  			struct tcp_sock *tp = tcp_sk(sk);
>  			u32 nic_end;
>  
>  			if (context->rekey.old_aead_recv) {
> +				/* Prior rekey's era already drained (drain_start is
> +				 * past old_nic_boundary), so retiring its key here
> +				 * is a boundary crossing, same as the free in
> +				 * tls_device_decrypted(); mark it done.
> +				 */
> +				trace_tls_device_rekey_done(sk, drain_start,
> +							    context->rekey.old_nic_boundary);
>  				crypto_free_aead(context->rekey.old_aead_recv);
>  				context->rekey.old_aead_recv = NULL;
>  			}

[ ... ]

> @@ -2247,6 +2277,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
>  				context->dev_add_pending = 0;
>  				retired_pending = true;
>  			}
> +			trace_tls_device_rekey_start(sk, drain_start, nic_end,
> +						     before(drain_start, nic_end));
>  		}
>  	}
>  
> diff --git a/net/tls/trace.h b/net/tls/trace.h
> index 2d8ce4ff3265..5b9c1f86d82d 100644
> --- a/net/tls/trace.h
> +++ b/net/tls/trace.h
> @@ -192,6 +192,124 @@ TRACE_EVENT(tls_device_tx_resync_send,
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
> +
> +	TP_fast_assign(
> +		__entry->sk = sk;
> +		__entry->copied_seq = copied_seq;
> +		__entry->nic_boundary = nic_boundary;
> +		__entry->inflight = inflight;
> +	),
> +
> +	TP_printk(
> +		"sk=%p copied_seq=%u nic_boundary=%u inflight=%d",
> +		__entry->sk, __entry->copied_seq, __entry->nic_boundary,
> +		__entry->inflight
> +	)
> +);

[Severity: Medium]
Is copied_seq the right name for this field? Both producers in
tls_set_device_offload_rx() pass drain_start, which comes from
tls_device_rx_rec_start():

net/tls/tls_device.c:tls_device_rx_rec_start() {
	u32 copied_seq = tcp_sk(sk)->copied_seq;

	if (sw_ctx->strp.copy_mode)
		return copied_seq - sw_ctx->strp.anchor->len;

	return copied_seq;
}

In strparser copy mode that is the record start, not tp->copied_seq,
which is also what the comment above drain_start says:

	/* Classify against the record start, not the raw copied_seq: ...

The same quantity is exported as tcp_seq by the pre-existing
tls_device_decrypted event and by the two RX events added here
(tls_device_rekey_reencrypt/tls_device_rekey_done, both fed
rec_start_seq). Since one header would then label one value two
different ways, would naming this field tcp_seq keep the interface
self-consistent for anyone correlating rekey_start with
tls_device_decrypted?

Separately, would the rx_/tx_ direction qualifier used by the existing
events in this header (tls_device_rx_resync_send,
tls_device_tx_resync_req, tls_device_tx_resync_send) be worth applying
here? rekey_start, rekey_done and rekey_reencrypt are only emitted from
the RX path (tls_set_device_offload_rx() and tls_device_decrypted()),
while complete_rekey_retry/_fail are only emitted from the TX path, so
enabling tls_device_rekey_start while chasing a TX KeyUpdate yields no
events.

> +
> +TRACE_EVENT(tls_device_rekey_reencrypt,
> +
> +	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
> +
> +	TP_ARGS(sk, tcp_seq, nic_boundary),

[ ... ]

> +TRACE_EVENT(tls_device_complete_rekey_fail,
> +
> +	TP_PROTO(struct sock *sk, int rc),
> +
> +	TP_ARGS(sk, rc),

[ ... ]

> +TRACE_EVENT(tls_device_complete_rekey_retry,
> +
> +	TP_PROTO(struct sock *sk),
> +
> +	TP_ARGS(sk),
> +
> +	TP_STRUCT__entry(
> +		__field(	struct sock *,	sk	)
> +	),

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917224355.2288021-1-rjethwani%40purestorage.com
