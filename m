Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318833F105B;
	Wed, 23 Sep 2026 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199401; cv=none; b=iwYnxx97g8IByCkTVRPGtOpXv63jOC7t42eGik5c7Hwh+7Svn5pw5I7/cxnS66kVBuTlopFL0kWli9B6HdAV+SwbTzpUeudO2YLyddGcqc5M+M2TgMx6pvh3danJHEYko6jNmW1EfjMd0C/C1ebpHAlDbUW06ZNJfi9oipb8kb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199401; c=relaxed/simple;
	bh=pv6Tc52VfrjAPKcEUfEgWHyGdQeYhZqIc2dmopMEm1s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZ67PVgm6OZEQQkZPFstUFs30XKZYUEzxsjnLN/pmePdxzME7g824L1/zN+rWEr4fvQEfGuXJ/w+Iyt3up3M8O6GHOuo9emKsKHpjJJ30Q2RKPQIr3xPxfmBiBulRdc7OkHoXDLrMgdf2g+NmfL/FEHx7J+jYPCSoPWSUofqVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPnoU8TY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPnoU8TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF931F00893;
	Wed, 23 Sep 2026 21:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790199399;
	bh=SJCZHr1Laf9ARp0PyW1Sbd8JGt4j8p2fLSSYinMrpdg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VPnoU8TYtrQmaRybOzdXw3pk1FzRY9loLyJIaesaAyEx3wiWQ2dHD/409lALSlPPX
	 MG2td+GHnhmt4gu0K8zuv1+2K4kkkU8Kxo4aTqCqLsjtxeLbXRN7SmH2Aec3X4MJDO
	 9ifH1o6ZSqF4+om4thHCVDA3BublxW3lkghlBjpCBjwByajh8oLMGjiB11MPKaELQ4
	 kKh1AtxuY7ciHZ9xrPSuV6Uu/fa/abhJdkRdCQ1orm1m59vEkJ4Sso0V0JERuAVA+b
	 ZLpBi3sJ1Ii9MN74hEYqbLbiWUFU80fKymPNcoMTDOS+gZ9PWULR6L6xxYqqq/mwez
	 YfV378lPrZF9w==
Subject:
 Re: [PATCH] net: llc: clean up unaccepted child sockets in llc_ui_release()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 21:36:38 +0000
Message-ID: <179019939874.2160803.14497903403458944686@kernel.org>
In-Reply-To: <20260919213635.3314344-1-benquike@gmail.com>
References: <20260919213635.3314344-1-benquike@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 1 · High: 3 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Type confusion in the new TCP_LISTEN drain loop in
  llc_ui_release(): the loop assumes every skb on sk->sk_receive_queue…
- [High] The drain of the listener's sk_receive_queue is placed at the
  very start of llc_ui_release() (net/llc/af_llc.c:207-225), before…
- [High] The new child teardown in llc_ui_release()
  (net/llc/af_llc.c:213-222) removes the child from the SAP hash, drops…
- [High] Incomplete fix: the new release-time drain can only reclaim
  children whose skb reached the listener's sk_receive_queue, i.e.…
- [Medium] Reference-tracker acquire/release mismatch: the new code
  releases the child's netdev reference with netdev_put(child_llc->dev,…
- [Low] The commit message cites a non-existent symbol: "llc_ui_release()
  calls skb_queue_purge(&sk->sk_receive_queue) in llc_sk_Component /…

--

net: llc: clean up unaccepted child sockets in llc_ui_release()

The patch adds a drain of the listener's sk_receive_queue at the top of
llc_ui_release() when sk_state is TCP_LISTEN.  For every queued skb it
takes skb->sk as an unaccepted child, removes it from its SAP, drops the
device reference and frees it with llc_sk_free().  A few questions about
the new block and the changelog below.

Commit message:

> If the listening socket is closed without calling `accept()`,
> `llc_ui_release()` calls `skb_queue_purge(&sk->sk_receive_queue)` in
> `llc_sk_Component` / `llc_sk_free()`, which frees the queued `skb`s

