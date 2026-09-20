Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64B640A943;
	Sun, 20 Sep 2026 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789903204; cv=none; b=II4jsJ/6T/ffkqZOjHImKwUSLM7AAxclP1AFkMY92YCq59+qjqXBOJJK2Z1bXi97pYL/41tHIpSIcufZ4WCyKmaSzilraxh5ixwcyKSCOphccaXkbut5FcyARxGiOAEzwZQH95MGKjoAPyOEhxoGOmZBYE/lQZGmasN/0Jd6WvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789903204; c=relaxed/simple;
	bh=2kNRTMTZjzqqaedaTQ8ZXK3RHDxTl/7kk6UyVRgiXfY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Om+11rvbNs13WFcYiYKUTW2XKYIGZjqJL+HUVIoqdK9zyANa+BAaOFGfYl3EDyxlDJKHlpw7M6E7MjcRkVSqnbnQLeTEsCY1Og6sbRYQ3JaE8CrMaqSKtYjqw6yDe+E4bytClrRX3d840DwvSsZbOvdZyBaeL4n+hJr3hyPQs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku/399fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku/399fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEFE1F000FF;
	Sun, 20 Sep 2026 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789903200;
	bh=n+KDeu+aRvPI/QZxB9b6W1OjH++mIy6OycJGEnqk3yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ku/399fbrtzWONy8cI2n9VJacakphIebnJTs9cfVDrq13zqM9FQbivDd4jJgvCAsW
	 BgBQ9xq3GuMo9Qu5OCSYudlKuHUVUdN6ONzolyoxEtN6SlGneF7e2JhI2p6Vf7bYaq
	 bU1eoK2iG0Pd/GvsOAa2RkhPwHmGh7LFkC1WKg4DjIg9jljvS2ucHwJ4/XnR6N8Llq
	 zPKIwprQl33fscSp+B1OSUJbNZH5MGAiGyoOLMGJBOxludesPt93+UXK1sz62pLxIj
	 9/BJFKrh4gZUjJN1lNq7eb0iiL2uo6KbmPg6kW6WUgre1siJzVLOpX9YutfcMgfZPs
	 UtsjLTT7Jv6fA==
Subject: Re: [PATCH net v2] llc: stop connection timers before dropping sap
 ref on release
From: netdev-bot+sashiko@kernel.org
To: miguelgarciaroman8@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com
Date: Sun, 20 Sep 2026 11:19:59 +0000
Message-ID: <178990319901.2160803.11700779813478787502@kernel.org>
In-Reply-To: <20260916104735.3565609-1-miguelgarciaroman8@gmail.com>
References: <20260916104735.3565609-1-miguelgarciaroman8@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the new `llc_sk_stop_all_timers(sk, true)` in
  `llc_ui_release()` (net/llc/af_llc.c:225) does not establish the…
- [Low] The new comment in `llc_ui_release()` (net/llc/af_llc.c:218-224)
  and the commit message both state that `timer_delete_sync()` "must not…
- [Low] `llc_sk_stop_all_timers()` ends with the plain stores
  `llc->ack_must_be_send = 0; llc->ack_pf = 0;`…

--

llc: stop connection timers before dropping sap ref on release

This adds a synchronous cancellation of the four llc_sock connection timers
in llc_ui_release(), placed after release_sock() and before the extra sap
reference is dropped, so that the timer callbacks cannot dereference an
already RCU-freed llc_sap.  A few questions about the new window and the
new comment below.

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
Is the deadlock rationale in this comment accurate?

llc_conn_tmr_common_cb() in net/llc/llc_c_ac.c takes only bh_lock_sock():

	bh_lock_sock(sk);
	if (skb) {
		...
		llc_process_tmr_ev(sk, skb);
	}
	bh_unlock_sock(sk);

and bh_lock_sock() is spin_lock(&sk->sk_lock.slock), while
lock_sock_nested() releases slock before it returns and leaves only
sk->sk_lock.owned set:

	spin_lock_bh(&sk->sk_lock.slock);
	if (unlikely(sock_owned_by_user_nocheck(sk)))
		__lock_sock(sk);
	sk->sk_lock.owned = 1;
	spin_unlock_bh(&sk->sk_lock.slock);

Since a process-context owner of the socket does not hold slock, wouldn't a
timer_delete_sync() called under lock_sock() let the callback acquire slock,
run to completion and return?

What does change across release_sock() is sock_owned_by_user(): under
lock_sock() llc_process_tmr_ev() queues the event via __sk_add_backlog()
instead of running llc_conn_state_process() inline.

Could this comment and the matching commit message sentence,
"timer_delete_sync() must not run under lock_sock() (timer callbacks take
bh_lock_sock()), so stopping after release_sock() is required", be reworded
to describe that difference instead?  As written they suggest that stopping
timers or marking state while still holding the socket lock is forbidden.

