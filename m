Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090C2F7EE4;
	Sun, 20 Sep 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891090; cv=none; b=Ll65e0e72yBbhwMnnqJhvn5W/8oN15ebygXQL1rpJc2sktBppmhBuatPTfo6SYOvlcpeir6ozaof9CCSuy+kqTgB4lTZ2hVqPGVNBomczo/19TnYfOMa+UwFNnCDhxODkZMXoxCN3wvECy69uLs7QEg+61X9V8y/DjQFwOqvJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891090; c=relaxed/simple;
	bh=UT6inVBwynblFYlbe6CpL5/Iwkg9DDQnwCzVjcLcUUg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4FuVoMo6Wcb3VFIKcX3gll1eEvW3HkbuO0fkkOr8VFQv1PD8PfxMWp5OSJLAxeFeT5aqJlHaVJf58EX+JLHso8k/gCXZc5Y+Hy5jWTCM+nIgC6uoIEP0VeL5U2BeZbQTzeL2VG/lCQGDQFzrHh8Lllaiduh5WcWMbwGYsEy7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig8cVr94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig8cVr94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CBD1F000FF;
	Sun, 20 Sep 2026 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789891088;
	bh=0EyLD0n0lzgtuzYWbeAQDB6+6wN+W+bRt+Kx71uHc5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ig8cVr94HCorS9Duii1U3EczWF1NF4tJGbLzx8Wgm5QKePB+yqJjL99fDpBfUe6Yc
	 g1f7YeV3Nh10s+HoKs7TJungwkGMah97pi7oqYe+dP5qU7U6pGm/VHBLgGxh9N5UKO
	 AOxliqVbDoleJOw+mJTVLwckWN4ZhgEoXXKW+5H63GEs4pHguTvf9p1iABggp8hWui
	 mas8AJdFo9W5rL0qwbPD619CQ9nyNehodqcYF9fXmdmPptjnZAREqOHVD2iFI8cGYV
	 vD3+iwsxyTwAmjZZLl7mIRpQPMh+SDu/8l7uDPZ51MweCzdVxmmccpOGUl+hPWjq6F
	 PRFSRC0iFXAtA==
Subject: Re: [PATCH net] llc: stop connection timers before dropping sap ref
 on release
From: netdev-bot+sashiko@kernel.org
To: miguelgarciaroman8@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com
Date: Sun, 20 Sep 2026 07:58:07 +0000
Message-ID: <178989108743.2160803.13247969206014444151@kernel.org>
In-Reply-To: <20260916074158.3375909-1-miguelgarciaroman8@gmail.com>
References: <20260916074158.3375909-1-miguelgarciaroman8@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the new `llc_sk_stop_all_timers(sk, true)` in
  `llc_ui_release()` (net/llc/af_llc.c:225) cannot guarantee that no…
