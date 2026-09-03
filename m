Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362A4A8412;
	Thu,  3 Sep 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440714; cv=none; b=HFBYv77vkQYY5UpWwfL5kV8lqQ7muu8RDxpEcNw0BAfNTMZBmGuGLx4XH6KxDAC3OBi8MB0pOWo7hLoe1/ORri9Wh4xQIJEUayA4IIOeiH4upfWIqTG9KM9IvmE84hgwhuU+8c2TM6uyG8AfkkXgcJ9IUfFcOwQc0OUfbrLww0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440714; c=relaxed/simple;
	bh=X1ja7uOzseh34WQD5LZbgDwUjBCzajZavCXXbQDw+lc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdsNZyWGvxHa2bd9azQLL+X1MOKXb8CJdZ+JNWdp0Fy5QhdbO1D/5kSSPNZJvAPpMujfds8ZnzSd0JuOcdVfyFnFOYs6a2DhVX3IJ3LOsy5S52kJ2pebv2+POfNj6WRqXu4QtP1EWEPvB2vEnOogyMcTlmWq/l95DX7Y83Gx7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcCvnCb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcCvnCb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2BD1F000E9;
	Thu,  3 Sep 2026 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788440701;
	bh=NBFIdlZhoNHS7V/7H1aeWVlnB+a/lbyKOxUlbFXPXqs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QcCvnCb5mgJ7rIYOJYU3d8htkvl0n911ChMbzcRQBJluTSZiBB0dS4ems2n2hXt55
	 ZdUiQjtNnj5am9yJQagJqfI+aF4nWtEj2l6YOT3meYK+IuY715VYV1jsuTrXcVCfju
	 0/7tukmj4mIa3dQQ301k9hBCkjr2RXRrCAGMTxCHjhkIybjQgPRVCvOuyR3iapiNn+
	 fkIeHwi2MnuRreTu9jp9Kkx7aqPzBaNe4hXMXSl6kXlQ4bBdZ6YaGklf5lT8KSMAvg
	 nMXOka+/lXRMn9mDd7YI2HsctTVW8ACgdckMIXWfJj30UYvTbzgpielWXQ0oTe0GOQ
	 ZTiBOBKGwM86Q==
Subject:
 Re: [net,v3] udp: revalidate socket family before publishing an IPv6 cork
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com, vyasevic@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 13:05:00 +0000
Message-ID: <178844070069.3394541.5419916956797677793@kernel.org>
In-Reply-To: <20260902010408.1057857-1-4ncienth@gmail.com>
References: <20260902010408.1057857-1-4ncienth@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 0 · Low: 0

- [High] Incomplete fix: the sibling IPv6 socket-dst publisher in the
  connect() path is not covered, so an IPv6 dst can still be installed…
- [High] The fix is writer-side and after-the-fact, so the mixed-family
  socket dst it claims to eliminate remains observable by the unguarded…

--

udp: revalidate socket family before publishing an IPv6 cork

This adds a family recheck after the connected IPv6 route lookup in
udpv6_sendmsg(), another one after lock_sock() before the cork is
published, and a sk_dst_reset() in the UDP IPV6_ADDRFORM path once
PF_INET has been written.  The goal is to stop an AF_INET6 cork or an
IPv6 socket dst from surviving on a socket converted to AF_INET.

Closes: https://lore.kernel.org/netdev/20260825160630.1888866-1-4ncienth@gmail.com/
Link: https://lore.kernel.org/netdev/a86aa34a-8bea-46d2-a785-6c423ac00b1d@redhat.com/

A couple of questions about the two orderings the changelog says are
closed.

> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b4c977434c2e0..59ca446d3156b 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -611,6 +611,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  				WRITE_ONCE(sk->sk_prot, &udp_prot);
>  				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
>  				WRITE_ONCE(sk->sk_family, PF_INET);
> +				sk_dst_reset(sk);
>  			}

[Severity: High]
Can an IPv6 socket dst still be published after this reset by the
connect() path, which has no family revalidation?

inet_dgram_connect() in net/ipv4/af_inet.c resolves the protocol before
it can block, and says so:

	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
	prot = READ_ONCE(sk->sk_prot);
	...
	return prot->connect(sk, uaddr, addr_len);

