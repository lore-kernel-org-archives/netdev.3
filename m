Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D53D88FA
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344507; cv=none; b=tBkq/friCauNyCGk31UzdcmdFcjs7J8hyyp11e4XmQQo3lIRkHAZZww+mQPN/xnIIfG+txnG7GxdDOgJjhpNbUO4GWpJDp91e8KDAf1pjoEqhe98Aleh41Bin2COiAMmpiWjxPnk7K24mZn99L7NdvFCojZXNdzxzQ1NO5NAFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344507; c=relaxed/simple;
	bh=+bg8PiPlQ5jlDaWyUS6huXkZOO9fRIDednHzaLFdmhc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ag3E8t/s7QDUjiXKyuauWlVxjcJEyAuTf/ZIheTIhO7+fMCTX59TJckfT/kHwkwxFpoeIJ4GfL0KB+SS5IIe0JGKSJQJn+J5z3uxNFKrOsr9YfqihwKnqrj6Yxjg4OHyBsPNQo6nNEk1/JVp4LM4vGgjlQUahItTh9O4SrrhFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+HOe+Py; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+HOe+Py"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217271F000C5;
	Sun, 18 Oct 2026 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344505;
	bh=LAx4IS5FvXsfDlN64QVlhPzRk3O1v1Am6c3hoUonSOQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N+HOe+PywDBwB3f1ghKro0HBL9iX0HYlAYnPiyxDjlpX7GfTAwAovZcNTv9H3WIMH
	 HPGjKe0/4iqz2TWcF6asXiFyJ1DTGY2c3REo08jmyBn0GVuWuSAZRuxH784C7iqICz
	 FMdSXSv438VhMxy36jdHFnvDQXMXiKO+U68TfCeshOxgYES6hfOZE60wyjoXMxyCpa
	 y816zOHLg73R4MLjAfYKZj76ooVsMMSAy1Ucpz2kGSAfHOk7D5Ec1Z7WOEOcn1puwf
	 866VqwUKyzaaFECiSmdUeQ0CGaMOjd2x2XAkmIpWc7PV/IdVJwQqj64yx4wd/I3PIo
	 SEiwfZM7qHJRw==
Subject: Re: [PATCH net v9 3/3] rxrpc: bound DATA receive queues
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@kernel.org, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top,
 kuba@kernel.org
Date: Sun, 18 Oct 2026 17:28:24 +0000
Message-ID: <179234450466.3135.14125243945410659468@kernel.org>
In-Reply-To:
 <4528cb16accabf1dfddb1762c8f7f5977a9383f8.1791994058.git.zihanx@nebusec.ai>
References:
 <4528cb16accabf1dfddb1762c8f7f5977a9383f8.1791994058.git.zihanx@nebusec.ai>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The single per-local budget can be held indefinitely, which
  stalls the call that holds it and starves every other user of the…
- [High] Unauthenticated DATA can starve the connection security
  handshake on the whole local endpoint.
- [Medium] Out-of-sequence DATA on a completed call keeps its share of
  the per-local budget until final call destruction.
- [Medium] The patch makes every call on a local endpoint share one DATA
  budget: local->rx_async_queue_bytes against the UDP socket's sk_rcvbuf.
- [Low] The commit message leaves out two behavioural changes.

--

rxrpc: bound DATA receive queues

This patch charges accepted DATA packets to the per-local asynchronous
receive budget (local->rx_async_queue_bytes). It also bases the per-call
receive window limit on rx_consumed instead of ackr_window. Split jumbo
subpackets share a refcounted charge object, and the charge is released
when packets are rotated out by recvmsg or purged.

Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/

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

rxrpc_queue_rx_call_packet() adds skbs to call->rx_queue without charging
them through rxrpc_charge_async_queue(). Does this purge release any of the
new per-local budget?

The queue that does hold charged DATA, and that can't be delivered once the
call is complete, is call->rx_oos_queue. Its only purge seems to be in
rxrpc_cleanup_rx_buffers(), which rxrpc_destroy_call() reaches after the
last call ref is dropped:

    rxrpc_purge_data_queue(call, &call->rx_oos_queue);

The recvmsg call_failed path only purges recvmsg_queue, and
rxrpc_release_call() doesn't touch the rx queues.

