Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561823;
	b=Z51SqDkDxFe62c+8GdXKmQzJProCZ0KaHhRw3qIWvNdcgYk/dEf4Uocbil1xt4c90WTp
	 hQZfVeESjgcMgHbx3lB/FlDIYTJEvtpZIEU5ArDVDpQPT+oeMr62hXFm4sJZLVSzlJxE/
	 irr6/9g3EiriVOH7VMLrbpnxGXD6PUmbNckzqocwlF9xE7RBnxCADfu/H7JwN+GLcpOoE
	 8jGgoeK6VL8bcLxdWRvb226LWqsq3ZpoaWYjIM0gMBBjlyRUlXU6N1EFWw1o8u1dWRrIA
	 SqSszIwhbwUeLKGvvwP8MVH0D2REORg5V9B6KsDChi9yAauot9n3NA0pdqyt6uZSz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561823;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=b0UeRimgEuLyoTq54ei0X4WYdqdQ1dFIU18FVk966AM=;
	b=gCeYfj9M7oH+FckUUmhbZBwrd0NrfDWvGa8RSfp1KAiJEM+ujO8Txcs2pf2xZGs9loRO
	 kvvdH+mtBZ45Wdt6qE1VSwcpQ4bldWI89eKVhFyQBFlsSJKYP2ek8gwbXEUJ2wG93faS5
	 D2gziwe15d2JnA7fNh32eZ82DQtwDYQcVbCvDiGPfY6/J8Ce3Q3I4kVpbCBbianFhs1zq
	 FvA1ulVJ7Xd7xnG9X4ShRspfRZbYx/A5GsufQ1dBzOf/virJWOn8h8PH3oAfsb47bQisl
	 nTyr4IN/K2ZWhe5zj0p4Uy9+xw04q45iaLMiO87/IRmzkLZ8bXdlK363lAQJnmeJqHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr0QNwpg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAB5606A32A;
	Fri, 13 Nov 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr0QNwpg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569AC1F000C4;
	Fri, 13 Nov 2026 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794561822;
	bh=b0UeRimgEuLyoTq54ei0X4WYdqdQ1dFIU18FVk966AM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tr0QNwpgl5Fj2LWhVbhGpfTTN89II9RF+84jijywNnTRPMdYWs3/soS1rU2O4zXOM
	 fX2pg+I1oPT3YZkVifiySbSxtESKnWCgDLZ9eAYGMAIzw9u27SegPi29Th3VIC25xi
	 c87C2hATkMIHjvWPZISl489OOCo5L2vV24fD4eFhhxz+iMqsLmIIGyyk7EeclYsJwv
	 q7mu9zSJ62Y8OFI7QEYyM/RWTbEq2gtIYP/r3uc6MBaUsJA+mGeJb9CO43jmtxZfqU
	 uCgOHMtHK70fjD9YNWVbdpCLU47Hc/cUhRvcJf2cFTprciWCwkUzj/CUV3SLak/+wE
	 6phe5G8v+NUOA==
Subject: Re: [PATCH net v2] rxrpc: Serialize client connection IDR updates
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: linux-afs@lists.infradead.org, dhowells@redhat.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 09:23:41 +0000
Message-ID: <179456182186.2199510.54970723548503568@kernel.org>
In-Reply-To: <20261110062221.96452-1-kylebot@openai.com>
References: <20261110062221.96452-1-kylebot@openai.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes rxrpc_destroy_client_conn_ids() take
  local->conn_ids_lock before its leak check, and BUG() is then called…
- [Low] rxrpc: missing Fixes tag for service conn cleanup in
  rxrpc_clean_up_connection()

Pre-existing issues:
- [High] This bug predates the patch, but it is High severity.

--

rxrpc: Serialize client connection IDR updates

This patch limits connection ID cleanup in the common destructor to client
connections, so service connections no longer remove IDs from the client
IDR. It adds a per-local conn_ids_lock and a RXRPC_CONN_HAS_IDR ownership
flag so that each ID is released only once. It also moves the ID release
in rxrpc_unbundle_conn() so the ID is dropped even when the bundle slot
has already been replaced.

> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index 48519f0de1853..201a50caeacae 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c
> @@ -40,12 +40,16 @@ static void rxrpc_activate_bundle(struct rxrpc_bundle *bundle)
>  }
>  
>  /*
> - * Release a connection ID for a client connection.
> + * Release a client connection ID exactly once.  The final reference may be
> + * dropped outside the local endpoint's I/O thread.
>   */
>  static void rxrpc_put_client_connection_id(struct rxrpc_local *local,
>  					   struct rxrpc_connection *conn)
>  {
> -	idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
> +	spin_lock(&local->conn_ids_lock);
> +	if (test_and_clear_bit(RXRPC_CONN_HAS_IDR, &conn->flags))
> +		idr_remove(&local->conn_ids, conn->proto.cid >> RXRPC_CIDSHIFT);
> +	spin_unlock(&local->conn_ids_lock);
>  }
>  
>  /*
> @@ -56,6 +60,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
>  	struct rxrpc_connection *conn;
>  	int id;
>  
> +	spin_lock(&local->conn_ids_lock);
>  	if (!idr_is_empty(&local->conn_ids)) {
>  		idr_for_each_entry(&local->conn_ids, conn, id) {
>  			pr_err("AF_RXRPC: Leaked client conn %p {%d}\n",
> @@ -65,6 +70,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
>  	}
>  
>  	idr_destroy(&local->conn_ids);
> +	spin_unlock(&local->conn_ids_lock);
>  }

[Severity: Medium]
If the leak check fires, BUG() now runs with local->conn_ids_lock held,
and the matching spin_unlock() is never reached. What happens to the
leaked connections after that?

Each leaked client connection still holds a ref on local, taken by
rxrpc_get_local() in rxrpc_alloc_client_connection(), so the lock memory
stays valid. When the final ref on one of them is dropped later, directly
or through schedule_work(), the path is:

rxrpc_put_connection()
  rxrpc_clean_up_connection()
    rxrpc_kill_client_conn()
      rxrpc_put_client_connection_id()
        spin_lock(&local->conn_ids_lock);

That spin_lock() would spin forever on the lock left behind by the dead
I/O thread. Before this patch, BUG() ran with no lock held.

The commit message says deferred final puts happened in practice at
endpoint teardown. Could one oops here turn into a soft lockup or a hung
kworker?

One option would be to do the check and the pr_err() output under the
lock, drop the lock, and then call BUG(). Another would be to WARN and
clean up instead.

[ ... ]

> @@ -682,6 +693,9 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
>  	if (conn->flags & RXRPC_CONN_FINAL_ACK_MASK)
>  		rxrpc_process_delayed_final_acks(conn, true);
>  
> +	/* A replaced connection is no longer in the bundle. */
> +	rxrpc_put_client_connection_id(bundle->local, conn);
> +

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Since
this patch now handles replaced connections in rxrpc_unbundle_conn(),
should the disconnect path handle them too?

rxrpc_add_conn_to_bundle() replaces any slot whose connection fails
rxrpc_may_reuse_conn(). It does not check whether the old connection
still has active calls (old->act_chans):

net/rxrpc/conn_client.c:rxrpc_add_conn_to_bundle() {
    ...
	old = bundle->conns[slot];
	if (old) {
		bundle->conns[slot] = NULL;
		bundle->conn_ids[slot] = 0;
		trace_rxrpc_client(old, -1, rxrpc_client_replace);
		rxrpc_put_connection(old, rxrpc_conn_put_noreuse);
	}
    ...
	conn->bundle_shift = shift;
	bundle->conns[slot] = conn;
    ...
	for (i = 0; i < RXRPC_MAXCALLS; i++)
		set_bit(shift + i, &bundle->avail_chans);
}

A connection can become non-reusable while calls are still running on it.
rxrpc_set_conn_aborted() sets RXRPC_CONN_DONT_REUSE on an abort, which a
remote peer can trigger. rxrpc_expose_client_call() sets it when
call_counter reaches INT_MAX. rxrpc_may_reuse_conn() sets it when the CID
is too far from the IDR cursor.

The new connection B gets the same bundle_shift as the old connection A.
New calls take B's channels. When A's still-active call on channel c
finishes, rxrpc_disconnect_client_call() runs:

	chan->call = NULL;
	set_bit(conn->bundle_shift + channel, &conn->bundle->avail_chans);

Nothing checks that bundle->conns[slot] == conn, so this marks B's
channel c as free while a call Y1 is still using it.
rxrpc_activate_channels() then picks that bit and runs:

		slot = channel / RXRPC_MAXCALLS;
		conn = bundle->conns[slot];
		...
		rxrpc_activate_one_channel(conn, channel);

This overwrites B->channels[c].call with a second call Y2 while Y1 is
still attached. If Y1 has not been exposed yet, Y2 gets the same call_id,
so two calls can go out with the same CID and callNumber. When Y1
disconnects later, it hits WARN_ON(chan->call != call) and returns early.

Does rxrpc_disconnect_client_call() need to skip the avail_chans update
when conn is no longer in bundle->conns[]?

>  	bindex = conn->bundle_shift / RXRPC_MAXCALLS;
>  	if (bundle->conns[bindex] == conn) {
>  		_debug("clear slot %u", bindex);

[ ... ]

> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -332,7 +332,8 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
>  	rxrpc_purge_queue(&conn->rx_queue);
>  	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
>  
> -	rxrpc_kill_client_conn(conn);
> +	if (rxrpc_conn_is_client(conn))
> +		rxrpc_kill_client_conn(conn);
>  
>  	conn->security->clear(conn);
>  	key_put(conn->key);

[Severity: Low]
The changelog blames only 9d35d880e0e4 ('rxrpc: Move client call
connection to the I/O thread'). That commit dropped the
RXRPC_CONN_HAS_IDR test and the lock from
rxrpc_put_client_connection_id(). That covers the double removal
and the IDR locking parts of this fix.

The service connection part seems to have a different origin. The
unconditional rxrpc_kill_client_conn() call in
rxrpc_clean_up_connection() looks older than that. It appears to
have come in when rxrpc_put_client_conn() and
rxrpc_put_service_conn() were merged into rxrpc_put_connection()
and the common destructor, in 3cec055c5695 ('rxrpc: Don't hold a
ref for connection workqueue').

Since that change, every service connection reaching the
destructor runs the client-only cleanup:

  - it decrements rxnet->nr_client_conns
  - it calls rxrpc_put_client_connection_id() on a CID the peer
    chose

The new rxrpc_conn_is_client() guard is what fixes this.

Could you check that history and, if it holds, add

  Fixes: 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")

alongside the existing tag? Then the stable maintainers can see
which trees need the rxrpc_conn_is_client() guard.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110062221.96452-1-kylebot%40openai.com