[Severity: Low]
Where does llc_sk_Component come from?  A grep for that string over the
tree at this commit returns nothing, and the only skb_queue_purge() of
sk->sk_receive_queue in net/llc is the one in llc_sk_free() in
net/llc/llc_conn.c.  Could the changelog name only the function that
actually exists?

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index b0447c33dbf0..4bc7839127aa 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -204,6 +204,25 @@ static int llc_ui_release(struct socket *sock)
>  	llc = llc_sk(sk);
>  	dprintk("%s: closing local(%02X) remote(%02X)\n", __func__,
>  		llc->laddr.lsap, llc->daddr.lsap);
> +	if (sk->sk_state == TCP_LISTEN) {
> +		struct sk_buff *skb;
> +
> +		while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
> +			struct sock *child = skb->sk;
> +
> +			if (child) {

[Severity: Critical]
Is every skb on a TCP_LISTEN socket's receive queue really a connection
indication carrying a child sock?  In llc_conn_state_process() the data
path queues the skb on the receiving socket itself:

net/llc/llc_conn.c:llc_conn_state_process() {
	case LLC_DATA_PRIM:
		skb_get(skb);
		llc_save_primitive(sk, skb, LLC_DATA_PRIM);
		if (unlikely(sock_queue_rcv_skb(sk, skb))) {
	...
}

so skb_set_owner_r() leaves skb->sk == sk.  Those skbs can still be on the
queue when the socket goes back to listening, because the DISC path only
does:

net/llc/llc_conn.c:llc_conn_state_process() {
	...
			sk->sk_socket->state  = SS_UNCONNECTED;
			sk->sk_state          = TCP_CLOSE;
	...
}

without purging the queue, and llc_ui_listen() accepts that state:

net/llc/af_llc.c:llc_ui_listen() {
	if (unlikely(sock->state != SS_UNCONNECTED))
		goto out;
	...
	if (sk->sk_state != TCP_LISTEN) {
		sk->sk_ack_backlog = 0;
		sk->sk_state	   = TCP_LISTEN;
	}
}

With child == sk, does this loop then tear down the listener itself, after
which the unchanged tail of llc_ui_release() repeats
llc_sap_remove_socket(llc->sap, sk), netdev_put(llc->dev,
&llc->dev_tracker), sock_put(sk) and llc_sk_free(sk) on the same socket?
The second llc_sap_remove_socket() reaches an unconditional hlist_del():

net/llc/llc_conn.c:llc_sap_remove_socket() {
	spin_lock_bh(&sap->sk_lock);
	sk_nulls_del_node_init_rcu(sk);
	hlist_del(&llc->dev_hash_node);
	sap->sk_count--;
	...
}

sk_nulls_del_node_init_rcu() is idempotent, but hlist_del() is not, so the
second pass writes through an already poisoned pprev.  Should the loop
skip skbs whose skb->sk == sk (or compare against the listener) before
doing any of this?

[Severity: High]
Can children that never reach this queue still leak?  llc_conn_handler()
creates the child before the frame is classified:

net/llc/llc_conn.c:llc_create_incoming_sock() {
	newllc->dev = dev;
	dev_hold(dev);
	llc_sap_add_socket(llc->sap, newsk);
	...
}

A fresh child is in LLC_CONN_STATE_ADM, and only the SABME transition runs
llc_conn_ac_conn_ind().  The DISC and catch-all transitions use
llc_conn_disc():

net/llc/llc_c_ac.c:llc_conn_disc() {
	/* FIXME: this thing seems to want to die */
	return 0;
}

so ev->ind_prim stays 0 and llc_conn_state_process() ends at:

net/llc/llc_conn.c:llc_conn_state_process() {
out_skb_put:
	kfree_skb(skb);
	return rc;
}

Since skb_set_owner_r() holds no sock reference, does the child stay in
sap->sk_laddr_hash with its dev_hold() forever, i.e. the same leak the
changelog describes, reachable from an inbound non-SABME frame without
ever closing the listener?

> +				struct llc_sock *child_llc = llc_sk(child);
> +
> +				skb_orphan(skb);
> +				if (child_llc->sap)
> +					llc_sap_remove_socket(child_llc->sap, child);
> +				netdev_put(child_llc->dev, &child_llc->dev_tracker);

[Severity: Medium]
Does the tracked release here match the acquire side?  The child's device
reference is taken with plain dev_hold() in llc_create_incoming_sock(),
and dev_hold() is netdev_hold(dev, NULL, GFP_ATOMIC), so
child_llc->dev_tracker is never populated and only dir->no_tracker is
incremented.  netdev_put() with a non-NULL trackerp whose value is NULL
lands here:

lib/ref_tracker.c:ref_tracker_free() {
	if (!trackerp) {
		refcount_dec(&dir->no_tracker);
		return 0;
	}
	tracker = *trackerp;
	if (!tracker) {
		refcount_dec(&dir->untracked);
		return -EEXIST;
	}
	...
}

With CONFIG_NET_DEV_REFCNT_TRACKER=y, does that decrement of dir->untracked
(which carries a bias of 1) produce a refcount_t underflow warning, and
leave no_tracker elevated so ref_tracker_dir_exit() warns at device
teardown?  llc_ui_autobind() shows the other convention:

net/llc/af_llc.c:llc_ui_autobind() {
	llc->dev = dev;
	netdev_tracker_alloc(llc->dev, &llc->dev_tracker, GFP_KERNEL);
	...
}

Would either using dev_put() here, or converting
llc_create_incoming_sock() to netdev_hold(dev, &newllc->dev_tracker,
GFP_ATOMIC), be the better pairing?

> +				sock_orphan(child);
> +				llc_sk_free(child);

[Severity: High]
Is anything serialising this teardown against the child's own receive
path?  The child is fully hashed by llc_sap_add_socket(), so a softirq can
find it and run its state machine under its own lock:

net/llc/llc_conn.c:llc_conn_handler() {
	sk = __llc_lookup(sap, &saddr, &daddr, dev_net(skb->dev));
	if (!sk)
		goto drop;

	bh_lock_sock(sk);
	...
	if (!sock_owned_by_user(sk))
		llc_conn_rcv(sk, skb);
	...
}

The listener's lock_sock() does not exclude that, and actions such as:

net/llc/llc_c_ac.c:llc_conn_ac_start_ack_timer() {
	mod_timer(&llc_sk(sk)->ack_timer.timer,
		  jiffies + llc_sk(sk)->ack_timer.expire);
	return 0;
}

can re-arm an embedded timer after llc_sk_free() -> llc_sk_stop_all_timers(sk,
true) has already done timer_delete_sync().  Can that leave an armed timer
on a sock whose last reference is dropped by the sock_put() at the end of
llc_sk_free(), and can llc_conn_send_pdus() use child_llc->dev after the
netdev_put() above?  TCP takes bh_lock_sock() plus a sock_hold() on each
child in inet_csk_listen_stop(); should something equivalent be done here?

> +			}
> +			kfree_skb(skb);
> +		}
> +	}
>  	if (!llc_send_disc(sk))
>  		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
>  	if (!sock_flag(sk, SOCK_ZAPPED)) {

[Severity: High]
Does draining here, before the listener is unhashed and before the backlog
is flushed, still leave the leak open?  llc_sap_remove_socket(llc->sap, sk)
and release_sock(sk) run only after this point, so while the socket lock is
held llc_conn_handler() can still find the listener, create a child and
then push the skb to the backlog:

net/llc/llc_conn.c:llc_conn_handler() {
	if (unlikely(sk->sk_state == TCP_LISTEN)) {
		struct sock *newsk = llc_create_incoming_sock(sk, skb->dev,
							      &saddr, &daddr);
		if (!newsk)
			goto drop_unlock;
		skb_set_owner_r(skb, newsk);
	}
	...
	if (!sock_owned_by_user(sk))
		llc_conn_rcv(sk, skb);
	else {
		llc_set_backlog_type(skb, LLC_PACKET);
		if (sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))
			goto drop_unlock;
	}
}

release_sock() then runs llc_backlog_rcv() on a listener whose llc->state is
LLC_CONN_STATE_ADM:

net/llc/llc_conn.c:llc_backlog_rcv() {
	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
		if (likely(llc->state > 1)) /* not closed */
			rc = llc_conn_rcv(sk, skb);
		else
			goto out_kfree_skb;
	...
}

so the skb is just freed and the freshly created child, its SAP reference
and its device reference are leaked again.  There also seems to be a second
window after release_sock(): a softirq that looked up the listener before it
was unhashed can queue another child-bearing skb on sk_receive_queue while
sk_state is still TCP_LISTEN, and llc_sk_free(sk) then purges it.  Would
performing this cleanup after the listener is unhashed and the backlog
flushed (or directly at the purge site) close both windows?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919213635.3314344-1-benquike%40gmail.com
