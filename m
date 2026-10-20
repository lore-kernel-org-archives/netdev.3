Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527675;
	b=AtFhCM506mkBPm+5ShnIBI28DhOukScW/zCRFmGecVnVcFHWmj9vUjJwQ0OGr+1IhlX7
	 r8N/Vn/eMI33AtL3V2jfCS6wEugv5j2o1FOOouzJxJ2lPFc7BUO4oBn4hy5MAtOVDIoOo
	 qRDlpGLkeAMZyUKkoknh5pGdXT00G6Kw3kUm/falrw/ESqPSJhpW23XP41I13zfqKWhKw
	 XmKm1lrWudXzk32yiyAnLQE3MLhm6QWB33DOQeWir03GhzKOy8dP+npfwsMBTIO5bNlsD
	 vATpAg7+LUMQtRNHnK+unOvM0LI9LcE7Omn1nfmB0skEKdlf1qgR62MwJle8z2nnoVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527675;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PIk/27vrC8tFZSqMzqtn6yu+JCHiDh7H3FxEkoyebTU=;
	b=E+4fGIoPMkmC6MRYmC5cI95GrJ4td+G+sKhQNrRw+X6xF/ZRgnG0bdj1XjNK9MQkXZY0
	 GC/vqum/YvLjVAuq1bc0RmYjaR/+tgmOSfRQl38HL9lKSVi2/FHZmL9nb9PhCBDxynW3i
	 Na5bYyf/8kmYH1s34KcY46Oa9pTx5OAU7t5dj3G8lJd12XFRnLTy8l6zqhf9e9m4+13qU
	 259rw7npm4enfIVIP0+0q6I3x2sVtBe2jsnraMKH1ZVQR7tGgiQqjc68PfIm9Ri9PSwV3
	 JTnMg8nYkQRxUgJ0Amwdw4jWEegOs/r2/VQ2yx3v2SaJorDU7JAYyJQD/gk3Y9QL7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DA9bTy85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A519606A321
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DA9bTy85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2651F000CA;
	Tue, 20 Oct 2026 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527674;
	bh=PIk/27vrC8tFZSqMzqtn6yu+JCHiDh7H3FxEkoyebTU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DA9bTy85VE4Uov8Lg16+ABaJLU4vJhOrylsiR282w4y13e3xkq1lMXpgHqV+QWCND
	 Nxk6DXJeAyX7zezhXG7wI2Z+Vyz3GYvJFZox/v2k9yQjuiQt+yrRnREdZPKWipgG5f
	 20muVJ9XGRUQqtamCICzc2hxAI0UDtJkH/6oHfEUVj5JEA32hJbnAnc/MJL/069+CS
	 LltA1cc7xMzfHRQAmEUPxLw3wegrhlfDMa7Asgthuv4izmLM5jelDZxyj829dHYS3v
	 Ze5JiZv96G2unA0Zla6wW5pfpJHWxV25C//CzBOmzAQQbtkaAB90EEFRRmaO5XR2sz
	 JKQ2tc+iCsduQ==
Subject: Re: [PATCH net v10 3/3] rxrpc: bound DATA receive queues
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top,
 kuba@kernel.org
Date: Tue, 20 Oct 2026 20:21:13 +0000
Message-ID: <179252767364.3135.10345050454011895644@kernel.org>
In-Reply-To:
 <d74b9bee555058bd56e884f9ef0dab5fb9ccedcf.1792174935.git.zihanx@nebusec.ai>
References:
 <d74b9bee555058bd56e884f9ef0dab5fb9ccedcf.1792174935.git.zihanx@nebusec.ai>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rxrpc_input_data_one() (net/rxrpc/input.c:556) now charges every
  accepted DATA skb, from every call on a local endpoint, to one…
- [High] Out-of-sequence DATA can deadlock a call.
- [Medium] When a call completes, the DATA skbs on call->rx_oos_queue
  keep their charge against the shared per-local budget until…

--

rxrpc: bound DATA receive queues

This patch charges accepted DATA skbs, including split jumbo subpackets,
to the per-local asynchronous receive budget (local->rx_async_queue_bytes).
The charge is released when recvmsg consumes the packets or when they are
purged. The per-call receive window limit is now based on rx_consumed
instead of ackr_window.

Link: https://lore.kernel.org/all/cover.1791994057.git.zihanx@nebusec.ai/

> diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> index 21be9c86d7a74..9360852604645 100644
> --- a/net/rxrpc/call_event.c
> +++ b/net/rxrpc/call_event.c
> @@ -473,6 +473,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
>  out:
>  	if (__rxrpc_call_is_complete(call)) {
>  		timer_delete_sync(&call->timer);
> +		rxrpc_purge_queue(&call->rx_queue);

[Severity: Medium]

Should this purge rx_oos_queue instead of rx_queue?

Nothing on call->rx_queue is charged, and rxrpc_purge_queue() only
uncharges RXRPC_SKB_MARK_SERVICE_CONN_SECURED skbs.

The DATA skbs on call->rx_oos_queue were charged in rxrpc_input_data_one().
Once the call is complete they can never be delivered, because
rxrpc_input_data() returns early for completed calls.

Those charges are only released in
rxrpc_destroy_call()->rxrpc_cleanup_rx_buffers():

	rxrpc_purge_data_queue(call, &call->rx_oos_queue);

Suppose a peer fills rx_oos_queue and then aborts the call. Does the charge
stay held against the shared local budget until the application reads the
termination and releases the call, or until a kernel user drops its last
reference?

Only the I/O thread and the destroy path touch rx_oos_queue, so it looks
safe to purge it here with rxrpc_purge_data_queue().

>  		if (!test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
>  			rxrpc_disconnect_call(call);

[ ... ]

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 73cafe6bfa9f5..6f0ba50097390 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -511,17 +531,33 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,

[ ... ]

> +	sp->data.charge = NULL;
> +	if (sp->offset != sizeof(struct rxrpc_wire_header) ||
> +	    (sp->hdr.flags & RXRPC_JUMBO_PACKET)) {
> +		if (!*_charge)
> +			*_charge = rxrpc_alloc_async_queue_charge(skb);
> +		sp->data.charge = *_charge;
> +	}
> +	if (!rxrpc_charge_async_queue(call->local, skb)) {
> +		sp->data.charge = NULL;
> +		if (set_last)
> +			clear_bit(RXRPC_CALL_RX_LAST, &call->flags);
> +		ack_reason = RXRPC_ACK_NOSPACE;
>  		goto send_ack;
>  	}

[Severity: High]

Can one call use up the receive budget for the whole local endpoint here?

Every accepted DATA skb from every call on the rxrpc_local is now charged
to local->rx_async_queue_bytes. rxrpc_charge_async_queue_bytes() caps that
counter at the UDP socket's sk_rcvbuf:

net/rxrpc/skbuff.c:rxrpc_charge_async_queue_bytes() {
    ...
		if (queued &&
		    (queued >= rcvbuf || size >= rcvbuf - queued)) {
			sk_drops_inc(sk);
			return false;
		}
    ...
}

rxrpc_adjust_rcvbuf() sizes sk_rcvbuf for about one call's window and
clamps it to sysctl_rmem_max (212992 by default). That is room for about
90-100 normal DATA skbs across the whole endpoint.

Meanwhile rxrpc_fill_out_ack() still advertises up to rx_winsize (255)
packets to each peer:

net/rxrpc/output.c:rxrpc_fill_out_ack() {
    ...
	qsize = (window - 1) - call->rx_consumed;
	rsize = max_t(int, call->rx_winsize - qsize, 0);
    ...
}

The charge is released only when the application reads the data, in
rxrpc_rotate_rx_window(), or when the call is destroyed.

A remote peer could open a call to a listening service, for example kafs on
AFS_CM_PORT using its shared socket. It sends seq 1, then seq 3..N, and
never seq 2. Each of those packets is charged and queued on rx_oos_queue,
all within wlimit.

No authentication seems to be needed, since DATA is queued even while the
connection is still challenging. Each packet also refreshes expect_req_by,
so the call stays alive. A slow reader on a single call could have the same
effect.

Once the budget is full, would every other call on the endpoint get
RXRPC_ACK_NOSPACE drops?

The same counter also gates CHALLENGE/RESPONSE posting in
rxrpc_post_packet_to_conn() and OOB CHALLENGE delivery. Would connection
security setup for unrelated connections fail as well?

Before this patch DATA wasn't charged, so other calls couldn't be starved
this way. Does this need a per-call or per-peer split of the budget, or a
reserved portion? The commit message also doesn't mention that calls now
share this limit.

[Severity: High]

Can ordinary packet loss livelock a call through this check?

The charge is applied before the seq == window test. The packet that would
fill the hole therefore goes through the same budget check as
out-of-sequence packets, with no exemption or reserved space.

With the defaults, rxrpc_rx_window_size is 255 and the budget is clamped to
rmem_max, roughly 90-100 skbs at a typical truesize. A Linux sender can
have up to RXRPC_TX_MAX_WINDOW (128) packets in flight.

Suppose the packet at seq == window is lost early in a large flight. The
packets after it are charged and queued on rx_oos_queue until the budget is
nearly full.

Every retransmission of the missing packet would then fail here and be
dropped with RXRPC_ACK_NOSPACE. The OOS packets move to recvmsg_queue only
after the hole is filled:

	while ((oos = skb_peek(&call->rx_oos_queue))) {

rxrpc_recvmsg_data() only reads recvmsg_queue, so the application can't
release anything either.

Does anything break this cycle other than call destruction? The
retransmissions keep refreshing the call timers. The call could then stall
indefinitely while holding the shared budget, which also starves the other
calls on the same rxrpc_local.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792168462.git.zihanx%40nebusec.ai
