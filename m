Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E03AC0EE
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520832; cv=none; b=sfr62Nh5i7FpZs7GhZB+79+LjQiuhama/TKkbuPEHpDt5wWS5CxjK8n77TQaL7hob9+bsXqCJEa6R+q34Ke/PJlWj9TmLPQYhQ3l1oXIeUSV6a8JZ9R9LrGIPM33Pp7dRyWMD1xAcZPE3SqSExj+JLFxILCscfRuz/Xqqfklz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520832; c=relaxed/simple;
	bh=d5TPrcYXBcaT1XmTAR1sfpFkwmlSbZ2j7gVL5qvMd6g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2Xp1IYxHHbkewZLjk+eYlxqTWG72uBMu/2Kdgo9b6q70jo/Q9pwenj01UIlpSQlPE2STOra55B71XmPPXX3agF5NdoWGWx2OXTy1wKmemlp4dRxbeaoLwWhm/6GvhFqnU1qaH+aW+SkjLJCFcUB5qCNLznh36yNuiJcJLBZjRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1tkJwUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1tkJwUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256EE1F00A3D;
	Fri,  4 Sep 2026 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520830;
	bh=bH4fdtvK8QkDW9qvIac1TzbUF2evES/9KmrOPMYyqCQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e1tkJwUEaRTs27/rTFwokW9H+UEzXCaEAf+dQo6QaR2hTdUm14+SFh0pF9cnzJnfW
	 b84hrRgU0QmjRmVP7/a5jqRKwKyDmW6jmZbJr4ErVK/s5hUBXW60FrYJmhQoFnuiyJ
	 ZgbNOicDN3rmqfSUfsqX2OThzYUBYSeJvB+zsbuvRVXQKmoLqxd7UdZxp7Y/dAF5JN
	 tPzBQU02JnVk+pKHcvwhxe9zgaiBNgdWcdX7Q7iLzNZtiroIMV3XBc8WIzsYlbVbkp
	 MeRMg4ua6HfG0md4MAqF2HR9dkdGbxl3BSNGUA2Zfvwokba/88sPPcexy5Xt6gkHGb
	 bCGDTMXOxqZjQ==
Subject: Re: [PATCH net v2] tipc: purge cong_links under the socket lock in
 tipc_release()
From: netdev-bot+sashiko@kernel.org
To: juny24602@gmail.com
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, tung.quang.nguyen@est.tech,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ying.xue@windriver.com,
 parthasarathy.bhuvaragan@ericsson.com, tipc-discussion@lists.sourceforge.net,
 junvyyang@tencent.com, stable@kernel.org, corvus@tencent.com
Date: Fri, 04 Sep 2026 11:20:29 +0000
Message-ID: <178852082966.4131868.2059053307125687464@kernel.org>
In-Reply-To: <20260902111847.79955-1-juny24602@gmail.com>
References: <20260902111847.79955-1-juny24602@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix: the commit message's central invariant — "Every
  other accessor of that list runs under the socket lock" — is factually…

--

tipc: purge cong_links under the socket lock in tipc_release()

This moves tipc_dest_list_purge(&tsk->cong_links) from after release_sock()
to before sock_orphan()/release_sock() in tipc_release(), so the purge runs
while the closing task owns the socket lock.  The stated goal is to exclude a
concurrent SOCK_WAKEUP handler that reaches tipc_dest_del() on the same list
via tipc_sk_rcv()'s spin_trylock_bh().

> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index d5d70eb230b56..cf7ee31638abf 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -647,10 +647,14 @@ static int tipc_release(struct socket *sock)
>  	sk_stop_timer(sk, &sk->sk_timer);
>  	tipc_sk_remove(tsk);
>  
> +	/* Purge under the socket lock: a SOCK_WAKEUP looked up before
> +	 * tipc_sk_remove() can still reach tipc_dest_del() on this list.
> +	 */
> +	tipc_dest_list_purge(&tsk->cong_links);
> +
>  	sock_orphan(sk);
>  	/* Reject any messages that accumulated in backlog queue */
>  	release_sock(sk);
> -	tipc_dest_list_purge(&tsk->cong_links);
>  	tsk->cong_link_cnt = 0;
>  	call_rcu(&tsk->rcu, tipc_sk_callback);
>  	sock->sk = NULL;