Could an aborted or timed-out call then keep up to rx_winsize charged
out-of-sequence skbs in local->rx_async_queue_bytes? They would stay there
until a userspace reader collects the terminal state, or until a kernel
service releases the call.

Should rx_oos_queue be purged here with rxrpc_purge_data_queue() instead?

> diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
> index 73cafe6bfa9f5..6f0ba50097390 100644
> --- a/net/rxrpc/input.c
> +++ b/net/rxrpc/input.c

[ ... ]

> @@ -487,9 +489,13 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
>  	unsigned int sack = call->ackr_sack_base;
>  	rxrpc_seq_t window = call->ackr_window;
>  	rxrpc_seq_t wtop = call->ackr_wtop;
> -	rxrpc_seq_t wlimit = window + call->rx_winsize - 1;
> +	/* Bound queued DATA by the application's receive window. */
> +	rxrpc_seq_t wlimit = smp_load_acquire(&call->rx_consumed) +
> +		call->rx_winsize;
>  	rxrpc_seq_t seq = sp->hdr.seq;

[ ... ]

> @@ -498,10 +504,24 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
>  	if (sp->hdr.flags & RXRPC_JUMBO_PACKET)
>  		rxrpc_inc_stat(call->rxnet, stat_rx_data_jumbo);
>  
> +	if (after(seq, call->rx_highest_seq))
> +		call->rx_highest_seq = seq;
> +
> +	trace_rxrpc_rx_data(call->debug_id, seq, serial, sp->hdr.flags);
> +
> +	if (after(seq, wlimit)) {
> +		ack_reason = RXRPC_ACK_EXCEEDS_WINDOW;
> +		goto send_ack;
> +	}
> +
>  	if (last) {
> -		if (test_and_set_bit(RXRPC_CALL_RX_LAST, &call->flags) &&
> -		    seq + 1 != wtop)
> -			return rxrpc_proto_abort(call, seq, rxrpc_eproto_different_last);
> +		if (test_and_set_bit(RXRPC_CALL_RX_LAST, &call->flags)) {
> +			if (seq + 1 != wtop)
> +				return rxrpc_proto_abort(call, seq,
> +							rxrpc_eproto_different_last);
> +		} else {
> +			set_last = true;
> +		}
>  	} else {

[Severity: Low]

This isn't a bug, but the commit message doesn't mention two behavioural
changes, and this patch is tagged Cc: stable.

The after(seq, wlimit) check now runs before the RXRPC_LAST_PACKET
handling. A LAST packet beyond the window therefore no longer sets
RXRPC_CALL_RX_LAST, so it can't lead to rxrpc_eproto_different_last or
rxrpc_eproto_data_after_last aborts on later packets.

The new ordering looks necessary with the rx_consumed based wlimit, but it
does change how protocol errors are handled.

The commit message also doesn't describe the rxrpc_purge_queue(&call->rx_queue)
added to the completion path of rxrpc_input_call_event(). Before this
patch, those skbs were freed one per poke or in rxrpc_cleanup_rx_buffers().

Could the commit message cover both changes?

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

Once out-of-sequence DATA has used up the budget, can this deadlock the
call and starve the rest of the endpoint?

Every DATA packet that passes the window and duplicate checks is now
charged here. That includes out-of-sequence packets parked on
call->rx_oos_queue and the hole-filling packet with seq == window.

The rx_oos_queue skbs only give back their charge in two cases. One is when
the hole is filled and rxrpc_rotate_rx_window() consumes them. The other is
when the call is destroyed.

No room is reserved for the head-of-window packet. Suppose a peer sends seq
N+1..N+k and holds back seq N, or seq N is simply lost during a large
transfer. Each retransmission of seq N would then fail this check in
rxrpc_charge_async_queue_bytes():

    if (queued &&
        (queued >= rcvbuf || size >= rcvbuf - queued)) {
        sk_drops_inc(sk);
        return false;
    }

and get RXRPC_ACK_NOSPACE. Wouldn't the call be unable to make progress
after that?

rxrpc_post_packet_to_conn() and rxrpc_notify_socket_oob() charge the same
counter. So DATA for every other call on the same rxrpc_local would be
dropped too, along with CHALLENGE and RESPONSE packets.

The call also doesn't seem to time out while the peer keeps sending.
rxrpc_input_call_packet() refreshes expect_rx_by on every received packet,
including NOSPACE-dropped ones:

    call->expect_rx_by = ktime_add(ktime_get_real(), delay);

and rxrpc_input_data() refreshes expect_req_by in
RXRPC_CALL_SERVER_RECV_REQUEST.

For scale, rxrpc_adjust_rcvbuf() sets the budget to:

    rcvbuf = READ_ONCE(rxrpc_rx_window_size) *
        SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
    rcvbuf += rcvbuf / 4;

On x86-64 that is about 1.28MB, or roughly 2.5 full 255-packet windows at
idealised truesize. With wlimit = rx_consumed + rx_winsize, one call can
hold up to 255 skbs. With larger NIC truesizes a single call could exhaust
the budget by itself. Otherwise a few calls with concurrent losses could.

A remote peer can open service calls on a shared endpoint to do this. For
example, the AFS cache manager service shares the socket used for
fileserver calls.

Should the head-of-window packet be exempt or have reserved space? Or
should DATA have a budget separate from connection-level traffic?

[ ... ]

> @@ -681,9 +710,11 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
>  		trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
>  		rxrpc_notify_socket(call);
>  	}
> +	rxrpc_put_async_queue_charge(call->local, charge);
>  	return true;

