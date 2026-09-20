Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A447ECEE;
	Sun, 20 Sep 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941363; cv=none; b=tcLxdpaoR+pog4wMZsse5ZwmhCwa0N7f3Zrv8r9hYt2qZyVUmSexs1J2F6RLoHFbClf3IgNkKjmUtP6OSxYELln8a2p9XZmdVXY3neXHCKJR6yXlB9JZRw5Tq0Vu/us7T5jPj4TSiJw3xaT3MRyBw3OEparyo4yJX/TfYQ2Kr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941363; c=relaxed/simple;
	bh=/eehDlMbhRbk5jDVDQBsa5RSjdDtAbMeITfWf98ueiQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfuMiBHmMYiJo8c/xaiA6SabgtbQ21dgdNguXAHVQFNzjae+9jJx0B7Q1hN2p2EMUKj3t6W7VXtX6d3dlkVZCyMwv7c0QEXIuAy9yQSbB7rnPwQj1ZnH4V/jrF83T4MAYEVmgofo+Bu0mghPrcDBiL00HvesIcpIb8JB2cGYPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnEyXTsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnEyXTsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEFA1F00893;
	Sun, 20 Sep 2026 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941355;
	bh=gho3XsB+rCMkQouH2sK/QuHGliacTo5BbkjD8cyjXKM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DnEyXTsYW1oYvJ/4cIGBHX1YLLGLvznQV+NG2f/DY54I4Rfnp2UmcJjdmKM2rw9uX
	 rOhUFKxShZn9lGkt3FgWqJICYmSy7zXRdfl6uy7CT/t5oX7GTKe4XWW7GlA/dtSdd/
	 YAYFv2WXoT1vEsku+i0qwzXlMsLZ3ULqOi0s2EqRdJhphs2vS8W32MbNiyXmbzSIrQ
	 BMpIidccpt3f69ogUwyd9U0+/CrDn94nsXmS49dYFUoKpjeN8oQ1CeOjzi/Q4NF2f3
	 DAuUlljaZQTVUH/GN6uksBnIaYYJACZHL+OlCWR2/bZpgiXqj7UwjVXBUPiJ/4fdxw
	 qpRCoPxPiV2Dg==
Subject:
 Re: [PATCH] tcp: drain out_of_order_queue and update SACKs in tcp_send_rcvq()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 21:55:54 +0000
Message-ID: <178994135442.2160803.9245969702755706325@kernel.org>
In-Reply-To: <20260919215236.3470714-1-benquike@gmail.com>
References: <20260919215236.3470714-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/ipv4/tcp_input.c, tcp_send_rcvq(): the newly added
  unconditional `tcp_ofo_queue(sk)` call imports full receive-path…
- [Low] net/ipv4/tcp_input.c, tcp_send_rcvq() becomes the second caller
  of the OFO-drain sequence but replicates only two of the five steps…
- [Low] Commit message factual error: it states that tcp_send_rcvq()
  "advances tp->copied_seq and tp->rcv_nxt".
