Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527674;
	b=TBXgyMQ67oOZkAjlFKs2Jjo74oqY6D0lTHlno1h/8VYDXoliXvUFeYEhI0lj8hiLg379
	 l0/4iu9JMP/A6gCvzGKAKEIVC3YVgVeGc9PbW+ZZiD50MTMbyn8cCcRkwXAWfgFXo+3Uv
	 zU3HNm6Bray35jyL/g/bJ2MKRVoJMYSSJ2wO84qRMYaphKJQSEpDv00EimhRtLt+/lcIj
	 o+RB/fxVcpzSnJyXRxe0Ca3OtAKy0Y5WuwjiSZgtoCfz0rHoGtPmrq61GofDFZKb8/PWc
	 pn6w9WpZ2IRv3gpKpf52AeHuInm1Me/Ji2S4vI1x9tEaKxRfOy8aiFDtgWSGfHGtQxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527674;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OANjR1hV8jk/1rCoZmOtAFBGJsPcaDgBe8GRMxmlTe4=;
	b=hz6wxxjYm4W7xTbkFJ9q02n5mTc9axC4J/dVG066qswMhf69X9wkSlJVzX5q2rFb0gso
	 GP0fUbWEWqKM9STikY4iIgjOsf02fqAGNG1A+EDbRX2qhVOl3dQV7T50y7brmXDQyu4aO
	 TgCMzCCOM+t6AwRHNa1ytF7DVFJERKky2w6+UjbJ7g+Z8FjPecfx/NRV7tZlvap0fThZ7
	 Ibimwt3L8Ft1hxkvVahl0BIyFndi1oZ+UjE8gEFef5XtxijHarLDP9xzOk6Uwq9CiN2kW
	 axvviRddfsfKTBU8oDyEARnGLMf28e0kgbdRqTclz6aU2zRb/xBJv2Y0bo79TE63/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1SxUAtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB66606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1SxUAtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66011F000C9;
	Tue, 20 Oct 2026 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527673;
	bh=OANjR1hV8jk/1rCoZmOtAFBGJsPcaDgBe8GRMxmlTe4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n1SxUAtQQYWsZpGsChjuaAAtuWAtWRCBAMEe6+T/xQBakLJv4ffnvxn2c+JvqCLn6
	 SgZZH5QImd4zdYnlQw1U53u6uog0E19NhZFr1vH9Xrpy3jgp5M1UskNEVx7ul4pjy5
	 eXVWgZYzAy2d4vNT126jENp6sj+lHAgbbYQQ1Ear3aiaC2pnL7b1gqAouGZQu6175A
	 4sFwVpT1gXSLWOmczD4/Ehoc+3328CXMFsFws3CTQ7BGdI97VIhrmTNx8z5kIs5J0q
	 7AHho9oIP4iOoydApuPOMYFy/0tK2DsZUN1jq4RoW2bH2tbxpz+gilQnYjVb8rMUWU
	 RkcNd1R2SUApw==
Subject:
 Re: [PATCH net v10 2/3] rxrpc: bound connection and OOB receive queues
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-afs@lists.infradead.org, netdev@vger.kernel.org, dhowells@redhat.com,
 marc.dionne@auristor.com, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai, root@tr0jan.top,
 kuba@kernel.org
Date: Tue, 20 Oct 2026 20:21:12 +0000
Message-ID: <179252767234.3135.11561725794008446183@kernel.org>
In-Reply-To:
 <b66a782a7c4180da2048b8d8f4ffcfe7e5877f0e.1792168462.git.zihanx@nebusec.ai>
References:
 <b66a782a7c4180da2048b8d8f4ffcfe7e5877f0e.1792168462.git.zihanx@nebusec.ai>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new async receive budget lives on the rxrpc_local, not on
  the socket.
- [Low] The patch includes fixes and semantic changes that its commit
  message does not describe: (a) rxrpc_purge_queue() now drops…
- [Low] rxrpc_notify_socket_oob() (net/rxrpc/oob.c) now sets skb->mark =
  RXRPC_SKB_MARK_CHALLENGE on the skb the I/O thread is still processing.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch now
  adds the new receive charge to it.
- [Low] This problem wasn't introduced by this patch, but the comment
  above the second rxrpc_purge_conn_queue() in…

--

rxrpc: bound connection and OOB receive queues

This patch charges packets held on conn->rx_queue, and managed RXGK
challenges held on the socket OOB queues, to a new per-local budget
(rx_async_queue_bytes) that is capped by the UDP socket's sk_rcvbuf. The
charge is released when a packet is processed, answered, freed or purged.
Queued OOB challenges also get their own skb mark,
RXRPC_SKB_MARK_CHALLENGE.

Link: https://lore.kernel.org/all/cover.1791994057.git.zihanx@nebusec.ai/