- [Low] The comment added by this patch (net/llc/af_llc.c:221-223) and
  the corresponding commit-message sentence ("timer_delete_sync() must…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  code the patch touches and is a hard out-of-bounds access:…

--

llc: stop connection timers before dropping sap ref on release

The patch adds a synchronous connection-timer cancel in llc_ui_release()
after release_sock() and before the final llc_sap_put(), so that the ack /
P / REJ / busy timers are stopped while the sap reference is still held.
It targets a syzbot slab-use-after-free of the RCU-freed llc_sap from the
timer softirq path.

Closes: https://syzkaller.appspot.com/bug?extid=44efda9647c52be29d9c

> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index b0447c33dbf09..4fc397fad4d2e 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -215,6 +215,14 @@ static int llc_ui_release(struct socket *sock)
>  		llc_sap_hold(sap);
>  		llc_sap_remove_socket(llc->sap, sk);
>  		release_sock(sk);
> +		/*
> +		 * Timers dereference llc->sap.  Cancel them while the sap is
> +		 * still held; llc_sk_free() runs after the final sap put and
> +		 * would otherwise race with kfree_rcu(sap).  Must run after
> +		 * release_sock() to avoid deadlock with bh_lock_sock() in the
> +		 * timer callbacks.
> +		 */

[Severity: Low]
This isn't a bug, but is the stated deadlock rationale accurate?  The same
claim appears in the changelog:

    timer_delete_sync() must not run under lock_sock() (timer callbacks take
    bh_lock_sock()), so stopping after release_sock() is required.

lock_sock() does not hold sk->sk_lock.slock across its critical section.
lock_sock_nested() in net/core/sock.c takes the slock only to set the
ownership flag and drops it again:

	spin_lock_bh(&sk->sk_lock.slock);
	if (unlikely(sock_owned_by_user_nocheck(sk)))
		__lock_sock(sk);
	sk->sk_lock.owned = 1;
	spin_unlock_bh(&sk->sk_lock.slock);

Since bh_lock_sock() is just spin_lock(&((__sk)->sk_lock.slock)), a timer
callback can take it while another thread owns the socket lock, and
llc_process_tmr_ev() then defers rather than blocking:

net/llc/llc_c_ac.c:llc_process_tmr_ev() {
	...
		if (!sock_owned_by_user(sk))
			llc_conn_state_process(sk, skb);
		else {
			llc_set_backlog_type(skb, LLC_EVENT);
			__sk_add_backlog(sk, skb);
		}
	...
}

So timer_delete_sync() under lock_sock() would not deadlock on
bh_lock_sock().  Placing the cancel after release_sock() still looks
desirable for a different reason (a callback firing while the socket is
owned pushes an LLC_EVENT onto the backlog, and release_sock() processing
of that event can re-arm timers).  Could the comment and changelog be
reworded to describe that instead?

> +		llc_sk_stop_all_timers(sk, true);
>  		llc_sap_put(sap);

[Severity: High]
Can a timer still be pending here when llc_sap_put() drops the last
reference and queues kfree_rcu(sap)?

Two things differ from the other caller of this helper.  llc_sk_free()
marks the connection dead first:

net/llc/llc_conn.c:llc_sk_free() {
	llc->state = LLC_CONN_OUT_OF_SVC;
	/* Stop all (possibly) running timers */
	llc_sk_stop_all_timers(sk, true);
	...
}

and LLC_CONN_OUT_OF_SVC is the only thing that stops an expiring timer from
re-entering the state machine:

net/llc/llc_c_ac.c:llc_process_tmr_ev() {
	if (llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC) {
	...
}

The new call site does not set that state, and the helper uses
timer_delete_sync() rather than timer_shutdown_sync(), so a mod_timer()
from a callback is not neutralised.

The first re-arm path is inside the helper itself, which deletes in a fixed
order:

net/llc/llc_conn.c:llc_sk_stop_all_timers() {
	if (sync) {
		timer_delete_sync(&llc->pf_cycle_timer.timer);
		timer_delete_sync(&llc->ack_timer.timer);
		timer_delete_sync(&llc->rej_sent_timer.timer);
		timer_delete_sync(&llc->busy_state_timer.timer);
	...
}

An ack-timer callback running concurrently takes bh_lock_sock() (free,
because release_sock() already ran), sees state != LLC_CONN_OUT_OF_SVC, and
runs the NORMAL state transition whose action list contains:

net/llc/llc_c_st.c:llc_normal_actions_20a[] {
	[3] = llc_conn_ac_start_p_timer,
}

net/llc/llc_c_ac.c:llc_conn_ac_start_p_timer() {
	mod_timer(&llc->pf_cycle_timer.timer,
		  jiffies + llc->pf_cycle_timer.expire);
}

pf_cycle was already deleted first, so timer_delete_sync(&ack) only waits
for that callback and returns with pf_cycle armed again.  The symmetric case
exists in the other direction, where busy-timer expiry (deleted last)
re-arms the ack timer (deleted second):

net/llc/llc_c_st.c:llc_common_actions_11d[] {
	[1] = llc_conn_ac_start_ack_timer,
}

The second re-arm path is an in-flight receive softirq.
llc_sap_remove_socket() only unhashes the socket; a lookup that already
succeeded holds a socket reference via refcount_inc_not_zero() under
rcu_read_lock(), and after release_sock() the socket is no longer owned:

net/llc/llc_conn.c:llc_conn_handler() {
	...
	if (!sock_owned_by_user(sk))
		llc_conn_rcv(sk, skb);
	...
}

llc_conn_rcv() -> llc_conn_state_process() can mod_timer() any of the four
timers after the new cancel pass has completed.

Both look reachable when the connection is still active at close time, for
example when llc_send_disc() returns non-zero:

net/llc/llc_if.c:llc_send_disc() {
	...
	skb = alloc_skb(0, GFP_ATOMIC);
	if (!skb)
		goto out;
	...
}

or when sk->sk_state != TCP_ESTABLISHED, e.g. a connect that timed out and
left the socket in setup state with the ack timer armed.  The socket is not
SOCK_ZAPPED in that case, so this branch is taken with live timers and a
live state machine.

The changelog says:

    llc_sk_free() still stops timers again; a second sync delete is
    harmless.

Can that second pass restore the guarantee?  It runs after the final sap
put, and its llc->state = LLC_CONN_OUT_OF_SVC is a plain store that a
concurrent state machine can overwrite via llc->state = trans->next_state
in llc_conn_service().  If so, the original UAF (a timer action touching
sap->laddr.lsap in llc_conn_ac_send_sabme_cmd_p_set_x() /
llc_conn_ac_send_rr_cmd_p_set_1() after the sap was RCU-freed) still looks
reachable.

Would it work better to make re-arming impossible before the sap reference
is dropped, by marking the connection out of service under the socket lock
and/or using timer_shutdown_sync(), or alternatively to keep the extra sap
reference until after llc_sk_free()?

As a smaller point, the trailing plain stores in the helper:

	llc->ack_must_be_send = 0;
	llc->ack_pf = 0;

now execute with the socket unlocked while it is still reachable from an
in-flight softirq.  Is that a new data race on connection state?

[Severity: High]
This isn't a bug introduced by this patch, but it is in the teardown code
the patch touches and interacts with any fix for the above, so it seems
worth raising.

llc_conn_service() validates only the upper bound of llc->state:

net/llc/llc_conn.c:llc_conn_service() {
	if (llc->state > NBR_CONN_STATES)
		goto out;
	...
}

and llc_qualify_conn_ev() then indexes with state - 1:

net/llc/llc_conn.c:llc_qualify_conn_ev() {
	struct llc_conn_state *curr_state =
					&llc_conn_state_table[llc->state - 1];
	...
	for (next_trans = curr_state->transitions +
		llc_find_offset(llc->state - 1, ev->type);
	     (*next_trans)->ev; next_trans++) {
	...
}

With llc->state == LLC_CONN_OUT_OF_SVC (which is 0) both become index -1,
reading the memory before llc_conn_state_table[] and before
llc_offset_table[][].  The resulting transitions pointer is then walked and
its members are invoked as function pointers (ev, ev_qualifiers,
ev_actions).

Is state 0 reachable from received frames alone?  llc_conn_handler()
creates and hashes an incoming socket for a frame that reaches a listener,
then runs the state machine on it.  In ADM state any frame that is not
SABME/DISC/xxx_cmd_Pbit_1 matches:

net/llc/llc_c_ev.c:llc_conn_ev_rx_any_frame() {
	return 0;
}

which selects the transition whose next state is 0:

net/llc/llc_c_st.c:llc_adm_state_trans_5 {
	.ev	       = llc_conn_ev_rx_any_frame,
	.next_state    = LLC_CONN_OUT_OF_SVC,
}

llc_conn_service() writes that into llc->state.  The socket stays hashed,
and the established lookup filters only on netns and addresses:

net/llc/llc_conn.c:llc_estab_match() {
	return net_eq(sock_net(sk), net) &&
		llc->laddr.lsap == laddr->lsap &&
		llc->daddr.lsap == daddr->lsap &&
		ether_addr_equal(llc->laddr.mac, laddr->mac) &&
		ether_addr_equal(llc->daddr.mac, daddr->mac);
}

so a second frame from the same source MAC/SSAP reaches
__llc_lookup_established() -> llc_conn_rcv() -> llc_conn_state_process() ->
llc_conn_service() with state 0.  Unlike llc_backlog_rcv() (which checks
llc->state > 1) and llc_process_tmr_ev() (explicit OUT_OF_SVC check), the
direct receive path has no state guard.

llc_sk_free() is the second producer of state 0, and it runs while an
in-flight receive softirq holding a pre-removal socket reference can still
drive that unguarded path.  Should llc_conn_service() also reject state 0,
particularly if the timer fix ends up marking the connection out of service
earlier while it is still hashed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916074158.3375909-1-miguelgarciaroman8%40gmail.com
