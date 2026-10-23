Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720986;
	b=n1SdIUDv93lG3Z9hTb07dPrRlpXoTGS/sd32jEZeGS/UbFoGv8GPLRtbEiMssfMjr2r7
	 81PvKEX17IVdXj/uW/e9kQlJOfdNGWT8LZz2k1KRiMUMfdHeLrtkgGVmJtVpLJwHjPI00
	 TyB1wZCHykJHDx5+7rA62frFucQ40YE0aBbcSCphJt3nx6OjMBET60n5ey8oDiMaVCtUW
	 jNOsld12NUw7XNyV/LhfWalMFSx7p7ngW4LcteqCURarpSDPy3oS13+KACroqXibV8K8L
	 YnZg1nL+PL2XChvKlPIkSMuO2ZBXwIXQOzdRePGtTrKQUJYiRPb3jRJBCGXuHSQiURg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720986;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IVITE9Nj3Yc38nnKpiz93EjGp5NoZDHi5lFSHA6bsHA=;
	b=j06z5Ruy7iS6da0dkuuyMuDMRLgXJnhNWb65InHhaGKHo++O8dzsJ752mHpvZEqymrVp
	 0XbYvv1kA4+kgdNkxQYc+0si3doF1G6+HHycvfEBya3u41G3YXFQAcZVoU3aFmegYiPOV
	 j6hDA1fHxpt5jPPKQgHvVPWwICgJ+yph0+h7Z/GJNL5BTnINZ2cFUGNUYEBMyPcvTwrsr
	 WE93ubrGQpcrOGsdtm9AYgL44dAkRo+ywoIr0zOcd4qU9AOyvqhN4cH0W9KzTYsXEipRM
	 gnXXpFDhhTuSpWKkfmG9si04GH51Y7bwIqV/4Q8u/plkb4r21+6q/Uu3MddU5u7vw+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cEyz/ijh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69912606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEyz/ijh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D81C1F01828;
	Fri, 23 Oct 2026 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720986;
	bh=IVITE9Nj3Yc38nnKpiz93EjGp5NoZDHi5lFSHA6bsHA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cEyz/ijhd4Qan1+Nb3PV9568bK4DUqmXLw5gRKckfIZo4arlOs2MKVQXSjwZgFFKK
	 nQDoHauQqw2v8avFnR8VnGyZMsZrdpHBR0Kedma6NAKFHq6jLhIe0irZFAkU8yMRs8
	 4x//oUocfUAglCb0uB18JjDSWV9W3s5B0RVcsuSrDJykF66FdUsfq9x3rLE9so9Ka3
	 HP1ACltXaMBpbli+j4EnvaPB6hwZMvD1nTh69mWkQ/b9eevDPdGs44Cg6kERAq0G3Z
	 xMN7zdrHzpb2p2ykSCJMbYedQmrzf3v2Tqx4OnWsvGuID7JjqgQfX4gJRjBpFYTvOm
	 qBJRlfE/QiBRA==
Subject: Re: [PATCH net v3] tipc: fix refcount panic in tipc_rcv() when
 receiving shared skb
From: netdev-bot+sashiko@kernel.org
To: tung.quang.nguyen@est.tech
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net,
 syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com,
 ngocthang2710.1999@gmail.com
Date: Fri, 23 Oct 2026 02:03:05 +0000
Message-ID: <179272098505.3134.12934306852060291643@kernel.org>
In-Reply-To: <20261022011539.6882-1-tung.quang.nguyen@est.tech>
References: <20261022011539.6882-1-tung.quang.nguyen@est.tech>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] tipc: lost disconnect abort in tipc_sk_conn_proto_rcv() on
  unclone error
