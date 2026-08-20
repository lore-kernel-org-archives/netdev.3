Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861F35F60E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257968; cv=none; b=a9k2XKwUEMYIxkJctWXfzuCkzos577AFqn+ZAdwGpEC9mW4uK5AEw9Q6dWq31zj0UALeM6cM61zP/8YlPjEjqlduBcwbpMZ/7WiiOv8ifqM1BV54NXR2Ncf9UlhrriUKhUZZj1I6xZefQDfM+U26elbl+0LkaB/zP8XsBSX0TSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257968; c=relaxed/simple;
	bh=JPGV17Xs4psUnxUy9zmTLwY4640z5qx9E8ct+hVpS1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1Dy+iuZmsBsZiMz1DzN9/Uv0Pj8QEs5lbkHokbRmnbPhYshc1CWkGkhg8vUT5DQCa15LWE5fjkoPkvqAGg1RddZFzkDdVUEN7ER3b7JNFksJHz87va41ggtkeqjrBtRDolLw1nMFWu5x2ai9ufnnRdf46c/cBxWm7yM0eIgJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXaUvI7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXaUvI7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29E91F000E9;
	Thu, 20 Aug 2026 20:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257963;
	bh=sFvRKGUchgRYUoJMAjeF9RU+FvOzVYNdY1QV0ujTga0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KXaUvI7Jz8J01DgjFMKYhZ925O9PBA7/bas/a/5BCF5A7S0RbfLX6N9QO2Smwee2q
	 LlTZOBb9oYCU/eU8lzLpzrTZZubQFgWRYKrH1jfVJOUn5vxkIgjy5J7tX/gH7o7nsD
	 XEsIW+0Hp5Hw6nTAbb8y2efnRfKfgYm05kWdkgJn7Tk+069rrRozqt5tASrg4/oun/
	 LZBGp4E5GEB+8gYWHprWSiRw94+Di9bJgfK2jTb5X4RsOLeZLXCKJ4fCX/R3kEFN+J
	 DIgI9T85D/0pTvg8CcVAR2pKPE6JtiIhzPVRYfb4ZMoBjRHaD5P4s4yvuPJe31RDIU
	 E/g+BUWvCZjIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: zihanx@nebusec.ai
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	leitao@debian.org,
	tim.bird@sony.com,
	shuangpeng.kernel@gmail.com,
	ernestas.k@iconn-networks.com,
	luoxuanqiang@kylinos.cn,
	vega@nebusec.ai
Subject: Re: [PATCH net v4 1/1] llc: fix listener child socket leaks before passive open completes
Date: Thu, 20 Aug 2026 13:32:42 -0700
Message-ID: <20260820203242.1134165-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814185843.4748-2-zihanx@nebusec.ai>
References: <20260814185843.4748-2-zihanx@nebusec.ai>
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

This changes llc_conn_handler() so that a child socket is only created for
SABME commands, answers the other listener-side cases with a directly built
DM response, and adds an atomic incoming-child lifecycle so unaccepted
children are released on direct, backlog and listener-close failures.  The
final child teardown is deferred to a work item so timers can be stopped
synchronously in process context.

A few questions below.

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index b0447c33dbf09..837b8e0348637 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -206,6 +207,9 @@ static int llc_ui_release(struct socket *sock)
>  		llc->laddr.lsap, llc->daddr.lsap);
>  	if (!llc_send_disc(sk))
>  		llc_ui_wait_for_disc(sk, READ_ONCE(sk->sk_rcvtimeo));
> +	listener = sk->sk_state == TCP_LISTEN;
> +	if (listener)
> +		sock_set_flag(sk, SOCK_DEAD);

[Severity: High]
This isn't a leak introduced by this patch, since unaccepted children leaked
in every case before it, but does this branch leave one reachable case
unfixed?

The cleanup is gated on the socket's current sk_state, so a socket that was
a listener but has since left TCP_LISTEN skips both llc_release_incoming_children()
calls.

llc_ui_listen() leaves sock->state as SS_UNCONNECTED, and llc_ui_connect()
rejects only addrlen, family, sk_type and sock->state == SS_CONNECTING:

