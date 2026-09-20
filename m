Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE33E7159;
	Sun, 20 Sep 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789942333; cv=none; b=l7rxng/V/yH/E5ccOLvoYyiWZmNN6uAD7FEgzDxEGF9Opxz/i2nh0kyQ7/BPUvArmZARgUuMFo3bV71h/QVQ1YJCrm27uy/V8Lmb9Ebd9PA7pwh/osWlQLKqUSKFNa0JLgcDEtkIKC7MV67C0P9HGlV/Qo6/5D/3OjSZBGpMo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789942333; c=relaxed/simple;
	bh=2jqob2LUHqdr89q2w1DE3hlHBYo4/WHLKtiIERUY9EY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMKNP6md2C1fM9CvyzM+3iLGz/iYA7il3rZXBCyeb/F0BM0zeW34BeO3wY/uo2nGnr/STgQLwu50MuwXLqpHGduBWkXT9FqMvNsoK8+q5uNeE3xZQGH1qNza1lbhRN8uHxGsUrPh7tCTFxHpO6tZygsffrMxc3aL8H3FrSy0WV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hbl1lt+8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hbl1lt+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227E91F00898;
	Sun, 20 Sep 2026 22:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789942331;
	bh=gQMiXzZvYPQBm5zWhHwriIxMLLVfERtLvN5qhg2DQik=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hbl1lt+8pV3bA3cUAPuxyGq7RzWn9lAZVdLMl278MUBIKAk5NICmXEcYKIDErdJNP
	 J6Ne9OuiTr9VykP+7Zs0H6OPgVVFU976OFt17pP20GT5HjqtEI4mYS5o96fOssP2Zb
	 bnBQUZTqzxFnUgyuTqDtMwBPr+Fjyer/2jAmM2liXEA+9XSosVspzq8gHSyg/2hR2M
	 REgsgZ4TXNIAMAI5Gw03KlCQCABDI4oaPxeXWcNIeOT9E5QINuMncVP+TPi7e6Zl0d
	 yZUcD2ivKfJW1JDKrDsVXfT4zdJjdmNQZn+drOKdPgQYZlu0f9r1ZpTT5jRekl0wwK
	 pwqaLDiYeXVXg==
Subject: Re: [PATCH] ipv6: tcp: restore ipv6_specific icsk_af_ops when
 reconnecting IPv6 after v4-mapped
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:12:10 +0000
Message-ID: <178994233062.2160803.6179946811684517099@kernel.org>
In-Reply-To: <20260919215234.3470646-1-benquike@gmail.com>
References: <20260919215234.3470646-1-benquike@gmail.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the stale `ipv6_mapped` state is only repaired
  in the re-connect path of tcp_v6_connect().
- [High] The new restore block is guarded by `icsk->icsk_af_ops ==
  &ipv6_mapped` (net/ipv6/tcp_ipv6.c:258), a condition that can never be…
- [Low] The commit message misidentifies both the mapped TCP
  authentication table and the socket-option consequence.

Pre-existing issues:
- [Low] The new block documents its store as 'Paired with READ_ONCE() in
  tcp_(get|set)sockopt()' and uses WRITE_ONCE(icsk->icsk_af_ops,…

--

ipv6: tcp: restore ipv6_specific icsk_af_ops when reconnecting IPv6 after v4-mapped

This patch adds a block to tcp_v6_connect() that restores icsk_af_ops,
sk_backlog_rcv and tp->af_specific back to their native IPv6 values when a
socket that previously connected to an IPv4-mapped destination connects to a
native IPv6 destination.  It also calls mptcpv6_handle_mapped(sk, false) for
MPTCP sockets.

A few questions on the change and the changelog below.

> ipv6: tcp: restore ipv6_specific icsk_af_ops when reconnecting IPv6 after v4-mapped
>
> When an AF_INET6 TCP socket connects to an IPv4-mapped IPv6 address
> (::ffff:a.b.c.d), tcp_v6_connect() switches icsk->icsk_af_ops to
> &ipv6_mapped, sk->sk_backlog_rcv to tcp_v4_do_rcv, and tp->af_specific to
> &tcp_sock_ipv4_specific. If the connection fails or is disconnected with
> AF_UNSPEC and the socket subsequently connects to a native IPv6 address,
> tcp_v6_connect() leaves icsk_af_ops set to &ipv6_mapped, causing IPv4
> operations (such as ip_queue_xmit() and IPv4 setsockopt handlers) to run on
> an IPv6 flow and corrupt the socket/routing state.

[Severity: Low]
Two details in this paragraph look inaccurate.

First, the mapped branch of tcp_v6_connect() installs
&tcp_sock_ipv6_mapped_specific, not &tcp_sock_ipv4_specific:

	/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
	WRITE_ONCE(icsk->icsk_af_ops, &ipv6_mapped);
	...
#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
	tp->af_specific = &tcp_sock_ipv6_mapped_specific;
#endif

Second, can IPv4 setsockopt handlers actually run in this state?  The
ipv6_mapped table keeps the IPv6 option handlers:

