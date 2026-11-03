Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680293;
	b=keMnMYmM1MsmD0o5pyWoKLiknojUOjNA9N8O9UEY9PjCVLhg/VwcssdrPkjZH1AXthXE
	 OAUL6dNwkcAFmFpby0NeYWu74TlIH5cAx8+Bdl8qx1W6Y7rQtCeBD53WOg0gHaJTIgxRj
	 x5edg3vWAjHavSu7t/QoB53uoxMXfxu3LoWEksIhH9QJiwoXF1YPWdi35Cc6cxc2ph0Ul
	 VLao2iCZrvLTdXwmvJlX0bAjQiHUviOYL4PE9BdULlLTtTulWqccrcodmTdjAURm9FWya
	 0I/MMEm2/p6NsmkXhkcfV334nFEs8dj42fvJDYy1DKGjU5drfWvPYr4HnQ0+yH01wGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680293;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HBnEGPrUjEKBZN3/I1iTzU6psOWFjDh9X6zt5JL5Tq8=;
	b=PDLy8Nb0fsEBx05xe83sstaAm+fSf+aCMErXOu8h3vEyo1Aeu/JtfjyCihotX2NHjjgI
	 Er2c042sctW/h7qkBzxCLlJmIAyWzqaddpGwcaTz4L8dYEfWOsKD+o0NLWOvL9XlpabkS
	 TXjeL4gRas5DWaz/zZm8c8FVpL4rdjWwpj/uEfyw+B6/OmV28oJkHD+b55zQx3OXyi3aX
	 wFJwVd78mTzX9HLimIxYbYO425sR/q1cj4+rPj6f58xkxTz59YSZvYNnP9qYQCOZG8dZV
	 sQ0afw9NI0Jq3ExamaM7Tsp1BObd2jISGWU/Y+UkPyzWFprJP61m4fZ3D958qEV1xzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXFYwlzs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FF606A324;
	Tue,  3 Nov 2026 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXFYwlzs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3761F000C1;
	Tue,  3 Nov 2026 04:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793680292;
	bh=HBnEGPrUjEKBZN3/I1iTzU6psOWFjDh9X6zt5JL5Tq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXFYwlzsy1Bklz6ae4Nr+YZrLopFV53EkPNPqrP3ynRS31+vGUCSJPRckaWX6BLLe
	 P6vWUuuAaBRDcawDwxapExGog87AkbJZR57neMzaKPgFTG1KGQfcO2EeusF6dTBP2a
	 BxSloMgQIIJvkt8OztNa14MmJMGNimSH/NHV8+Dec22BNEfOAKoD2ohxxc7Ppy9r9i
	 9VXBRYQ4xPhCMBlRtZM1CWl83O1dPQPGox5ZAqJ7y0YpvaUlJABUdmJSwYhUubHIUZ
	 MEuIV5hFO8/H2RnQxFpSXQL/sTCajqEEtrKqMSrXx2cyPa4naSHohiOPul4OzZlGqi
	 PpyydYqg9I8fQ==
Subject: Re: [PATCH] rxrpc: Serialize client connection IDR updates
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: linux-afs@lists.infradead.org, dhowells@redhat.com,
 marc.dionne@auristor.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com, kuba@kernel.org
Date: Tue, 03 Nov 2026 04:31:31 +0000
Message-ID: <179368029159.488856.12235423992714726798@kernel.org>
In-Reply-To: <20261030042129.73690-1-kylebot@openai.com>
References: <20261030042129.73690-1-kylebot@openai.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Local endpoint teardown can still reach the BUG() in
  rxrpc_destroy_client_conn_ids() while a replaced client connection's…
- [Low] The commit message says the patch works "without changing
  connection expiry", but it does change client-connection expiry.

--

rxrpc: Serialize client connection IDR updates

This patch limits the rxrpc_kill_client_conn() call in the common
connection destructor to client connections. Service connections
therefore no longer remove unrelated entries from local->conn_ids. It
also adds a per-local conn_ids_lock and an RXRPC_CONN_HAS_IDR ownership
flag, so that a client ID is released only once, and takes the same lock
around IDR allocation and destruction.

> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index 48519f0de1853..4c2db83fceaee 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c

[ ... ]

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

[Severity: High]
The commit message says this "covers deferred final puts". Can teardown
still reach the BUG() here while a deferred final put still owns an IDR
entry?