net/llc/af_llc.c:llc_ui_connect() {
	...
	rc = -EALREADY;
	if (unlikely(sock->state == SS_CONNECTING))
		goto out;
	...
	sock->state = SS_CONNECTING;
	sk->sk_state   = TCP_SYN_SENT;
}

So connect() on a listening socket that already has an LLC_INCOMING_QUEUED
indication on its receive queue is allowed and moves sk_state away from
TCP_LISTEN.  llc_ui_accept() then refuses to consume the indication because
it requires sk_state == TCP_LISTEN, and at close time listener is false.

llc_sk_free() only does skb_queue_purge(&sk->sk_receive_queue), which frees
the indication skb but never calls llc_release_incoming_sock() for the child
it referenced.  Does the child then stay in the SAP tables forever, holding
the dev_hold() reference taken in llc_create_incoming_sock() (blocking
netdev unregistration) and the new sock_hold() on the closed listener?

>  	if (!sock_flag(sk, SOCK_ZAPPED)) {
>  		struct llc_sap *sap = llc->sap;
>  
> @@ -214,16 +218,20 @@ static int llc_ui_release(struct socket *sock)
>  		 */
>  		llc_sap_hold(sap);
>  		llc_sap_remove_socket(llc->sap, sk);
> +		if (listener)
> +			llc_release_incoming_children(sk);
>  		release_sock(sk);
>  		llc_sap_put(sap);
>  	} else {
> +		if (listener)
> +			llc_release_incoming_children(sk);
>  		release_sock(sk);
>  	}

[Severity: High]
Is it safe to call llc_release_incoming_children() here with softirqs
enabled?  This path holds only lock_sock(sk), and lock_sock_nested() ends
with spin_unlock_bh(), so softirqs are on.  llc_release_incoming_children()
then takes the child's slock with a plain spin_lock():

net/llc/llc_conn.c:llc_release_incoming_children() {
	...
		if (newsk != sk)
			bh_lock_sock_nested(newsk);
	...
}

The same slock is taken from softirq context by the receive path and by the
LLC timer callbacks:

net/llc/llc_c_ac.c:llc_conn_tmr_common_cb() {
	...
	bh_lock_sock(sk);
	...
}

While that child lock is held the child is still published in the SAP hash
(llc_sap_remove_socket() only runs later inside llc_release_incoming_sock())
and llc_estab_match() still matches it, so can a NET_RX softirq on the same
CPU look up that child and spin on the held lock?

The window is even opened from inside the critical section:
llc_release_incoming_sock() -> llc_sap_remove_socket() does
spin_unlock_bh(&sap->sk_lock), whose local_bh_enable() runs pending softirqs
while the child's plain spin_lock is still held:

llc_ui_release()
  llc_release_incoming_children()
    bh_lock_sock_nested(child)
      llc_release_incoming_sock(child)
        llc_sap_remove_socket()
          spin_unlock_bh(&sap->sk_lock)   /* runs softirqs */
            llc_rcv() -> llc_conn_handler() -> bh_lock_sock(child)

Elsewhere LLC wraps such acquisitions in local_bh_disable(), for example
llc_lookup_established().  Would a lockdep inconsistent softirq-on /
in-softirq usage report also fire here on CONFIG_PROVE_LOCKING?

[ ... ]

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 260460d50f54c..bc05a5f66f95f 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -354,7 +360,8 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
>  	struct llc_sock *llc = llc_sk(sk);
>  	int rc = 1;
>  
> -	if (llc->state > NBR_CONN_STATES)
> +	if (llc->state < LLC_CONN_STATE_ADM ||
> +	    llc->state > NBR_CONN_STATES)
>  		goto out;

[Severity: Medium]
This isn't a bug introduced by this patch, but could this hunk be split out
with its own changelog?  The added lower bound looks like it fixes a
distinct, remotely reachable out-of-bounds access that the commit message
does not mention.

Without it, llc_qualify_conn_ev() indexes element -1 when llc->state is
LLC_CONN_OUT_OF_SVC (0) and then calls function pointers read from there:

net/llc/llc_conn.c:llc_qualify_conn_ev() {
	struct llc_conn_state *curr_state =
					&llc_conn_state_table[llc->state - 1];
	...
}

State 0 is reachable from a received frame, since llc_adm_state_trans_5 has:

net/llc/llc_c_st.c
static const struct llc_conn_state_trans llc_adm_state_trans_5 = {
	.ev	       = llc_conn_ev_rx_any_frame,
	.next_state    = LLC_CONN_OUT_OF_SVC,
	...
};

and llc_estab_match() does not filter on llc->state, so the socket keeps
being returned by __llc_lookup() for subsequent frames.  As written, a
stable backporter has no indication that a memory-safety fix is included
here.

[ ... ]

> +void llc_release_incoming_children(struct sock *sk)
> +{
> +	struct sk_buff *skb;
> +
> +	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> +		struct sock *newsk = skb->sk;
> +
> +		if (newsk != sk)
> +			bh_lock_sock_nested(newsk);
> +		if (newsk != sk) {
> +			llc_release_incoming_sock(newsk);
> +			kfree_skb(skb);
> +			bh_unlock_sock(newsk);
> +		} else {
> +			kfree_skb(skb);
> +		}
> +	}
> +}

[ ... ]

> @@ -795,10 +921,25 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	bh_lock_sock(sk);
> +	if (unlikely(sock_flag(sk, SOCK_DEAD)))
> +		goto drop_unlock;

[Severity: Medium]
Is this test too broad?  llc_ui_release() only sets SOCK_DEAD when the
socket is in TCP_LISTEN, but this check runs right after __llc_lookup() and
so applies to every socket the lookup returns.

Existing code already sets SOCK_DEAD on ordinary established stream sockets
when the peer disconnects:

net/llc/llc_conn.c:llc_conn_state_process() {
	case LLC_DISC_PRIM:
		...
		if (sk->sk_type == SOCK_STREAM &&
		    sk->sk_state == TCP_ESTABLISHED) {
			...
			if (!sock_flag(sk, SOCK_DEAD)) {
				sock_set_flag(sk, SOCK_DEAD);
				sk->sk_state_change(sk);
			}
		}
}

At that point the socket is still published in the SAP tables, because
llc_sap_remove_socket() only runs from llc_ui_release(), and
llc_estab_match() still matches it.  After such a peer-initiated disconnect,
are all further frames for that tuple now silently dropped instead of
running the ADM-state transitions that answer retransmitted DISC and other
commands with DM responses (llc_adm_state_trans_3 and
llc_adm_state_trans_4)?  That is the same protocol behaviour this patch
open-codes for listeners in llc_conn_send_dm_rsp().

Would distinguishing the listener case, for instance testing
sk->sk_state == TCP_LISTEN together with SOCK_DEAD, or using a dedicated
flag, be closer to the intent?

> +	if (newsk_lookup_ref) {
> +		bh_lock_sock_nested(newsk);
> +		newsk_locked = true;
> +		if (atomic_read(&llc_sk(newsk)->incoming_state) !=
> +		    LLC_INCOMING_PENDING)
> +			goto retry_unlock;
> +	}
>  	/*
>  	 * This has to be done here and not at the upper layer ->accept
>  	 * method because of the way the PROCOM state machine works:
> @@ -795,10 +921,25 @@ void llc_conn_handler(struct llc_sap *sap, struct sk_buff *skb)
>  	 * in the newly created struct sock private area. -acme
>  	 */
>  	if (unlikely(sk->sk_state == TCP_LISTEN)) {

[Severity: Medium]
When the lookup returned an LLC_INCOMING_PENDING child, sk was re-pointed at
the child's incoming_listener and only SOCK_DEAD was validated afterwards.
What happens if that socket is no longer TCP_LISTEN?

This condition is then false and control falls into the non-listener else
branch:

	} else {
		skb_orphan(skb);
		sock_hold(sk);
		skb->sk = sk;
		skb->destructor = sock_efree;
	}

so the child's PDU is fed into the ex-listener's own connection state
machine, since llc_conn_state_process() runs llc_conn_service(skb->sk, skb).
The backlog path guards exactly this case:

net/llc/llc_conn.c:llc_backlog_rcv() {
	...
			if (sock_flag(sk, SOCK_DEAD) ||
			    sk->sk_state != TCP_LISTEN)
				goto out_unlock_newsk;
	...
}