- [Low] The change asserts a bug without any reproducer, warning,
  syzkaller report or stated user-visible symptom, yet carries `Fixes:…
- [Low] net/ipv4/tcp_input.c, tcp_send_rcvq(): the new tcp_ofo_queue()
  call does not establish the per-processing-pass D-SACK precondition…

--

tcp: drain out_of_order_queue and update SACKs in tcp_send_rcvq()

This adds an out-of-order queue drain plus a SACK block update to
tcp_send_rcvq(), so that segments in tp->out_of_order_queue which become
in-order after TCP_REPAIR injects data into the receive queue are
coalesced and the SACK bookkeeping is pruned.

A few questions about the commit message and the new call site follow.

> When TCP_REPAIR injects data into the receive queue via tcp_send_rcvq() and
> advances tp->copied_seq and tp->rcv_nxt, any segments already sitting in
                ^^^^^^^^^^^^^^

[Severity: Low]
Does tcp_send_rcvq() actually advance tp->copied_seq?  Reading the
function, the only sequence update comes from tcp_queue_rcv():

net/ipv4/tcp_input.c:tcp_queue_rcv() {
	...
	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
	...
}

which touches rcv_nxt only.  For the receive repair queue, copied_seq
appears to be written only by the TCP_QUEUE_SEQ setsockopt:

net/ipv4/tcp.c:do_tcp_setsockopt() {
	...
	} else if (tp->repair_queue == TCP_RECV_QUEUE) {
		if (tp->rcv_nxt != tp->copied_seq) {
			err = -EPERM;
		} else {
			WRITE_ONCE(tp->rcv_nxt, val);
			WRITE_ONCE(tp->copied_seq, val);
		}
	...
}

and that path additionally requires sk->sk_state == TCP_CLOSE.

Could the changelog also state the user-visible symptom and the
preconditions to reach it (CAP_NET_ADMIN, TCP_REPAIR enabled on a live
socket whose out_of_order_queue is already non-empty)?

> tp->out_of_order_queue that are now covered or contiguous with rcv_nxt are
> not coalesced or removed from tp->rx_opt.num_sacks. Drain
                               ^^^^^^^^^^^^^^^^^^^^
> out_of_order_queue via tcp_ofo_queue(sk) and update SACK blocks via
> tcp_sack_remove(tp) after advancing rcv_nxt in tcp_send_rcvq().
>
> Fixes: 292e8d8c8538 ("tcp: Move rcvq sending to tcp_input.c")

[Severity: Low]
Small wording point first: segments are not "removed from
tp->rx_opt.num_sacks", num_sacks is a count of SACK blocks.

On the Fixes: tag, is there a reproducer, warning or syzkaller report
behind this?  The tag targets a 2012 commit, so this pulls a behaviour
change of the privileged TCP_REPAIR path into stable trees.

The state being fixed also looks transient, since the normal receive path
already reconciles it on the next in-sequence segment:

net/ipv4/tcp_input.c:tcp_data_queue() {
	...
		if (!RB_EMPTY_ROOT(&tp->out_of_order_queue)) {
			tcp_ofo_queue(sk);
	...
		if (tp->rx_opt.num_sacks)
			tcp_sack_remove(tp);
	...
}

and tcp_fin(), tcp_prune_ofo_queue(), tcp_close() and tcp_disconnect()
all purge the tree or reset the SACK state.  In the CRIU restore flow the
out-of-order tree is empty anyway, because TCP_QUEUE_SEQ only allows
moving rcv_nxt while sk_state == TCP_CLOSE.

Would it make sense to either demonstrate the failure or drop the Fixes:
tag and present this as hardening?

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 92bc60716f33..8a7c38a4b1ec 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5589,6 +5589,11 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
>  		WARN_ON_ONCE(fragstolen); /* should not happen */
>  		__kfree_skb(skb);
>  	}
> +	if (!RB_EMPTY_ROOT(&tcp_sk(sk)->out_of_order_queue)) {
> +		tcp_ofo_queue(sk);

[Severity: High]
Can this run the TCP state machine from inside sendmsg()?  If an
out-of-order segment carrying TCPHDR_FIN becomes in-order because the
injected bytes closed the hole, tcp_ofo_queue() reaches:

net/ipv4/tcp_input.c:tcp_ofo_queue() {
	...
		if (unlikely(fin)) {
			tcp_fin(sk);
			/* tcp_fin() purges tp->out_of_order_queue,
			 * so we must end this loop right now.
			 */
			break;
		}
	...
}

and tcp_fin() then does:

net/ipv4/tcp_input.c:tcp_fin() {
	inet_csk_schedule_ack(sk);
	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
	sock_set_flag(sk, SOCK_DONE);
	...
	skb_rbtree_purge(&tp->out_of_order_queue);
	if (tcp_is_sack(tp))
		tcp_sack_reset(&tp->rx_opt);
	...
}

The call site here is reached from tcp_sendmsg_locked():

net/ipv4/tcp.c:tcp_sendmsg_locked() {
	if (unlikely(tp->repair)) {
		if (tp->repair_queue == TCP_RECV_QUEUE) {
			copied = tcp_send_rcvq(sk, msg, size);
			goto out_nopush;
		}
	...
}

sk_stream_wait_connect() confines sk_state to ESTABLISHED/CLOSE_WAIT (or
SYN_RECV for passive fastopen), so the FIN_WAIT arms and tcp_done() are
not reachable from here.  The ESTABLISHED -> CLOSE_WAIT transition,
RCV_SHUTDOWN, SOCK_DONE, the skb_rbtree_purge() of the remaining
out-of-order peer data, the SACK reset and the sk_state_change()/
sk_wake_async(POLL_IN) wakeups are reachable though, and
tcp_send_rcvq() still returns size, so a repair tool sees success with no
indication that the read side was shut down and queued peer data
discarded.

Separately, tcp_ofo_queue() computes dsack_high from tp->rcv_nxt as just
advanced by the locally injected bytes:

net/ipv4/tcp_input.c:tcp_ofo_queue() {
	__u32 dsack_high = tp->rcv_nxt;
	...
		if (before(TCP_SKB_CB(skb)->seq, dsack_high)) {
			__u32 dsack = dsack_high;
			...
			tcp_dsack_extend(sk, TCP_SKB_CB(skb)->seq, dsack);
		}
	...
}

Does that make the socket record and later advertise a D-SACK for a range
the peer never retransmitted, feeding the peer's spurious-retransmission
and congestion-undo logic?

Would it be better to reconcile the stale state locally here
(skb_rbtree_purge() plus tcp_sack_reset()), or to suppress the FIN and
D-SACK side effects while tp->repair is set, matching the quiescence
policy TCP_QUEUE_SEQ already enforces?

[Severity: Low]
On the same call, is tp->rx_opt.dsack guaranteed to be clear here?  The
existing caller clears it before it can reach tcp_ofo_queue():

net/ipv4/tcp_input.c:tcp_data_queue() {
	reason = SKB_DROP_REASON_NOT_SPECIFIED;
	tp->rx_opt.dsack = 0;
	...
}

Otherwise the flag is only cleared when the option is actually written
out in tcp_options_write(), or by tcp_disconnect().  With a deferred
delayed ACK the flag can still be set when the repair write runs, and
then:

net/ipv4/tcp_input.c:tcp_dsack_extend() {
	if (!tp->rx_opt.dsack)
		tcp_dsack_set(sk, seq, end_seq);
	else
		tcp_sack_extend(tp->duplicate_sack, seq, end_seq);
}

takes the else branch against the stale tp->duplicate_sack[0].  For a
disjoint range tcp_sack_extend() returns false and the return value is
ignored, so is the D-SACK for the segment processed in this pass silently
lost while the stale block stays?

> +		if (tcp_sk(sk)->rx_opt.num_sacks)
> +			tcp_sack_remove(tcp_sk(sk));
> +	}
>  	return size;

[Severity: Low]
This new site performs two of the five steps the pre-existing caller
performs:

net/ipv4/tcp_input.c:tcp_data_queue() {
	...
		if (!RB_EMPTY_ROOT(&tp->out_of_order_queue)) {
			tcp_ofo_queue(sk);
			/* RFC5681. 4.2. SHOULD send immediate ACK, when
			 * gap in queue is filled.
			 */
			if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
		}
		if (tp->rx_opt.num_sacks)
			tcp_sack_remove(tp);
		tcp_fast_path_check(sk);
		...
		if (!sock_flag(sk, SOCK_DEAD))
			tcp_data_ready(sk);
	...
}

Is the omission of the ICSK_ACK_NOW hint, tcp_fast_path_check() and the
data-ready notification intentional?  pred_flags stays zeroed by the
earlier tcp_data_queue_ofo() until some later in-order segment reaches
tcp_data_queue(), and bytes moved into sk_receive_queue by this drain
produce no wakeup.

If the divergence is deliberate, could the changelog say so?

>  
>  err_free:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919215236.3470714-1-benquike%40gmail.com
