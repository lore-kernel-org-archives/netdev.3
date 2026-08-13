Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CD919A288
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580362; cv=none; b=ZQ0tkHEGfHoN55XqVGvZRVwJBlI38NQDqm4BrPnsB1sAxUJUwA1sMvg65qEp0BgeEgMsQ6T0HcO2C7Sqpqkm/jRldrM3YliyRa9S1m6v/OtPBsXsBfuVKPvdvQyDUTzYEh5T+VjHFkmCg4DSEDCcMpZN2YgavWygTCoEeTXgmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580362; c=relaxed/simple;
	bh=IdhzBWlX0Utt5QDWP0sYGzvSWdS9Yg6sZD1Y+NxZKuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bk5FHCOUmwU376eu0nBrcDatVHEl+n/V9dsxNartjWYFY2I4/IzWbBhWuouyC5mcwWRd8G7NovQHmWvj4XOmlHL6oTgyjTEW6nghGi6fiFpB2L3Pfgldh4PCYmhd1TwnVmIAxL302AgqU+EQXwJfgCjCn05pRSnZmXY2tsdD+T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+g1o9Nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+g1o9Nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA81F000E9;
	Thu, 13 Aug 2026 00:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580360;
	bh=ankgcdYwyEwEvHw6XaPmmG+oy7mnkoHWvoacLTaqM+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+g1o9Nc0rIZZHO5p4nUjbIgXJeDTXAlQO95zriBCFy6m5Z8V2luL+S3X3jNGC/Wa
	 Xn02lsC/bLUgo681X6tTn1G+0kJqonOSNmRmSRFxcLAOgyBFwSPR3kem/98ep6uaFV
	 06wlrR15ZXS/xIt5T0DiIN7JdZu2Em5rbBVMz7Kci0dxYeglLIYubnd86kNTM0IdDd
	 U0R8d6BVRv6zH1wONMB66BhHv/YuZsV7cybSqkzIe2iwBJNjkklFElRetXVnsvzN9J
	 NPDCm8X7717fOokMNA04IGS9nuu/s6tcMoH1sFb6ZAMa+ZnjocrT4aoLc8L/rZVD7v
	 tj4TjV7sBJeQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: zihanx@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	tim.bird@sony.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] llc: fix listener child socket leaks before passive open completes
Date: Wed, 12 Aug 2026 17:19:18 -0700
Message-ID: <20260813001918.2236878-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805175945.10698-2-zihanx@nebusec.ai>
References: <20260805175945.10698-2-zihanx@nebusec.ai>
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
llc: fix listener child socket leaks before passive open completes

This adds a new llc_sock::incoming_pend flag plus an skb->cb bit so that a
passive-open child created by llc_conn_handler() can be rolled back out of
the SAP tables when the listener path exits before LLC_CONN_PRIM is emitted.
Rollback is done by a new helper, llc_release_incoming_sock(), called from
llc_conn_handler() and llc_backlog_rcv().

A few questions on the locking and on the paths the flag covers.

> diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
> index e1a3026967234..ba40194899fda 100644
> --- a/include/net/llc_conn.h
> +++ b/include/net/llc_conn.h
> @@ -72,6 +72,7 @@ struct llc_sock {
>  					      received and caused sending FRMR.
>  					      Used for resending FRMR */
>  	u32		    cmsg_flags;
> +	u8		    incoming_pend;
>  	struct hlist_node   dev_hash_node;
>  };

[Severity: Medium]
Which lock is meant to protect incoming_pend?

llc_create_incoming_sock() and llc_release_incoming_sock() write it under
bh_lock_sock() of the listener, but llc_conn_state_process() writes it on
whatever socket the skb belongs to:

	llc_sk(skb->sk)->incoming_pend = 0;

For a frame matched by __llc_lookup_established() that socket is the child,
and the caller holds the child's lock, not the listener's.

The readers in llc_conn_handler() and llc_backlog_rcv() hold (or own) only
the listener lock, so the set of locks common to all accesses is empty.
Is a plain u8 without READ_ONCE()/WRITE_ONCE() intended here, and is the

	if (newsk && llc_sk(newsk)->incoming_pend)
		llc_release_incoming_sock(newsk);

check-then-destroy sequence expected to be atomic with respect to the
clearing site?

[ ... ]

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..d2913b2164cd8 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -88,6 +89,7 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  		 * skb->sk pointing to the newly created struct sock in
>  		 * llc_conn_handler. -acme
>  		 */
> +		llc_sk(skb->sk)->incoming_pend = 0;
>  		skb_get(skb);
>  		skb_queue_tail(&sk->sk_receive_queue, skb);
>  		sk->sk_state_change(sk);