The lock only orders the deferred put against idr_destroy(). If teardown
takes the lock first, the entry is still in the IDR.

One way this can happen is with a replaced client connection.
rxrpc_add_conn_to_bundle() takes a non-reusable connection out of its
slot without releasing its ID:

net/rxrpc/conn_client.c:rxrpc_add_conn_to_bundle() {
	old = bundle->conns[slot];
	if (old) {
		bundle->conns[slot] = NULL;
		bundle->conn_ids[slot] = 0;
		trace_rxrpc_client(old, -1, rxrpc_client_replace);
		rxrpc_put_connection(old, rxrpc_conn_put_noreuse);
	}
	...
}

So RXRPC_CONN_HAS_IDR stays set on the old connection. rxrpc_unbundle_conn()
only releases the ID if the connection still owns its slot:

	if (bundle->conns[bindex] == conn) {
		...
		rxrpc_put_client_connection_id(bundle->local, conn);

The old connection can still have an active call when it is replaced.
rxrpc_may_reuse_conn() marks it RXRPC_CONN_DONT_REUSE on ID drift from the
cursor, on a remote abort, or when the call counter runs out.

When the socket closes, that call is aborted and disconnected, and its
final put goes through rxrpc_cleanup_call():

	if (rcu_read_lock_held())
		schedule_work(&call->destroyer);
	else
		rxrpc_destroy_call(&call->destroyer);

Without CONFIG_DEBUG_LOCK_ALLOC, rcu_read_lock_held() always returns 1. The
destroyer then always goes to system_wq and holds the call->conn reference
until it runs. rxrpc_release_sock() flushes only rxrpc_workqueue.

The I/O thread can then run:

rxrpc_destroy_local()
  rxrpc_clean_up_local_conns()
    rxrpc_unbundle_conn()        <- skips the ID release, slot was replaced
    rxrpc_put_connection()       <- not final, the destroyer holds a ref
  rxrpc_purge_client_connections()
    rxrpc_destroy_client_conn_ids()
      IDR not empty -> "Leaked client conn" -> BUG()

rxrpc_put_connection() can also defer the final put itself:

	if (in_softirq() || work_busy(&conn->processor) ||
	    timer_pending(&conn->timer))
		schedule_work(&conn->destructor);

rxrpc_process_connection() can be the caller whose rxrpc_unuse_local()
drops active_users to zero and starts teardown while its own work item is
still running.

The missing ID release for replaced connections and this BUG() both
predate this patch. Still, the race between deferred final puts and IDR
destruction that the commit message says is covered can still crash.

Could the ID be released when a replaced connection is retired, even if
it no longer holds its bundle slot? Alternatively, teardown could wait
for pending ID releases before the empty-tree check, without holding
conn_ids_lock while it waits.

[ ... ]

> diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
> index 0ece717db0f85..bae95cadd72bb 100644
> --- a/net/rxrpc/conn_object.c
> +++ b/net/rxrpc/conn_object.c
> @@ -332,7 +332,8 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
>  	rxrpc_purge_queue(&conn->rx_queue);
>  	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
>  
> -	rxrpc_kill_client_conn(conn);
> +	if (rxrpc_conn_is_client(conn))
> +		rxrpc_kill_client_conn(conn);

[Severity: Low]
This isn't a bug, but is this part of the commit message accurate?

    This covers deferred final puts without changing connection
    expiry or the RCU lookup path.

rxrpc_kill_client_conn() calls atomic_dec(&rxnet->nr_client_conns) without
checking the connection type. The only increment is in
rxrpc_alloc_client_connection().

Before this patch, every destroyed service connection also decremented
the counter. On hosts that serve calls, it could therefore go negative.

rxrpc_discard_expired_client_conns() reads the counter into an unsigned
int:

	nr_conns = atomic_read(&local->rxnet->nr_client_conns);
	...
		expiry = rxrpc_conn_idle_client_expiry;
		if (nr_conns > rxrpc_reap_client_connections)
			expiry = rxrpc_conn_idle_client_fast_expiry;

A negative value wraps to a huge number, so the 2*HZ fast expiry is
always chosen. With the new rxrpc_conn_is_client() check, the counter
stays balanced and idle client connections get the normal 2*60*HZ expiry
again.

The new behaviour looks correct. Could the commit message mention the
nr_client_conns accounting fix and the expiry change that comes with it,
instead of saying expiry is unchanged?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030042129.73690-1-kylebot%40openai.com
