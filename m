Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C437E317
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344506; cv=none; b=riH+4qAh/KG21+iGhDMGViv3WISeb+ovNQBk3HM91qq2c/saPvcodoV1gFkCTk3HnR+b/3cdLbEEAyZEKxygbjdeH6dxV9mJ81Iu7y+4WLT08mfEvFzyuAqYiYfM8RMJJ/q7iOHT+9ehE9KBPFmTazQwUO0jhYNrMfnj6My/fdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344506; c=relaxed/simple;
	bh=m07A85t0RxQykd1GV2UDBz87g6YaE7Rw8AbQ06LCXqA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVFqfMj9LJxYfoX6kRFxSfxvSKOT81jUSu0qaHqu1KJXB3QEiv43jU3LxaEEiN4gGutw0lmU55tlXbB0VINi23GX8PhCTrXe/NVtuoRBEzQA1C4rT6dpvgVULZuimiA17ghtLg13Zv9zn1PWyiRba8DAYYr4xo/zkjMruGsWWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byHHKuND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byHHKuND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0901F000C4;
	Sun, 18 Oct 2026 17:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344504;
	bh=aypCdVKNV+X6nyLG+TGJBWfsAqOpjTL5s79NzVhGa9Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=byHHKuNDOS1o7og0l5+mI2x+hZAVLAAtzJwonuciJjdfRw9/rN/iICnSyC6IUwO4a
	 bQTrcXNLQQ2hmKSotb1UXk6RqNFK65dxEj+wgCLZUrUu7QErXtqG0jr4Ft9qcaSJlq
	 7TQ0/wZcRhXDMuJPaXJpdhvDaZbdacYXHIIAg4rsXaRhJZ42xz8RwtDNkVkGu4O4Bd
	 y8WWY554i2w6s+SFlrtP4AzW6Iit4IzhtxcXzfxtQ9sd+nn5MyJEBIQgDOpfnfB1tj
	 5DqFtiKe03OEJbdQhgmthil9uvbcUVMeezfBLE1M+wSuc+iivbHaIG7SzN+RTC4G5G
	 WEh66SJgjQdBA==
Subject: Re: [PATCH net v9 2/3] rxrpc: bound connection and OOB receive queues
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@kernel.org, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top,
 kuba@kernel.org
Date: Sun, 18 Oct 2026 17:28:23 +0000
Message-ID: <179234450334.3135.15301834891389267819@kernel.org>
In-Reply-To:
 <7fcebf53a6ccaec41de4acc52465b2937297071a.1791994058.git.zihanx@nebusec.ai>
References:
 <7fcebf53a6ccaec41de4acc52465b2937297071a.1791994058.git.zihanx@nebusec.ai>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rxrpc: connection reference leak on aborted connection
- [Medium] The new receive budget is shared by everything on the
  endpoint, so one socket or peer can starve the others.
- [Low] The patch includes a refcount fix that the commit message does
  not mention.

Pre-existing issues:
- [High] A CHALLENGE skb queued on conn->rx_queue leaks its connection
  reference if the connection is aborted before the connection work…

--

rxrpc: bound connection and OOB receive queues

This patch adds a per-local byte budget, rx_async_queue_bytes, capped by
the UDP socket's sk_rcvbuf. It covers skbs queued on conn->rx_queue and
managed RxGK CHALLENGEs held on the socket OOB queues. The charge is
released when a packet is processed, answered, freed or purged.

Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/

> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 611c790bc6d0c..4baddd178cfa5 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c
> @@ -393,6 +393,8 @@ static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
>  	while ((skb = skb_dequeue(&conn->rx_queue))) {
>  		rxrpc_see_skb(skb, rxrpc_skb_see_conn_work);
>  		rxrpc_process_event(conn, skb);
> +		if (skb->mark != RXRPC_SKB_MARK_SERVICE_CONN_SECURED)
> +			rxrpc_uncharge_async_queue(conn->local, skb);
>  		rxrpc_free_skb(skb, rxrpc_skb_put_conn_work);
>  	}
>  }

[Severity: High]
This is a pre-existing problem rather than something this patch
introduces, but the patch is touching this loop and adding the
uncharge right here. Can a queued CHALLENGE leak its connection
reference when the connection gets aborted first?

rxrpc_post_challenge() pins the connection in the skb before queueing
it:

	sp->chall.conn =
		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);

For rxkad, and for RxGK when no socket manages responses, the skb then
goes to conn->rx_queue via rxrpc_post_packet_to_conn(). The only place
that ref is dropped on this path is the RXRPC_PACKET_TYPE_CHALLENGE
case in rxrpc_process_event().

If the I/O thread marks the connection RXRPC_CONN_ABORTED before
conn->processor gets to run, for instance because the peer sends an
ABORT right behind the CHALLENGE, rxrpc_process_event() bails out
before the switch:

	if (conn->state == RXRPC_CONN_ABORTED)
		return -ECONNABORTED;

The loop here then uncharges the budget and frees the skb, but nothing
puts sp->chall.conn. With that ref outstanding, conn->ref never reaches
zero, rxrpc_clean_up_connection() never runs, and the connection keeps
its local, peer, bundle and key pinned. A remote peer can repeat this
to leak connections without bound, and on netns teardown
rxrpc_destroy_all_connections() would be left waiting on
rxnet->nr_conns.

Would it be better to drop the ref in this loop when sp->hdr.type is
RXRPC_PACKET_TYPE_CHALLENGE and sp->chall.conn is still set, or to
handle it in the early-return path of rxrpc_process_event()? Note that
sp->chall.conn shares the union with poke_conn and resp, so the check
would need to be keyed on the packet type, not on the pointer alone.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
this loop is being changed anyway. Can a CHALLENGE skb on conn->rx_queue
leak its connection reference here?