[Severity: High]

Can unauthenticated DATA starve the connection security handshake for the
whole local endpoint?

rxrpc_incoming_call() sets RXRPC_CALL_CONN_CHALLENGING when a service call
is created on a connection in RXRPC_CONN_SERVICE_UNSECURED or
RXRPC_CONN_SERVICE_CHALLENGING state. rxrpc_input_data_one() still queues
that call's DATA, and now charges it to local->rx_async_queue_bytes.
However, the notification just above is suppressed:

    if (notify && !test_bit(RXRPC_CALL_CONN_CHALLENGING, &call->flags)) {

So a userspace server isn't told about the data and can't consume it, and
rx_consumed doesn't advance.

A peer that never answers the CHALLENGE could open a few calls and fill
each with up to rx_winsize packets, saturating the shared budget. It could
keep those calls alive by resending.

After that, rxrpc_post_packet_to_conn() would silently drop RESPONSE
packets from legitimate peers:

    if (!rxrpc_charge_async_queue(local, skb))
        return false;

rxrpc_input_conn_packet() would still return true, and those handshakes
would never complete. CHALLENGE packets for client connections would be
dropped the same way via rxrpc_notify_socket_oob().

Should DATA on calls whose connection isn't secured yet be bounded
separately? Alternatively, should connection-level packets have reserved
headroom?

> diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
> index a5113a284456e..3b999200b6fc6 100644
> --- a/net/rxrpc/skbuff.c
> +++ b/net/rxrpc/skbuff.c

[ ... ]

> @@ -72,25 +70,105 @@ bool rxrpc_charge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
>  	for (;;) {
>  		queued = atomic_long_read(&local->rx_async_queue_bytes);
>  		if (queued &&
> -		    (queued >= rcvbuf ||
> -		     (long)skb->truesize >= rcvbuf - queued)) {
> +		    (queued >= rcvbuf || size >= rcvbuf - queued)) {
>  			sk_drops_inc(sk);
>  			return false;
>  		}

[Severity: Medium]

Now that DATA is charged here, all calls on a local endpoint share one
budget bounded by the UDP socket's sk_rcvbuf. rxrpc_adjust_rcvbuf() sized
that budget for the transient UDP to I/O thread queue, at about 2.5
idealised 255-packet windows.

Each call still advertises a full receive window, which rxrpc_fill_out_ack()
computes from that call's own state only:

    qsize = (window - 1) - call->rx_consumed;
    rsize = max_t(int, call->rx_winsize - qsize, 0);

Suppose two or three calls with slow readers hold unconsumed in-order DATA
on recvmsg_queue. Won't rxrpc_input_data_one() then drop in-window DATA
for every unrelated call on the endpoint with RXRPC_ACK_NOSPACE? Those
packets were invited by the advertised rwind, so senders would see the
drops as loss and react with cwnd reduction and retransmits.

This recovers once the readers drain. However, the commit message presents
the change only as closing an accounting gap.

Could the commit message describe the shared budget across calls, how it
compares with the per-call windows, and why the advertised window is left
unchanged?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791994057.git.zihanx%40nebusec.ai
