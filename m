Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804A28850E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434913; cv=none; b=gf1EpkBlxobypYrcWLPkz4UM5+xDDiy08cu6A5HJhpGHlDEuVuOMNcNsu7UI1MxPMq3lGsslM1MscY0qdf2sQBcuo6zd0cqe4zY7FF3j1ZqM50IbgK09Z8vitlEDNjFpPukl1GYJReE3dXQEuohu1Cq5U2P7zFcyewwn2zYRoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434913; c=relaxed/simple;
	bh=yxV7FBrxX8wHYR7ZP5Urfpwltel+BQ7pLEm2sl4Wexk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i60mrSZTJUV6tIe1uC1JrEqxwMBX2oARi7T3xQLnTnBGgt2UNCQt4dcW0a4AXMj0oJaXEht54yMVDb4VNb0ruIrGFsMLHc1SDHtecL2nO70nbUUSBD0woFxI+XGoQa8wDa4JN/71E6XMIqFDLwbu62aFLykXfPrxL9ZEOYpOEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz/jSaoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz/jSaoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F33A1F000FF;
	Tue, 15 Sep 2026 01:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434911;
	bh=sSnvvZwI3anNxAaD3nlACFzAbgpk5wpjr8MLICMnEaU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hz/jSaoJLM6F8WOjNzGwlweKjSE3uhOWpacX6VC00Jy98U4YOEc961EduvOAsFKUz
	 TBRkbbhoV7yBBFshQbH20QLc/f8YMn0aH1GSnCPXfwGWcpMFNwE9F50EElHK4Pi4Ye
	 DjW3ZMtqQZd1Of8533KIP1jkdipOHwl/lsdQbFRs3+YX3HTCOE9lJHXHshv1hUgh3G
	 KVwAwyQ9upEUdt2Gmh/SKcS0TcV++z0mDmQbA2oj51Goy7dppMg9qLgKPNcr+ABJCZ
	 MY5fk/wqJall82jUbNo7bEC++sPKQEN41eak4W6eNMVpYrDZ9x2h6aWpTRNDBPCIiY
	 cwIhEITXiVbFw==
Subject: Re: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for
 close()d listener in tcp_v6_do_rcv().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, tarasmadan@google.com
Date: Tue, 15 Sep 2026 01:15:10 +0000
Message-ID: <178943491051.22033.2295775938786012621@kernel.org>
In-Reply-To: <20260914011420.115556-1-kuniyu@google.com>
References: <20260914011420.115556-1-kuniyu@google.com>
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

- [High] Incomplete fix / residual TOCTOU race in tcp_v6_do_rcv(): the
  new guard is a state *blacklist* (`!((1 << sk->sk_state) &…

--

tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().

The patch extends the guard in tcp_v6_do_rcv() so that
skb_clone_and_charge_r() is skipped for TCP_CLOSE in addition to
TCP_LISTEN, closing the window where a concurrent close() turns a listener
into TCP_CLOSE while the lockless listener path is running.  The commit
message notes this is safe for non-listeners because tcp_rcv_state_process()
drops the skb for TCP_CLOSE.

No Link: tags are present in the commit header.

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index df9c29eb5c1f4..7fa4ed2fd4f16 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1604,7 +1604,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	   by tcp. Feel free to propose better solution.
>  					       --ANK (980728)
>  	 */
> -	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
> +	if (np->rxopt.all &&
> +	    !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
>  		opt_skb = skb_clone_and_charge_r(skb, sk);

[Severity: High]
Is TCP_CLOSE the only other state the lockless listener path can observe
here?

tcp_v6_rcv() calls tcp_v6_do_rcv() without taking the socket lock when it
samples TCP_LISTEN:

net/ipv6/tcp_ipv6.c:tcp_v6_rcv() {
	...
	if (sk->sk_state == TCP_LISTEN) {
		ret = tcp_v6_do_rcv(sk, skb);
		goto put_and_return;
	}

	sk_incoming_cpu_update(sk);

	bh_lock_sock_nested(sk);
	...
}

Only a socket reference is held across that call, so nothing pins
sk->sk_state while tcp_v6_do_rcv() re-reads it.  Can user space move the
same socket further than TCP_CLOSE inside that window?  inet_shutdown() on
a listener falls through to sk->sk_prot->disconnect(), i.e. tcp_disconnect()
-> tcp_set_state(sk, TCP_CLOSE), and a following connect() on the still-open
fd sets TCP_SYN_SENT.

If TCP_SYN_SENT (or later TCP_ESTABLISHED) is what gets loaded at the new
check, the blacklist passes and skb_clone_and_charge_r() runs with no socket
lock again:

include/net/sock.h:skb_clone_and_charge_r() {
	skb = skb_clone(skb, sk_gfp_mask(sk, GFP_ATOMIC));
	if (skb) {
		if (sk_rmem_schedule(sk, skb, skb->truesize)) {
			skb_set_owner_r(skb, sk);
	...
}

sk_rmem_schedule() and skb_set_owner_r() -> sk_mem_charge() ->
sk_forward_alloc_add() perform a non-atomic read-modify-write of
sk->sk_forward_alloc, which is the same accounting corruption behind the
inet_sock_destruct() "sk->sk_forward_alloc" warning quoted in the commit
message.

Would a positive condition be more robust than extending the blacklist,
for example bailing out of tcp_v6_do_rcv() when the lockless listener path
observes sk->sk_state != TCP_LISTEN?  That would also match the comment at
the top of the function:

	/* The socket must have it's spinlock held when we get
	 * here, unless it is a TCP_LISTEN socket.
	 ...
	 */

On the same window, does the TCP_ESTABLISHED fast path just below become
reachable without the lock as well?

	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
		struct dst_entry *dst;

		dst = rcu_dereference_protected(sk->sk_rx_dst,
						lockdep_sock_is_held(sk));

The lockdep_sock_is_held() assertion, the RCU_INIT_POINTER()/dst_release()
of sk->sk_rx_dst and tcp_rcv_established() all assume the socket lock is
held.

Should the state reads on this path also use READ_ONCE() (or
inet_sk_state_load()) instead of plain loads, given the socket lock is not
held?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914011420.115556-1-kuniyu%40google.com