[Severity: High]
The commit message says:

  "Every other accessor of that list runs under the socket lock"

Is that accurate for tipc_sk_timeout()?  In net/tipc/socket.c it touches
cong_links after dropping the socket spinlock:

net/tipc/socket.c:tipc_sk_timeout() {
	...
	bh_unlock_sock(sk);

	if (!skb_queue_empty(&list))
		rc = tipc_node_xmit(sock_net(sk), &list, pnode, tsk->portid);

	/* SYN messages may cause link congestion */
	if (rc == -ELINKCONG) {
		tipc_dest_push(&tsk->cong_links, pnode, 0);
		tsk->cong_link_cnt = 1;
	}
	sock_put(sk);
}

Here neither lock_sock() ownership nor sk->sk_lock.slock is held, and
tipc_dest_push() walks the list with tipc_dest_find() and then list_add()s,
with no internal locking:

net/tipc/name_table.c:tipc_dest_push() {
	if (tipc_dest_find(l, node, port))
		return false;

	dst = kmalloc_obj(*dst, GFP_ATOMIC);
	...
	list_add(&dst->list, l);
}

Does sk_stop_timer() on the preceding line quiesce that path?  It is the
asynchronous variant:

net/core/sock.c:sk_stop_timer() {
	if (timer_delete(timer))
		__sock_put(sk);
}

timer_delete() does not wait for a callback that is already running, and the
timer callback holds its own socket reference, so a tipc_sk_timeout() already
past bh_unlock_sock() and inside tipc_node_xmit() keeps running.

So can this interleaving happen on a connecting/established socket?

CPU0 (timer)                          CPU1 (close)
tipc_sk_timeout()
  bh_lock_sock(sk)
  sock_owned_by_user() false
  tipc_sk_retry_connect()
  bh_unlock_sock(sk)
  tipc_node_xmit()  /* -ELINKCONG */
                                      lock_sock(sk)
                                      __tipc_shutdown()
                                      sk_stop_timer()  /* nothing pending */
                                      tipc_sk_remove()
                                      tipc_dest_list_purge(&tsk->cong_links)
  tipc_dest_push(&tsk->cong_links, ...)

If CPU0's tipc_dest_find() walk interleaves with the purge's
list_for_each_entry_safe { list_del; kfree; }, does this reproduce the same
slab-use-after-free / __list_del_entry_valid_or_report signature quoted in the
changelog, only reached through the timer accessor instead of the SOCK_WAKEUP
accessor?

And if the push lands strictly after the purge, what frees that entry?
tipc_release() has no second purge after this change, tipc_sk_callback() only
does sock_put(), and tipc_sock_destruct() purges only sk_receive_queue:

net/tipc/socket.c:tipc_sk_callback() {
	sock_put(&tsk->sk);
}

net/tipc/socket.c:tipc_sock_destruct() {
	__skb_queue_purge(&sk->sk_receive_queue);
}

Does that leak the 32-byte struct tipc_dest and leave tsk->cong_link_cnt = 0
disagreeing with a still-populated list head that is freed with tsk?  The
unlocked tsk->cong_link_cnt = 1 in tipc_sk_timeout() also races the unlocked
reset after release_sock().

The unlocked timer accessor is not introduced here, but moving the purge
earlier widens the post-purge interval by sock_orphan() plus the
release_sock() backlog drain, and the safety argument rests on an invariant
this path does not satisfy.

Would it make sense either to do the timer's tipc_node_xmit() /
tipc_dest_push() / cong_link_cnt accounting under the socket lock, or to
quiesce the timer with a synchronous cancellation before purging?  Failing
that, could the changelog and the new comment be narrowed so they do not claim
every other accessor is serialised by the socket lock?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902111847.79955-1-juny24602%40gmail.com