- [Medium] In tipc_sk_filter_connect() (net/tipc/socket.c), the new
  skb_unclone() failure in the empty-ACK branch (state TIPC_CONNECTING,…
- [Medium] In tipc_link_tnl_rcv() (net/tipc/link.c), the new
  skb_unclone() failure path always returns tipc_link_fsm_evt(l,…
- [Medium] The commit says the skb has to be uncloned where TIPC modifies
  packet data, and lists four sites.

Pre-existing issues:
- [Low] In tipc_sk_conn_proto_rcv() (net/tipc/socket.c), the
  msg_errcode() branch now does `goto exit` (kfree_skb) when…

--

tipc: fix refcount panic in tipc_rcv() when receiving shared skb

This patch calls skb_share_check() in tipc_l2_rcv_msg() so that TIPC owns
the skb before it is passed to tipc_rcv(). The result may still be a clone,
so the patch adds skb_unclone() calls before the in-place header writes in
tipc_sk_conn_proto_rcv(), tipc_sk_filter_connect(), tipc_msg_lookup_dest()
and tipc_link_tnl_rcv().

Closes: https://syzkaller.appspot.com/bug?extid=0017742620a9d06f06ef
Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.1999@gmail.com/T/

> Fix this by calling skb_share_check() to ensure exclusive ownership
> before passing the skb to tipc_rcv(). As TIPC needs to modify the skb's
> data, the cloned skb needs to be uncloned in tipc_sk_conn_proto_rcv(),
> tipc_sk_filter_connect(), tipc_msg_lookup_dest() and tipc_link_tnl_rcv().

[Severity: Medium]
Is this list complete? tipc_get_gap_ack_blks() in net/tipc/link.c also
writes into the received packet's data, in its backward compatible
unicast branch:

net/tipc/link.c:tipc_get_gap_ack_blks() {
    ...
		} else if (uc && sz == struct_size(p, gacks, p->ugack_cnt)) {
			if (p->ugack_cnt) {
				p->bgack_cnt = 0;
				goto ok;
			}
		}
    ...
}

Here p points into msg_data(hdr) of the incoming skb. Before this write,
the caller tipc_link_proto_rcv() only calls skb_linearize():

net/tipc/link.c:tipc_link_proto_rcv() {
    ...
	if (skb_linearize(skb))
		goto exit;
    ...
	case STATE_MSG:
		/* Validate Gap ACK blocks, drop if invalid */
		glen = tipc_get_gap_ack_blks(&ga, l, hdr, true);
    ...
}

skb_linearize() does nothing for a linear skb that is cloned. Suppose a
peer sends a STATE_MSG whose gap ACK size matches only ugack_cnt. That
would zero bgack_cnt in data still shared with another clone holder. The
holder could be the original skb that skb_share_check() cloned, or a
packet socket clone.

Would a single skb_unshare() style copy at TIPC ingress be more robust
than adding skb_unclone() at each write site?

> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index 6427c69f8929..d7ce384d3b89 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -1363,6 +1363,13 @@ static int tipc_link_tnl_rcv(struct tipc_link *l, struct sk_buff *skb,
>  		}
>  		kfree_skb(skb);
>  	} else {
> +		if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM) {
> +			kfree_skb(skb);
> +			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
> +		}

[Severity: Medium]
Should this failure path skip the link failure event for the broadcast
receive link? Later in this same branch, the reassembly failure handling
exempts it:

		if (!tipc_buf_append(reasm_tnlmsg, &skb)) {
			/* Successful but non-complete reassembly? */
			if (*reasm_tnlmsg || link_is_bc_rcvlink(l))
				return 0;
			pr_warn_ratelimited("Unable to reassemble tunnel msg\n");
			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
		}

tipc_link_input() makes the same exemption.

Broadcast packets can reach this code through:

tipc_rcv()->tipc_node_bc_rcv()->tipc_bcast_rcv()->tipc_link_rcv()
    ->tipc_link_tnl_rcv()

If the bc rcvlink is established, LINK_FAILURE_EVT moves it to
LINK_RESETTING and returns TIPC_LINK_DOWN_EVT. tipc_node_bc_rcv() then
does:

	if (rc & TIPC_LINK_DOWN_EVT)
		tipc_node_reset_links(n);

Could a GFP_ATOMIC failure on a cloned, fragmented tunnel message that
arrives on the broadcast path then reset every link to that peer?

> +
> +		hdr = buf_msg(skb);
> +

[ ... ]

> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index d5d70eb230b5..9789d1ce6bd4 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -1345,6 +1345,10 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
>  				      tsk_peer_port(tsk));
>  		sk->sk_state_change(sk);
>  
> +		if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
> +			goto exit;
> +		hdr = buf_msg(skb);
> +

[Severity: High]
If skb_unclone() fails here, the socket has already been moved to
TIPC_DISCONNECTING. tipc_node_remove_conn() has already run and
sk_state_change() has already been called. The skb is then freed at
exit without the abort message being built or queued, and nothing on
this path sets sk->sk_err or RCV_SHUTDOWN.

What terminal condition does a reader see after that?

tipc_wait_for_rcvmsg() leaves its loop only in these cases:

  - sk_receive_queue is not empty
  - RCV_SHUTDOWN is set
  - the timeout expires
  - a signal is pending
  - sock_error() returns an error

It never checks for TIPC_DISCONNECTING. The socket is no longer
TIPC_ESTABLISHED, so tipc_sk_timeout() stops probing and nothing will
abort the connection later. A reader blocked in tipc_recvmsg() or
tipc_recvstream() with an infinite timeout could stay asleep forever.

