Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930636A35C;
	Fri, 25 Sep 2026 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331118; cv=none; b=NMPiOBhY+lEXjHWCczA/VhstWTBf2v9wIVYKk7pdf1tC1D9VOZ1Iqno7RF+hx1CZG5cccXIe8AikdJvo45fvZXcmWuDBogmEaXsuPYZvlORIiCkvoXKpLFFwsCnqjGRQyt6CwbR4jDxeZDdJ0R2CqVxSWW7lJrOvA7Vd1k5yh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331118; c=relaxed/simple;
	bh=b0pVQGjkDP6QRAThAmTrovqLN1GF+K6mfxucrXag3Fc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQFk7RSew0ngiq3UFQlDWG/pjhwxOxb0KJD7iHdBknmWR0mRy0bWTEwtYTqS0g5Ym3k3LLbxeVUHhLL9JLr6PMFax3uW4FzKiBdsfusmQHjcy0tQIKCJz0NkiTFytBHfQ401IdhwLhc8iV6Z7o4mmU6OXcJpijPO6/3dyqHg/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8xvbp+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8xvbp+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0A81F000FF;
	Fri, 25 Sep 2026 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331116;
	bh=HIkRTOvYBxD/OT3EQFCTGmdAtiDmI8CN2ftCPA8FYaY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J8xvbp+gJdxRc5L1+kJs3adnvyoDaffSKjNL8lw+YMPaTyKbo3hpkWufClRvh/5O+
	 7ftjPPvObzlEHRw20BzSRR0F4/UW1lCImh1W3/N2Fepcq5qD2wNs+jyO8kxm3VaD9q
	 t2v/q1DxgNGnQNpX4XAzK71CFUJ6KKWPMdh/B1X297sVdiJpOu4OEV/AXtzKFt7Tc2
	 MvV9DpX4LO08Ytnw33VQz9cuQuOkSfY/jWJZU3fJAeocfHZCabQwYv7SOG3wvvbvLj
	 0JGReD2m7hBkb4M7k11AvgT6zMVpesGjv5bMyRh627QZIeu7Dp8McNmu5RIzV5JHe4
	 pHa9rcCK+mULw==
Subject: Re: [PATCH] rxrpc: add missing unbundle old conn
From: netdev-bot+sashiko@kernel.org
To: eadavis@sina.com
Cc: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com, davem@davemloft.net,
 dhowells@redhat.com, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Date: Fri, 25 Sep 2026 10:11:55 +0000
Message-ID: <179033111533.2160803.6082294415431468966@kernel.org>
In-Reply-To: <20260923041022.25845-1-eadavis@sina.com>
References: <20260923041022.25845-1-eadavis@sina.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In net/rxrpc/conn_client.c, rxrpc_add_conn_to_bundle() now
  calls rxrpc_unbundle_conn(old), but it keeps the old cleanup that…
- [High] Calling rxrpc_unbundle_conn() from rxrpc_add_conn_to_bundle()
  also idr_remove()s the old connection's CID from local->conn_ids at…
- [Low] The patch presents itself as a fix for a syzbot-reported kernel
  BUG() in rxrpc_purge_client_connections() that userspace can trigger…
- [Low] The new forward declaration `static void
  rxrpc_unbundle_conn(struct rxrpc_connection *conn);` sits between the…

--

rxrpc: add missing unbundle old conn

This patch makes rxrpc_add_conn_to_bundle() call rxrpc_unbundle_conn() on
the old connection before a new connection replaces it in a bundle slot.
It is meant to fix a syzbot-reported BUG in
rxrpc_destroy_client_conn_ids(), which fires when the local endpoint is
destroyed.

Closes: https://syzkaller.appspot.com/bug?extid=e2f5927fc701355ef101

> Reported-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2f5927fc701355ef101
> Tested-by: syzbot+e2f5927fc701355ef101@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>

[Severity: Low]
This isn't a bug, but should this carry a Fixes: tag, and possibly a Cc:
stable?