> Account both paths against a per-local receive budget. Release the charge
> when a packet is processed, answered, freed or purged, and retain it when a
> secured service packet is returned to the local I/O queue.

[Severity: Low]
This isn't a bug, but the patch makes a few changes that the commit message
doesn't mention.

rxrpc_purge_queue() now drops sp->poke_conn for
RXRPC_SKB_MARK_SERVICE_CONN_SECURED skbs that are still on local->rx_queue
at endpoint teardown. Before, it only called consume_skb(), so that
connection reference leaked.

rxrpc_do_process_connection() now puts sp->chall.conn when
rxrpc_process_event() returns -ECONNABORTED before it reaches the CHALLENGE
case. That reference also leaked before.

OOB challenge skbs now get an explicit skb->mark = RXRPC_SKB_MARK_CHALLENGE.
The old code relied on RXRPC_SKB_MARK_PACKET == RXRPC_OOB_CHALLENGE == 0.
Also, rxrpc_kernel_query_oob() and rxrpc_kernel_dequeue_oob() now hard-code
RXRPC_OOB_CHALLENGE instead of returning skb->mark.

Of these, only the second shows up, in the v10 changelog below the cut, and
that text is dropped when the patch is applied.

Since this is Cc: stable, could the ref-leak fixes be split out with their
own Fixes tags, or at least described in the commit message?

> diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> index 611c790bc6d0c..d37cef2523997 100644
> --- a/net/rxrpc/conn_event.c
> +++ b/net/rxrpc/conn_event.c

[ ... ]

> @@ -414,15 +423,22 @@ void rxrpc_process_connection(struct work_struct *work)
>   * post connection-level events to the connection
>   * - this includes challenges, responses, some aborts and call terminal packet
>   *   retransmission.
> + * - bound the queued memory independently of the UDP rmem charge.
>   */
> -static void rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
> +static bool rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
>  				      struct sk_buff *skb)
>  {
> +	struct rxrpc_local *local = conn->local;
> +
> +	if (!rxrpc_charge_async_queue(local, skb))
> +		return false;
> +
>  	_enter("%p,%p", conn, skb);
>  
>  	rxrpc_get_skb(skb, rxrpc_skb_get_conn_work);
>  	skb_queue_tail(&conn->rx_queue, skb);
>  	rxrpc_queue_conn(conn, rxrpc_conn_queue_rx_work);
> +	return true;
>  }

[Severity: High]
This is a pre-existing issue, but the new charge now gets caught up in it.
What happens if a packet is queued here while the last socket on the local
is being released?

rxrpc_release_sock() calls flush_workqueue(rxrpc_workqueue) before
rxrpc_unuse_local(). When active_users reaches 0, rxrpc_unuse_local() calls
kthread_stop(local->io_thread). The I/O thread keeps draining
local->rx_queue and only then calls rxrpc_destroy_local().

In that window, an rxkad CHALLENGE for a live client connection (for
example an idle one on local->idle_client_conns) can take this path:

rxrpc_post_challenge()
  sp->chall.conn = rxrpc_get_connection(conn, ...)
  rxrpc_post_packet_to_conn()
    rxrpc_charge_async_queue()
    skb_queue_tail(&conn->rx_queue, skb)
    rxrpc_queue_conn()

The worker then runs:

rxrpc_process_connection() {
	if (__rxrpc_use_local(conn->local, rxrpc_local_use_conn_work)) {
		rxrpc_do_process_connection(conn);
		...
	}
}

__rxrpc_use_local() fails because active_users is 0, so the worker never
touches conn->rx_queue.

The skb now holds a connection reference while it sits on that same
connection's rx_queue. When rxrpc_clean_up_local_conns() drops the idle-list
reference, the refcount stays at 1. That means rxrpc_clean_up_connection()
and rxrpc_purge_conn_queue() never run.

Does this leak the skb, the connection, and its local and peer references?
The conn would also stay on rxnet->conn_proc_list. Netns teardown could then
hit ASSERT(list_empty(&rxnet->conn_proc_list)) in
rxrpc_destroy_all_connections(), which is BUG() in rxrpc, or hang in
wait_var_event() on nr_conns.

The stranded rx_async_queue_bytes charge looks harmless, because that local
is dead and is never reused.

When the local can't be used, could the skipped-worker path purge and
uncharge conn->rx_queue (dropping chall.conn)? Alternatively, could teardown
stop the producer before the final workqueue flush?

[ ... ]

> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 0ece717db0f85..d85345e014a9f 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c

[ ... ]