So a connect() that already dispatched to udpv6_connect() sits in
lock_sock() while do_ipv6_setsockopt() performs the conversion above and
drops the lock.

__ip6_datagram_connect() in net/ipv6/datagram.c then resumes and checks
only the address family supplied by userspace and ipv6_only_sock(); it
never re-reads sk->sk_family after the lock was taken:

	if (usin->sin6_family != AF_INET6)
		return -EAFNOSUPPORT;
	...
	err = ip6_datagram_dst_update(sk, true);

and ip6_datagram_dst_update() ends with:

	ip6_sk_dst_store_flow(sk, dst, fl6);

That installs an rt6_info into sk->sk_dst_cache on a socket that is
already AF_INET/udp_prot, i.e. after the new sk_dst_reset() has run.  The
IPv4 consumer then takes it without any family test, in udp_sendmsg():

	if (connected)
		rt = dst_rtable(sk_dst_check(sk, 0));

Note the cookie 0 does not reject it for every route type, since
ip6_dst_check() short-circuits:

	if (rt->sernum)
		return rt6_is_valid(rt) ? dst : NULL;

and rt_genid_ipv6() is seeded from fib6_sernum, which starts at 1, so
pcpu routes of nexthop-object fib entries always carry a nonzero sernum.

Given that, is the claim in the changelog accurate?

  "Thus, if the send stores and checks first, the later conversion clears
  the cache; if conversion and its reset happen first, the send observes
  AF_INET after its store and clears it."

The reset here only orders against stores made by code that revalidates
the family; would a family recheck in __ip6_datagram_connect() after
lock_sock(), or a dst->ops->family check on the IPv4 consumer side, be
needed as well?

> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad5769..8ba552f1a6b26 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1705,6 +1705,12 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		dst = NULL;
>  		goto out;
>  	}
> +	if (unlikely(connected &&
> +		     READ_ONCE(sk->sk_family) != AF_INET6)) {
> +		sk_dst_reset(sk);
> +		err = -EAFNOSUPPORT;
> +		goto out;
> +	}

[Severity: High]
Is the mixed-family socket dst observable to a third thread in the window
between the store and this check?

The store happens inside the lookup just above, in
ip6_sk_dst_lookup_flow():

	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_dst);
	if (connected && !IS_ERR(dst))
		ip6_sk_dst_store_flow(sk, dst_clone(dst), fl6);

so in the "conversion wins first" ordering the sequence is:

CPU1 (setsockopt IPV6_ADDRFORM)
	WRITE_ONCE(sk->sk_family, PF_INET);
	sk_dst_reset(sk);

CPU0 (udpv6_sendmsg, connected == true)
	ip6_sk_dst_store_flow(sk, ...);	/* rt6_info now cached */
	<preemptible window, no socket lock held>
	READ_ONCE(sk->sk_family) != AF_INET6 -> sk_dst_reset(sk);

CPU2 (udp_sendmsg on the converted socket)
	rt = dst_rtable(sk_dst_check(sk, 0));

The IPv4 side has no family validation, unlike its IPv6 counterpart
ip6_sk_dst_check() which rejects a foreign entry outright:

	if (dst->ops->family != AF_INET6) {
		dst_release(dst);
		return NULL;
	}

Does that leave an rt6_info being used as a struct rtable, with an
IPv4-formatted skb reaching dst->output == ip6_output()?

The symmetric ordering also looks reachable: in do_ipv6_setsockopt() the
udp_prot, inet_dgram_ops and PF_INET writes are published before the new
sk_dst_reset(), and inet6_sendmsg() dispatches on the lockless read:

	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
	prot = READ_ONCE(sk->sk_prot);

Can a thread therefore enter IPv4 udp_sendmsg() and pick up the still
cached IPv6 dst before the reset runs, in which case the reset cannot
revoke the reference it already took?

Would validating the family (or performing the connected store) under
lock_sock, or adding a dst->ops->family check to the IPv4 path, cover
these two windows instead of the after-the-fact reset?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902010408.1057857-1-4ncienth%40gmail.com