[Severity: High]
Can this clear the flag on a child that no accept() will ever see, and so
defeat every rollback path the patch adds?

The child is hash-published by llc_create_incoming_sock() before the
handshake finishes, and __llc_lookup() prefers the established socket:

net/llc/llc_conn.c:__llc_lookup() {
	struct sock *sk = __llc_lookup_established(sap, daddr, laddr, net);

	return sk ? : llc_lookup_listener(sap, laddr, net);
}

So a second frame for the same address pair is delivered with sk == the
child. The child's sk_state is TCP_CLOSE, so llc_conn_handler() takes the
else branch, newsk stays NULL, and no rollback check runs for that call.
The child is in LLC_CONN_STATE_ADM, so a SABME hits llc_adm_state_trans_2,
whose action list contains llc_conn_ac_conn_ind, giving ind_prim ==
LLC_CONN_PRIM with sk == skb->sk == child:

	llc_sk(skb->sk)->incoming_pend = 0;
	skb_get(skb);
	skb_queue_tail(&sk->sk_receive_queue, skb);

The indication is queued on the child's own receive queue, not on a
listener's, yet incoming_pend is now 0.

When the listener's backlog is drained afterwards, a listener's llc->state
is LLC_CONN_STATE_ADM == 1 (llc_ui_listen() never changes llc->state), so
llc_backlog_rcv() takes out_kfree_skb, and the new rollback there is skipped
because incoming_pend is already 0. The child then stays in
sap->sk_laddr_hash / sk_dev_hash with the dev_hold() taken by
llc_create_incoming_sock(), keeps answering the peer, and is unreachable
from accept().

Would restricting the clear to the case where the indication really goes to
a different (listening) socket, e.g. only when sk != skb->sk, close this?

[Severity: High]
This isn't a bug introduced by this patch, but the flag is cleared the
instant LLC_CONN_PRIM is emitted, which is before accept() has taken
ownership of the child, and from that point llc_release_incoming_sock()
returns immediately:

	if (!llc->incoming_pend)
		return;

If userspace never calls accept() and just closes the listener,
llc_ui_release() unhashes and frees only the listener. The child is reached
only through the queued skb, and llc_sk_free() does:

	skb_queue_purge(&sk->sk_receive_queue);

which runs each skb's sock_rfree destructor (installed by skb_set_owner_r()
in llc_conn_handler()). That un-charges rmem, but never does sock_put() on
skb->sk, never calls llc_sap_remove_socket(), and never drops the dev_hold()
from llc_create_incoming_sock(). There is no netdevice notifier or other
sweeper in net/llc/, so the child stays hashed with a permanent netdev
reference.

Given the subject "llc: fix listener child socket leaks before passive open
completes" and Cc: stable, could the commit message state that the
listen/SABME/close-without-accept case is still left as is?

[ ... ]

> @@ -765,16 +767,32 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
>  	memcpy(&newllc->laddr, daddr, sizeof(newllc->laddr));
>  	memcpy(&newllc->daddr, saddr, sizeof(newllc->daddr));
>  	newllc->dev = dev;
> +	newllc->incoming_pend = 1;
>  	dev_hold(dev);
>  	llc_sap_add_socket(llc->sap, newsk);
>  out:
>  	return newsk;
>  }
>  
> +static void llc_release_incoming_sock(struct sock *sk)
> +{
> +	struct llc_sock *llc = llc_sk(sk);
> +
> +	if (!llc->incoming_pend)
> +		return;
> +
> +	llc->incoming_pend = 0;
> +	llc_sap_remove_socket(llc->sap, sk);
> +	dev_put(llc->dev);
> +	sock_orphan(sk);
> +	llc_sk_free(sk);
> +}

[Severity: High]
Is any lock held on the socket being destroyed here?

The callers hold bh_lock_sock() of the listener, but the child was already
made globally visible by llc_sap_add_socket():

net/llc/llc_conn.c:llc_sap_add_socket() {
	sock_set_flag(sk, SOCK_RCU_FREE);
	sap->sk_count++;
	sk_nulls_add_node_rcu(sk, laddr_hb);
	hlist_add_head(&llc->dev_hash_node, dev_hb);
}

so another CPU can find it in __llc_lookup_established():

		if (unlikely(!refcount_inc_not_zero(&rc->sk_refcnt)))
			goto again;