rxrpc_post_challenge() takes a ref and stores it in the skb:

	sp->chall.conn =
		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);

For rxkad (no challenge_to_recvmsg), or for RxGK with no managing socket,
the skb is then queued on conn->rx_queue. On this path the ref is only
dropped in the CHALLENGE case of rxrpc_process_event().

The I/O thread can mark the connection aborted before conn->processor
runs. This happens via rxrpc_input_conn_abort() for a remote ABORT, or
via rxrpc_abort_conn() when a second, short CHALLENGE fails
validate_challenge. If it does, rxrpc_process_event() returns early:

	if (conn->state == RXRPC_CONN_ABORTED)
		return -ECONNABORTED;

The loop above then uncharges and frees the skb without putting
sp->chall.conn.

Wouldn't conn->ref then never reach zero? rxrpc_clean_up_connection()
would never run, and the conn would keep its local, peer, bundle and key
pinned. On netns exit, rxrpc_destroy_all_connections() would then hit
ASSERT(list_empty(&rxnet->conn_proc_list)), or wait on rxnet->nr_conns
forever.

A remote server could trigger this by sending a valid CHALLENGE followed
right away by an ABORT or a malformed CHALLENGE. The I/O thread would
handle both in the same batch, before the work item runs.

[ ... ]

> diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
> index c80ee2487d094..5ab4ec5ad8c31 100644
> --- a/net/rxrpc/oob.c
> +++ b/net/rxrpc/oob.c
> @@ -46,7 +46,8 @@ bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
>  		sk = &rx->sk;
>  		spin_lock_irq(&rx->recvmsg_lock);
>  
> -		if (sk->sk_state < RXRPC_CLOSE) {
> +		if (sk->sk_state < RXRPC_CLOSE &&
> +		    rxrpc_charge_async_queue(sp->chall.conn->local, skb)) {
>  			skb->skb_mstamp_ns = rx->oob_id_counter++;
>  			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
>  			skb_queue_tail(&rx->recvmsg_oobq, skb);

[Severity: Medium]
Could one socket starve every other user of the endpoint through this
shared budget?

rxrpc_charge_async_queue() checks a single per-local counter against
the UDP socket's sk_rcvbuf. There is no per-socket, per-connection or
per-peer limit.

The same counter covers two kinds of queue:

- conn->rx_queue, which the kernel drains promptly.
- These managed RxGK CHALLENGEs, which rxrpc_recvmsg_oob() moves to
  rx->pending_oobq without releasing the charge:

	skb_unlink(skb, &rx->recvmsg_oobq);
	if (need_response)
		rxrpc_add_pending_oob(rx, skb);

The charge is only released by rxrpc_respond_to_oob(),
rxrpc_kernel_free_oob() or socket teardown, so userspace decides how
long it is held. rxgk_validate_challenge() doesn't de-duplicate, so a
peer can push many CHALLENGEs into a managing socket that never
responds.

rxrpc_lookup_local() only refuses to share an endpoint when srx_service
is set. Client sockets on the same transport address can therefore
attach to an existing rxrpc_local, including one owned by a service.

Once the counter is full, rxrpc_post_packet_to_conn() and
rxrpc_notify_socket_oob() drop CHALLENGE and RESPONSE packets for every
other connection on that endpoint. Only sk_drops_inc() records the drop.

A service issues its CHALLENGE only once, on the UNSECURED->CHALLENGING
transition in rxrpc_new_incoming_call(). Wouldn't each dropped
handshake packet leave that connection stuck until its calls time out?

Would charging OOB entries to the owning socket, or reserving headroom
per connection, avoid this? The commit message also doesn't mention
this new drop behaviour.

[ ... ]

> diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
> index e2169d1a14b5f..a5113a284456e 100644
> --- a/net/rxrpc/skbuff.c
> +++ b/net/rxrpc/skbuff.c

[ ... ]

> @@ -66,7 +99,15 @@ void rxrpc_purge_queue(struct sk_buff_head *list)
>  	struct sk_buff *skb;
>  
>  	while ((skb = skb_dequeue((list))) != NULL) {
> -		int n = atomic_dec_return(select_skb_count(skb));
> +		int n;
> +
> +		if (skb->mark == RXRPC_SKB_MARK_SERVICE_CONN_SECURED) {
> +			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
> +
> +			rxrpc_uncharge_async_queue(sp->poke_conn->local, skb);
> +			rxrpc_put_connection(sp->poke_conn, rxrpc_conn_put_poke);
> +		}

[Severity: Low]
This isn't a bug, but the commit message doesn't mention the connection
refcount change here.

Before this patch, rxrpc_purge_queue() only consumed the skb. A SECURED
skb still on local->rx_queue when rxrpc_destroy_local() purged it never
put the ref taken in rxrpc_process_event():

	sp->poke_conn = rxrpc_get_connection(
		conn, rxrpc_conn_get_poke_secured);

The new rxrpc_put_connection() fixes that.

The patch also moves rxrpc_put_local() in rxrpc_clean_up_connection() to
after the second rxrpc_purge_conn_queue(), because the purge now
dereferences conn->local:

	rxrpc_purge_conn_queue(conn);

	page_frag_cache_drain(&conn->tx_data_alloc);
	rxrpc_put_local(conn->local, rxrpc_local_put_kill_conn);

The patch is tagged for stable. Could the commit message describe both
of these changes?

>  		trace_rxrpc_skb(skb, refcount_read(&skb->users), n,
>  				rxrpc_skb_put_purge);
>  		consume_skb(skb);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791994057.git.zihanx%40nebusec.ai