Reachability looks similar to the llc_ui_release() case above: connect() on
a listening socket is permitted and sets sk_state to TCP_SYN_SENT under
lock_sock(), a SABME that arrived while the lock was owned leaves a PENDING
child, and a second frame for that tuple arriving before release_sock()
drains the backlog takes the redirect path with sk_state == TCP_SYN_SENT.
Can a frame from peer A then drive the state machine of a socket that is
connecting to peer B, while the PENDING child is torn down by
llc_release_incoming_sock() without its frame ever being processed for it?

[ ... ]

> @@ -852,12 +1013,38 @@ static int llc_backlog_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	int rc = 0;
>  	struct llc_sock *llc = llc_sk(sk);
> +	struct sock *newsk = NULL;
>  
>  	if (likely(llc_backlog_type(skb) == LLC_PACKET)) {
> -		if (likely(llc->state > 1)) /* not closed */
> +		newsk = skb->sk;
> +		if (newsk &&
> +		    atomic_read(&llc_sk(newsk)->incoming_state) ==
> +		    LLC_INCOMING_PENDING) {
> +			bh_lock_sock_nested(newsk);

[Severity: High]
Same locking question as in llc_release_incoming_children(): this handler
runs from release_sock() -> __release_sock(), which drops the parent slock
with spin_unlock_bh() and even calls cond_resched() in that loop:

net/core/sock.c:__release_sock() {
		spin_unlock_bh(&sk->sk_lock.slock);
		while (1) {
			...
			sk_backlog_rcv(sk, skb);
	...
}

so softirqs are enabled here too.  Can these bh_lock_sock_nested() and
bh_lock_sock() acquisitions on the child (also in the retry,
out_unlock_newsk and out_kfree_skb paths) deadlock against the same lock
taken from llc_rcv() -> llc_conn_handler() or from the LLC timer callbacks
on the same CPU?  The child slock is additionally held across a full
llc_conn_rcv() state-machine run, including dev_queue_xmit().

> +			if (atomic_read(&llc_sk(newsk)->incoming_state) !=
> +			    LLC_INCOMING_PENDING) {
> +				bh_unlock_sock(newsk);
> +				goto retry;
> +			}
> +			if (sock_flag(sk, SOCK_DEAD) ||
> +			    sk->sk_state != TCP_LISTEN)
> +				goto out_unlock_newsk;
>  			rc = llc_conn_rcv(sk, skb);
> -		else
> +			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			    LLC_INCOMING_PENDING)
> +				llc_release_incoming_sock(newsk);
> +			bh_unlock_sock(newsk);
> +		} else if (newsk &&
> +			   atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			   LLC_INCOMING_QUEUED) {
> +			bh_lock_sock(newsk);
> +			rc = llc_conn_rcv(newsk, skb);
> +			bh_unlock_sock(newsk);
> +		} else if (likely(llc->state > 1)) {
> +			rc = llc_conn_rcv(sk, skb);
> +		} else {
>  			goto out_kfree_skb;
> +		}

[Severity: Medium]
The new QUEUED branch dispatches into llc_conn_rcv(newsk, skb) with no
closed-state filter, while the surviving else-if branch still keeps the
llc->state > 1 test.  Combined with the new lower bound in
llc_conn_service(), does a frame for a child left in LLC_CONN_OUT_OF_SVC now
produce one unratelimited log line per frame?

llc_conn_service() returns 1 for state below LLC_CONN_STATE_ADM, and
llc_conn_state_process() prints unconditionally:

net/llc/llc_conn.c:llc_conn_state_process() {
	rc = llc_conn_service(skb->sk, skb);
	if (unlikely(rc != 0)) {
		printk(KERN_ERR "%s: llc_conn_service failed\n", __func__);
		goto out_skb_put;
	}
	...
}

State 0 looks remotely reachable: a child back in ADM (NORMAL plus rx DISC)
that then receives any frame that is neither SABME, DISC nor a command with
P=1 hits llc_adm_state_trans_5 with .next_state = LLC_CONN_OUT_OF_SVC and a
no-op action, while it is still hashed in the SAP table and matched by
llc_estab_match().  Every further frame for that tuple would then reach this
branch, and the direct llc_conn_rcv() path in llc_conn_handler(), and emit
another KERN_ERR line.  Would filtering the closed state in these new
branches be preferable to letting llc_conn_service() fail?

[ ... ]
-- 
pw-bot: cr