and then run llc_conn_rcv(child, skb) under bh_lock_sock(child), which is a
lock this path does not take:

CPU0 (softirq, frame A, listener branch)
llc_conn_handler()
  bh_lock_sock(listener)
  llc_create_incoming_sock()      /* child published */
  llc_conn_rcv(listener, skbA)    /* no LLC_CONN_PRIM */
  llc_release_incoming_sock(child)
    llc_sap_remove_socket()
    dev_put(llc->dev)
    sock_orphan(child)
    llc_sk_free(child)            /* stops timers, purges queues, sock_put */

CPU1 (softirq, frame B, same address pair)
llc_conn_handler()
  __llc_lookup_established() -> child
  bh_lock_sock(child)
  llc_conn_rcv(child, skbB)       /* mod_timer(), tx using llc->dev, ... */

Can CPU1's state-machine actions re-arm the child's timers with mod_timer()
after CPU0's llc_sk_stop_all_timers(child, true) has already returned? The
timers hold no socket reference, so once CPU1 drops its lookup reference the
sock is freed with a timer still armed.

Similarly, dev_put(llc->dev) does not clear llc->dev, so CPU1's transmit
actions keep using it after the reference was dropped, and sock_orphan()
clears sk_socket while llc_conn_state_process() dereferences
sk->sk_socket->state.

Compare llc_ui_release(), which holds lock_sock() of the socket it destroys
across llc_sap_remove_socket()/netdev_put()/llc_sk_free().

[Severity: High]
Is llc_sk_free() safe to call from here?

llc_sk_free() hardcodes the synchronous variant:

net/llc/llc_conn.c:llc_sk_free() {
	llc->state = LLC_CONN_OUT_OF_SVC;
	llc_sk_stop_all_timers(sk, true);

which expands to four timer_delete_sync() calls. Both new call sites run in
NET_RX softirq with the listener's bh_lock_sock(sk) (sk->sk_lock.slock)
held, and the LLC timers are set up with flags == 0 in llc_sk_init(), so
they are not TIMER_IRQSAFE. timer_delete_sync()'s comment says the caller
must not hold locks that are held in interrupt context, even unrelated ones.

sk_lock.slock is exactly such a lock, taken from softirq by the timer
callbacks themselves:

net/llc/llc_c_ac.c:llc_conn_tmr_common_cb() {
	bh_lock_sock(sk);

__timer_delete_sync() does lock_map_acquire(&timer->lockdep_map)
unconditionally, before checking whether the timer is pending, so on
CONFIG_PROVE_LOCKING this records slock-AF_LLC -> timer lockdep_map, while
call_timer_fn() plus llc_conn_tmr_common_cb() records the reverse edge.

The existing BH-context helper uses the async variant:

net/llc/llc_c_ac.c:llc_conn_ac_stop_all_timers() {
	llc_sk_stop_all_timers(sk, false);

Before this patch llc_sk_free() had a single caller, llc_ui_release(), in
process context. Should the rollback path use the sync == false form, or
defer the free?

[ ... ]

> @@ -812,14 +830,22 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  		sock_hold(sk);
>  		skb->sk = sk;
>  		skb->destructor = sock_efree;
> +		llc_set_incoming_flag(skb, false);
>  	}
> -	if (!sock_owned_by_user(sk))
> +	if (!sock_owned_by_user(sk)) {
>  		llc_conn_rcv(sk, skb);
> -	else {
> +		if (newsk && llc_sk(newsk)->incoming_pend)
> +			llc_release_incoming_sock(newsk);
> +	} else {
>  		dprintk("%s: adding to backlog...\n", __func__);
>  		llc_set_backlog_type(skb, LLC_PACKET);
> -		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
> +		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf))) {
> +			if (newsk) {
> +				skb_orphan(skb);
> +				llc_release_incoming_sock(newsk);
> +			}
>  			goto drop_unlock;
> +		}
>  	}
>  out:
>  	bh_unlock_sock(sk);

[ ... ]

> @@ -868,10 +895,14 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  		printk(KERN_ERR "%s: invalid skb in backlog\n", __func__);
>  		goto out_kfree_skb;
>  	}
> +	if (newsk && llc_sk(newsk)->incoming_pend)
> +		llc_release_incoming_sock(newsk);
>  out:
>  	return rc;
>  out_kfree_skb:
>  	kfree_skb(skb);
> +	if (newsk && llc_sk(newsk)->incoming_pend)
> +		llc_release_incoming_sock(newsk);
>  	goto out;
>  }
-- 
pw-bot: cr