> +		llc_sk_stop_all_timers(sk, true);
>  		llc_sap_put(sap);

[Severity: High]
Does this establish the invariant that the following llc_sap_put() needs,
namely that no timer can be pending any more?

llc_sk_stop_all_timers() makes a single fixed-order pass:

net/llc/llc_conn.c:llc_sk_stop_all_timers() {
	if (sync) {
		timer_delete_sync(&llc->pf_cycle_timer.timer);
		timer_delete_sync(&llc->ack_timer.timer);
		timer_delete_sync(&llc->rej_sent_timer.timer);
		timer_delete_sync(&llc->busy_state_timer.timer);
	...
}

timer_delete_sync() waits only for that one timer's callback and has no
shutdown semantics.  Can a later-deleted timer's callback re-arm an
earlier-deleted one?

llc_conn_rej_tmr_cb() -> llc_conn_tmr_common_cb() -> llc_process_tmr_ev()
-> llc_conn_state_process()

and llc_common_actions_11c / llc_common_actions_11d in net/llc/llc_c_st.c
contain:

	[1] = llc_conn_ac_start_ack_timer,

which is an unconditional re-arm in net/llc/llc_c_ac.c:

	mod_timer(&llc->ack_timer.timer, jiffies + llc->ack_timer.expire);

The same holds for llc_normal_actions_20a / llc_normal_actions_20b, whose

	[3] = llc_conn_ac_start_p_timer,

re-arms pf_cycle_timer, the timer deleted first in the pass.

There is a second way into the same window.  llc_conn_handler() takes the sk
reference under RCU, and its only re-validation is:

	if (llc_sk(rc)->sap != sap)
		...

llc->sap is never cleared during release, so a softirq whose lookup predates
llc_sap_remove_socket() still passes that check.  release_sock() has already
run, so sock_owned_by_user(sk) is false and the frame goes straight into
llc_conn_rcv() -> llc_conn_state_process(), whose actions mod_timer() as
well.  Can that land after the last timer_delete_sync() returns and before
llc_sap_put()?

Is anything suppressing the state machine in this window?
llc_process_tmr_ev() only discards events when the connection is already out
of service:

net/llc/llc_c_ac.c:llc_process_tmr_ev() {
	if (llc_sk(sk)->state == LLC_CONN_OUT_OF_SVC) {
		...
		kfree_skb(skb);
	} else {
		if (!sock_owned_by_user(sk))
			llc_conn_state_process(sk, skb);
	...
}

and that state is set only later, after llc_sap_put() has run:

net/llc/llc_conn.c:llc_sk_free() {
	llc->state = LLC_CONN_OUT_OF_SVC;
	/* Stop all (possibly) running timers */
	llc_sk_stop_all_timers(sk, true);
	...
}

If llc_sap_put() here drops the last reference, llc_sap_close() does
list_del_rcu() + kfree_rcu(sap, rcu).  A pending timer holds no RCU
read-side protection, so if the releasing task is delayed between
llc_sap_put() and llc_sk_free(), can the re-armed timer still dereference
the freed sap (sap->laddr.lsap in llc_conn_ac_send_sabme_cmd_p_set_x()),
which is the reported signature?

Reaching release with an armed state machine also looks easy:
llc_send_disc() in net/llc/llc_if.c returns without any state transition
when the atomic allocation fails:

	skb = alloc_skb(0, GFP_ATOMIC);
	if (!skb)
		goto out;

Would using timer_shutdown_sync() for all four timers on this teardown path,
setting llc->state = LLC_CONN_OUT_OF_SVC while the socket lock is still
held, and/or keeping the extra sap reference until after llc_sk_free(sk)
close the window instead of narrowing it?

[Severity: Low]
Can this call race on llc->ack_must_be_send and llc->ack_pf?
llc_sk_stop_all_timers() ends with two plain stores:

	llc->ack_must_be_send = 0;
	llc->ack_pf = 0;

The existing callers are serialized: llc_sk_reset() runs from state-machine
actions with the socket owned or BH-locked, and llc_sk_free() runs after
sock_orphan() and sock->sk = NULL, when nothing can be dispatched to the
socket.  This new call site holds neither lock_sock() nor bh_lock_sock().

Meanwhile a softirq that took the sk reference in llc_conn_handler() before
the unhash can run llc_conn_state_process() under bh_lock_sock() and
read/write the same two fields, for example through
llc_conn_ac_rst_sendack_flag() and llc_conn_ac_send_ack_if_needed().

Would KCSAN flag this pair of accesses, and can the concurrent state machine
set the flags again right after they are cleared here?

>  	} else {
>  		release_sock(sk);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916104735.3565609-1-miguelgarciaroman8%40gmail.com