tipc_poll() reports EPOLLIN | EPOLLRDNORM | EPOLLHUP for
TIPC_DISCONNECTING whether or not the receive queue is empty. An event
loop that polls and then calls a non-blocking recvmsg() would see
EPOLLIN, get -EAGAIN back from tipc_wait_for_rcvmsg(), and spin.

This needs a GFP_ATOMIC failure on a cloned error message, but the
result is a hung or spinning application.

I am not sure the success path gets the converted abort message onto
sk_receive_queue either. tipc_sk_filter_connect() returns false for
TIPC_DISCONNECTING. Still, this new exit leaves the socket with no
terminal state at all.

Could this branch set sk->sk_err, or RCV_SHUTDOWN in sk_shutdown,
before the unclone? Then readers would wake up whether or not the abort
message survives. Alternatively, could the unclone be done before the
state change? Then a failure would just drop the message, the socket
would stay TIPC_ESTABLISHED, and probing would eventually abort it.

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. This new
exit drops the abort message after the socket is already
TIPC_DISCONNECTING, and neither sk_err nor RCV_SHUTDOWN is set.
tipc_wait_for_rcvmsg() does not check for TIPC_DISCONNECTING. Can a
reader blocked with an infinite timeout be left with no terminal
condition?

The success path seems to end the same way, though. The converted abort
message goes to inputq, and tipc_sk_filter_connect() returns false for
TIPC_DISCONNECTING:

	case TIPC_OPEN:
	case TIPC_DISCONNECTING:
		return false;

tipc_msg_reverse() then drops it because msg_errcode() is still set. So
the abort message did not reach sk_receive_queue before this patch
either, and the new exit gives the same outcome.

In the CONN_PROBE branch below, an unclone failure drops the probe and no
CONN_PROBE_REPLY is sent. That is the same outcome as the existing
allocation failure in tipc_msg_reverse():

	if (mtyp == CONN_PROBE) {
		if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
			goto exit;
		hdr = buf_msg(skb);
		msg_set_type(hdr, CONN_PROBE_REPLY);
		if (tipc_msg_reverse(onode, &skb, TIPC_OK))

tipc_msg_reverse() already copies the header into a freshly allocated
buffer. Could the CONN_PROBE_REPLY type be set on that copy instead, so
the unclone is not needed?

[ ... ]

> @@ -2223,6 +2230,9 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
>  				return true;
>  			/* Empty ACK-, - wake up sleeping connect() and drop */
>  			sk->sk_state_change(sk);
> +			if (skb_unclone(skb, GFP_ATOMIC) == -ENOMEM)
> +				break;

[Severity: Medium]
Does this break leave the connection half set up? tipc_sk_finish_conn()
has already run at this point. It sets TIPC_ESTABLISHED, arms the probe
timer, purges sk_write_queue and calls tipc_node_add_conn():

net/tipc/socket.c:tipc_sk_finish_conn() {
    ...
	sk_reset_timer(sk, &sk->sk_timer, jiffies + CONN_PROBING_INTV);
	tipc_set_sk_state(sk, TIPC_ESTABLISHED);
	tipc_node_add_conn(net, peer_node, tsk->portid, peer_port);
    ...
}

The break lands in the abort tail. That tail was written for paths that
run before tipc_sk_finish_conn():

	/* Abort connection setup attempt */
	tipc_set_sk_state(sk, TIPC_DISCONNECTING);
	sk->sk_err = ECONNREFUSED;
	sk->sk_state_change(sk);
	return true;

The tail never calls tipc_node_remove_conn(). For a remote peer,
tipc_node_add_conn() allocated a tipc_sock_conn with GFP_ATOMIC and linked
it on node->conn_sks. __tipc_shutdown() removes it only for
TIPC_CONNECTING and TIPC_ESTABLISHED, so a TIPC_DISCONNECTING socket
takes the default branch on close.

Does the tipc_sock_conn leak until node_lost_contact()?

connect() would also return -ECONNREFUSED even though the peer accepted.
The peer is not notified, so it stays half open until its probing gives
up.

The function now returns true here, so tipc_sk_filter_rcv() queues the
data-less ACK on sk_receive_queue and calls sk_data_ready(). Before this
patch the ACK was dropped, as the "wake up sleeping connect() and drop"
comment says.

Other ESTABLISHED to DISCONNECTING transitions call
tipc_node_remove_conn(). Examples are the error case under
TIPC_ESTABLISHED in this function, tipc_sk_conn_proto_rcv() and
tipc_sk_check_probing_state().

Could the unclone be done before tipc_sk_finish_conn()? Or, on failure,
could the ACK just be dropped without falling into the abort tail?

> +			hdr = buf_msg(skb);
>  			msg_set_dest_droppable(hdr, 1);
>  			return false;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022011539.6882-1-tung.quang.nguyen%40est.tech