> @@ -338,15 +351,15 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
>  	key_put(conn->key);
>  	rxrpc_put_bundle(conn->bundle, rxrpc_bundle_put_conn);
>  	rxrpc_put_peer(conn->peer, rxrpc_peer_put_conn);
> -	rxrpc_put_local(conn->local, rxrpc_local_put_kill_conn);
>  
>  	/* Drain the Rx queue.  Note that even though we've unpublished, an
>  	 * incoming packet could still be being added to our Rx queue, so we
>  	 * will need to drain it again in the RCU cleanup handler.
>  	 */
> -	rxrpc_purge_queue(&conn->rx_queue);
> +	rxrpc_purge_conn_queue(conn);
>  
>  	page_frag_cache_drain(&conn->tx_data_alloc);
> +	rxrpc_put_local(conn->local, rxrpc_local_put_kill_conn);
>  	call_rcu(&conn->rcu, rxrpc_rcu_free_connection);
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but is this comment still
accurate? rxrpc_rcu_free_connection() never drains conn->rx_queue. It only
traces, kfree()s the conn and decrements nr_conns.

Late arrivals don't look possible either. The only producer,
rxrpc_post_packet_to_conn(), runs with a reference taken through
rxrpc_get_connection_maybe().

Under the new accounting, a drain in the RCU handler couldn't uncharge
anyway, because rxrpc_put_local() would already have run.

Since rxrpc_put_local() is being moved around this purge anyway, could the
comment be updated as well?

[ ... ]

> diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
> index c80ee2487d094..e3d135b12d22d 100644
> --- a/net/rxrpc/oob.c
> +++ b/net/rxrpc/oob.c
> @@ -46,7 +46,9 @@ bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
>  		sk = &rx->sk;
>  		spin_lock_irq(&rx->recvmsg_lock);
>  
> -		if (sk->sk_state < RXRPC_CLOSE) {
> +		if (sk->sk_state < RXRPC_CLOSE &&
> +		    rxrpc_charge_async_queue(sp->chall.conn->local, skb)) {

[Severity: High]
Can one socket use this charge to starve every other user of the same
rxrpc_local?

rx_async_queue_bytes is a single counter per rxrpc_local, capped by the UDP
socket's sk_rcvbuf. It has no per-socket or per-connection split:

rxrpc_charge_async_queue() {
	...
		queued = atomic_long_read(&local->rx_async_queue_bytes);
		if (queued &&
		    (queued >= rcvbuf ||
		     (long)skb->truesize >= rcvbuf - queued)) {
			sk_drops_inc(sk);
			return false;
		}
	...
}

The connection worker frees conn->rx_queue packets quickly. A managed RXGK
CHALLENGE charged here is different: it stays charged on rx->recvmsg_oobq
and then rx->pending_oobq until the application answers it through
rxrpc_respond_to_oob(), or it is freed by rxrpc_kernel_free_oob() or
rxrpc_purge_oob_queue(). Nothing limits how long these stay or how many
there are.

An unprivileged user can attach to a shared endpoint. rxrpc_bind() with
srx_service == 0 goes through rxrpc_lookup_local(), which reuses any
existing local with a matching transport address. That includes a service
endpoint such as kAFS.

That user could then set RXRPC_MANAGE_RESPONSE, make an RXGK call to a
server they control, and never answer the challenges.
rxgk_validate_challenge() doesn't deduplicate, so every CHALLENGE goes
through rxrpc_post_challenge()->rxrpc_notify_socket_oob() and is charged
here.

After roughly sk_rcvbuf / truesize challenges, rxrpc_charge_async_queue()
fails for every other connection on the local. rxrpc_post_packet_to_conn()
then silently drops their CHALLENGE and RESPONSE packets.
rxrpc_post_challenge() still returns true, and rxrpc_input_conn_packet()
ignores the result for RESPONSE.

Would that leave other sockets' service connections stuck in CHALLENGING,
and their client connections never answering, until timeout? That would
last for as long as the attacker keeps the socket open.

The later patch in this series, "rxrpc: bound DATA receive queues", charges
DATA to the same per-local counter. With the budget pinned, DATA would then
be dropped for every call on the endpoint as well.

The commit message only says both paths are accounted "against a per-local
receive budget" and doesn't mention this trade-off. Would per-socket
accounting, or a separate reservation for OOB challenges, avoid it?

> +			skb->mark = RXRPC_SKB_MARK_CHALLENGE;

[Severity: Low]
rxrpc_io_thread() is still processing this skb; the post path only takes an
extra reference with rxrpc_get_skb(). After rxrpc_input_packet() returns,
the I/O thread does:

	if (!rxrpc_input_packet(local, skb))
		rxrpc_reject_packet(local, skb);
	trace_rxrpc_rx_done(skb->mark, skb->priority);

Before this patch the mark stayed 0 on this path. Will the rxrpc_rx_done
tracepoint now report r=2 (RXRPC_SKB_MARK_CHALLENGE) as the receive result
for every queued managed RXGK challenge, instead of 0 or a REJECT code?

>  			skb->skb_mstamp_ns = rx->oob_id_counter++;
>  			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
>  			skb_queue_tail(&rx->recvmsg_oobq, skb);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792168462.git.zihanx%40nebusec.ai