static const struct inet_connection_sock_af_ops ipv6_mapped = {
	...
	.setsockopt	   = ipv6_setsockopt,
	.getsockopt	   = ipv6_getsockopt,

The IPv4-oriented members that remain (queue_xmit = ip_queue_xmit,
net_header_len = sizeof(struct iphdr), rebuild_header =
inet_sk_rebuild_header, mtu_reduced = tcp_v4_mtu_reduced) do describe the
problem, so could the changelog name those instead?

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 7fa4ed2fd4f1..49a6f89481cb 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -255,6 +255,17 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  		return err;
>  	}
>  
> +	if (icsk->icsk_af_ops == &ipv6_mapped) {
> +		/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
> +		WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
> +		if (sk_is_mptcp(sk))
> +			mptcpv6_handle_mapped(sk, false);

[Severity: High]
Can this guard ever be true for an MPTCP subflow?  For MPTCP the plain
ipv6_* tables are not what sits in icsk_af_ops.  subflow_ulp_init() installs
the subflow tables:

net/mptcp/subflow.c:subflow_ulp_init() {
	ctx->icsk_af_ops = icsk->icsk_af_ops;
	icsk->icsk_af_ops = subflow_default_af_ops(sk);
}

and mptcpv6_handle_mapped() moves the current pointer aside and installs the
mptcp mapped table:

net/mptcp/subflow.c:mptcpv6_handle_mapped() {
	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
	...
	subflow->icsk_af_ops = icsk->icsk_af_ops;
	icsk->icsk_af_ops = target;
}

So after the mapped connect the subflow holds &subflow_v6m_specific, and
&ipv6_mapped is only stored in subflow->icsk_af_ops.  Doesn't that make the
new equality test always false for MPTCP, leaving the
mptcpv6_handle_mapped(sk, false) call inside the block unreachable?

The table left installed is the one built from the IPv4 operations:

net/mptcp/subflow.c:mptcp_subflow_v6_init() {
	subflow_v6m_specific = subflow_v6_specific;
	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
}

And the reuse path looks reachable: mptcp_disconnect() keeps the first
subflow ("msk->subflow is still intact, the following will not free the first
subflow"), __mptcp_subflow_disconnect() only does tcp_disconnect(ssk) plus
mptcp_subflow_ctx_reset() (which clears reset/request_mptcp/local_id only),
and mptcp_connect() then re-issues ssk->sk_prot->connect() on the same ssk.

Would a predicate that also recognises the MPTCP mapped state be needed here,
for instance comparing against the mptcp mapped ops or testing
sk->sk_backlog_rcv == tcp_v4_do_rcv?

[Severity: Low]
This is a pre-existing issue in MPTCP, not something introduced by this
patch, but the new comment claims a pairing that mptcpv6_handle_mapped() does
not honour.  The final publication of icsk_af_ops for subflows is an unmarked
store:

net/mptcp/subflow.c:mptcpv6_handle_mapped() {
	if (likely(icsk->icsk_af_ops == target))
		return;

	subflow->icsk_af_ops = icsk->icsk_af_ops;
	icsk->icsk_af_ops = target;
}

while tcp_setsockopt() and tcp_getsockopt() read it locklessly before taking
the socket lock:

net/ipv4/tcp.c:tcp_setsockopt() {
		return READ_ONCE(icsk->icsk_af_ops)->setsockopt(sk, level, optname,
}

Should the WRITE_ONCE()/READ_ONCE() marking be added in
mptcpv6_handle_mapped() itself, so the annotation the new comment describes
actually holds for the existing call sites in tcp_v6_connect() and
tcp_v6_mapped_child_init()?

> +		sk->sk_backlog_rcv = tcp_v6_do_rcv;
> +#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
> +		tp->af_specific = &tcp_sock_ipv6_specific;
> +#endif
> +	}
> +

[Severity: High]
Does this cover the listen() transition as well as the reconnect one?  The
repair only runs inside tcp_v6_connect(), so a socket that is turned into a
listener instead of being re-connected still keeps the mapped operations:

  socket(AF_INET6)
  connect(::ffff:a.b.c.d)     /* installs ipv6_mapped */
  connect(AF_UNSPEC)          /* or async SYN timeout / RST */
  listen()
  incoming native IPv6 SYN

tcp_disconnect() has no assignment to icsk->icsk_af_ops, sk->sk_backlog_rcv
or tp->af_specific, and inet_listen() only requires SS_UNCONNECTED:

net/ipv4/af_inet.c:inet_listen() {
	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
		goto out;
}

which is what __inet_stream_connect() leaves behind after reporting an async
connect error or after an AF_UNSPEC disconnect.

On the accept side, only the mapped child helper assigns these fields; the
native IPv6 branch inherits them from the listener via
tcp_create_openreq_child()/sk_clone_lock():

net/ipv6/tcp_ipv6.c:tcp_v6_syn_recv_sock() {
	if (skb->protocol == htons(ETH_P_IP))
		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
					    req_unhash, own_req,
					    tcp_v6_mapped_child_init);
}

So wouldn't the accepted native IPv6 child run with icsk_af_ops ==
&ipv6_mapped, sk_backlog_rcv == tcp_v4_do_rcv and tp->af_specific ==
&tcp_sock_ipv6_mapped_specific, which is the same "IPv4 operations on an IPv6
flow" state the changelog describes?  Would placing the restore in
tcp_disconnect() (in addition to the connect path for the async failure case)
cover both transitions?

>  	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
>  		saddr = &sk->sk_v6_rcv_saddr;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919215234.3470646-1-benquike%40gmail.com