The slot replacement path in rxrpc_add_conn_to_bundle() came in with
commit 9d35d880e0e4 ("rxrpc: Move client call connection to the I/O
thread"). Without a Fixes: tag, stable maintainers can't easily tell which
kernels need this change.

> diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
> index 48519f0de1853..9f13520be249b 100644
> --- a/net/rxrpc/conn_client.c
> +++ b/net/rxrpc/conn_client.c
> @@ -335,6 +335,7 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
>  /*
>   * Allocate a new connection and add it into a bundle.
>   */
> +static void rxrpc_unbundle_conn(struct rxrpc_connection *conn);

[Severity: Low]
This isn't a bug, but the forward declaration now sits between the comment
for rxrpc_add_conn_to_bundle() and the function. As a result, "Allocate a
new connection and add it into a bundle" reads as if it describes
rxrpc_unbundle_conn().

Could the declaration go above the comment? Another option is to reorder
the functions so that no forward declaration is needed.

>  static bool rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle,
>  				     unsigned int slot)
>  {
> @@ -344,6 +345,7 @@ static bool rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle,
>  
>  	old = bundle->conns[slot];
>  	if (old) {
> +		rxrpc_unbundle_conn(old);
>  		bundle->conns[slot] = NULL;
>  		bundle->conn_ids[slot] = 0;
>  		trace_rxrpc_client(old, -1, rxrpc_client_replace);

[Severity: Critical]
Does this drop the bundle's reference on old twice?

On this path, old->bundle_shift is slot * RXRPC_MAXCALLS. That means the
bundle->conns[bindex] == conn check in rxrpc_unbundle_conn() is always
true, and that branch already puts the reference:

net/rxrpc/conn_client.c:rxrpc_unbundle_conn() {
    ...
	if (bundle->conns[bindex] == conn) {
		...
		rxrpc_put_client_connection_id(bundle->local, conn);
		rxrpc_deactivate_bundle(bundle);
		rxrpc_put_connection(conn, rxrpc_conn_put_unbundle);
	}
}

After it returns, the existing code in rxrpc_add_conn_to_bundle() carries
on with:

		bundle->conns[slot] = NULL;
		bundle->conn_ids[slot] = 0;
		trace_rxrpc_client(old, -1, rxrpc_client_replace);
		rxrpc_put_connection(old, rxrpc_conn_put_noreuse);

rxrpc_alloc_client_connection() does refcount_set(&conn->ref, 1), and that
one reference is the one held for bundle->conns[slot]. Before this patch
it was put exactly once.

If old has gone idle, rxrpc_disconnect_client_call() has already taken an
rxrpc_conn_get_idle reference and moved cache_link onto
local->idle_client_conns, so ref is 2. The two puts take ref to 0 while
cache_link is still linked. The I/O thread then runs
rxrpc_clean_up_connection() synchronously and hits:

	ASSERT(list_empty(&conn->cache_link));

That ASSERT calls BUG().

The other refcount states go wrong in different ways:

- With exactly one active call on old, the ASSERT on
  conn->channels[x].call fires instead.
- With two or more active calls, the count ends up one short. old is later
  freed through call_rcu() while call->conn still points to it.
- If ref is 1, the first put frees old, and then trace_rxrpc_client() and
  the second put both touch freed memory.

A remote peer can reach this. A connection-level ABORT goes through
rxrpc_input_conn_abort()->rxrpc_set_conn_aborted() and sets
RXRPC_CONN_DONT_REUSE. The next call to the same peer then goes through
rxrpc_connect_client_calls()->rxrpc_bundle_has_space()->
rxrpc_add_conn_to_bundle().

[Severity: High]
Apart from the refcount, is it safe to remove old's CID from
local->conn_ids here?

rxrpc_unbundle_conn() calls rxrpc_put_client_connection_id(), which does
an idr_remove(). Until now that only ran for idle or expired connections.

rxrpc_bundle_has_space() chooses the slot to replace based only on whether
the connection can be reused:

		if (rxrpc_may_reuse_conn(bundle->conns[i]))
			usable++;
		else if (slot == -1)
			slot = i;

A connection can fail rxrpc_may_reuse_conn() while it still has active
calls. One case is rxrpc_expose_client_call():

		if (chan->call_counter >= INT_MAX)
			set_bit(RXRPC_CONN_DONT_REUSE, &conn->flags);

Others are the idr distance check and an rxgk rekey limit.

Incoming client-side packets are matched to a connection only through the
IDR:

net/rxrpc/conn_object.c:rxrpc_find_client_connection_rcu() {
    ...
	conn = idr_find(&local->conn_ids, sp->hdr.cid >> RXRPC_CIDSHIFT);
    ...
}

Once the CID has been removed, would DATA, ACK and ABORT packets for the
calls still running on old go down the rxrpc_eproto_no_client_conn
protocol error path in rxrpc_input_packet()? Those calls would then stall
until they time out.

The same ID is also removed a second time when old is destroyed, because
rxrpc_kill_client_conn() calls rxrpc_put_client_connection_id(local, conn)
again. If idr_alloc_cyclic() has given that ID to a new connection in the
meantime, could this remove the new connection's entry?

Dropping the extra rxrpc_put_connection() would not fix this part. It
looks like old's CID needs to stay published until old is destroyed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923041022.25845-1-eadavis%40sina.com
