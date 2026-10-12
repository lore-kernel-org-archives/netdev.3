Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D87436342;
	Mon, 12 Oct 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787889; cv=none; b=q8YmiBIQ2LSyyzqGO1dhz/jwGLkw8sQ5tzacIoIAhd80139NsTsZtT2QpWL6SDMRUYPGAPZhDu8h6DW1Hnb9gbr7fLA2KL+TjYRbM9yDor6sulV5csZ0f1sXw7x7MGH3zxwh/cX1M2OIu5cx2nrFW47Xbpq2fVWAC7mOHga93sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787889; c=relaxed/simple;
	bh=3x86HOaid5phZn9yWU7+rGrrQ8f2kSVS26tPNLF3osA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kahVVxkzIi6RNFSiTqLB4yDEqnV0+xeunZ6kmAbyYuTW29CbmvB5e8wPdDt4Qb0piywfXeoX85wMbPJMka3NVKMHxjjG8rDCFxQIDPVh38EAbF6ebKYt2psSYovkHsQ9883Yl1/BoS6Il+A3U8XZUFHzCEAz43NMad2HmNBw820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPNwQBDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPNwQBDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD711F00A03;
	Mon, 12 Oct 2026 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791787888;
	bh=d0bqOzBYKtyA1jK2xDfhREu7EpQBQ1ZyUVFYr5hAH90=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JPNwQBDy9V9ddPd4TKt3f34w3MF7/VOPCRhh/qOgGcMv02Hvya3kgAAhEmdbr+ZuG
	 w8OfWj1qdaaxmYW//G4rrx0U8axKUZE/N2Fu1elstGuAk5BvN5f3ls1xmu2ya2FG5/
	 HDPIMMCmMccQt1OKRbVkC4xA9DIxaBncd5CG987/ThtUQ2xKuv8VzSdG8Zsile4kTX
	 M5HNCNcNXopGLU6GOgiWjf4ps4h6ZiobwgMCnV9JUCuSIbkGdaHzJG98/ilVzaPUYS
	 n5U1hq3XRzndalkyxZin9JaAlUojoHKCUd0k1ofX1ARW3tcjjpMUfSp+fjiqsfaaao
	 OmSF4fKxVDF1w==
Subject: Re: [PATCH] ipv6: Protect the cork MTU read with RCU
From: netdev-bot+sashiko@kernel.org
To: zzzccc427@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
 jjzuming@gmail.com
Date: Mon, 12 Oct 2026 06:51:27 +0000
Message-ID: <179178788715.434549.4247024578264579721@kernel.org>
In-Reply-To:
 <pm-ip-core-objects-candidate-0007-v2-46f5bb8aa2cc9824a047@gmail.com>
References:
 <pm-ip-core-objects-candidate-0007-v2-46f5bb8aa2cc9824a047@gmail.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] The new rcu_read_lock() in ip6_setup_cork() only helps if the
  final free of the old shared metrics is deferred by a grace period…

--

ipv6: Protect the cork MTU read with RCU

This patch wraps the MTU selection in ip6_setup_cork() in an RCU read-side
section. The goal is to keep a metrics image that is shared with a
Redirect-created exception alive until dst6_mtu() has finished reading
it. The target is a KASAN use-after-free in ip6_mtu() on the UDP send
path, seen when a Packet Too Big update and route deletion run at the
same time as the send.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 5509650589915..0440acc3dec0b 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1421,12 +1421,14 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
>  	v6_cork->hop_limit = ipc6->hlimit;
>  	v6_cork->tclass = ipc6->tclass;
>  	v6_cork->dontfrag = ipc6->dontfrag;
> +	rcu_read_lock();
>  	if (rt->dst.flags & DST_XFRM_TUNNEL)
>  		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
>  		      READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(&rt->dst);
>  	else
>  		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
>  			READ_ONCE(rt->dst.dev->mtu) : dst6_mtu(xfrm_dst_path(&rt->dst));
> +	rcu_read_unlock();

[Severity: High]
Does this fully close the window the commit message describes? The
message names the defect as "The MTU helper's existing RCU section
starts after the raw metrics read". The helper itself is not changed:

include/net/ip6_route.h:ip6_dst_mtu_maybe_forward() {
    ...
	if (!forwarding || dst_metric_locked(dst, RTAX_MTU)) {
		mtu = dst_metric_raw(dst, RTAX_MTU);
		if (mtu)
			goto out;
	}

	mtu = IPV6_MIN_MTU;
	rcu_read_lock();
    ...
}

ip6_dst_hoplimit() in net/ipv6/ip6_output.c has the same shape:

int ip6_dst_hoplimit(struct dst_entry *dst)
{
	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);

	rcu_read_lock();
    ...

udpv6_sendmsg() calls it on the same send path and the same exception
dst. The call happens before ip6_make_skb() and without RCU held:

	if (ipc6.hlimit < 0)
		ipc6.hlimit = ip6_sk_dst_hoplimit(np, fl6, dst);

np->hop_limit defaults to -1, so this reaches ip6_dst_hoplimit(). Suppose
the PTB COW and route deletion from the commit message happen while the
sender sits between dst_metric_raw() and the read, for example while
preempted outside any RCU section.

Can the sender then read RTAX_HOPLIMIT, not RTAX_MTU, from the freed
kmalloc-96 metrics? Raw, ping and l2tp_ip6 senders call the same helper.

Other dst6_mtu() callers that run without RCU look exposed too. One
example is tcp_v6_mtu_reduced() in net/ipv6/tcp_ipv6.c:

	dmtu = dst6_mtu(dst);

It runs from tcp_release_cb right after inet6_csk_update_pmtu() may have
COWed the metrics.

Would it be better to widen the RCU section inside
ip6_dst_mtu_maybe_forward() and ip6_dst_hoplimit() so it covers the
dst_metric_raw() read, instead of adding it at single call sites?

[Severity: High]
The commit message says:

    Since COW replaces the metrics pointer before route deletion, the
    existing FIB and destination RCU callbacks must wait for this read
    before releasing the remaining old metrics owners.

Does anything enforce that ordering? __ip6_rt_update_pmtu() in
net/ipv6/route.c COWs the metrics on any RTF_CACHE dst and never checks
rt->from:

	if (!rt6_cache_allowed_for_pmtu(rt6)) {
		rt6_do_update_pmtu(rt6, mtu);

So the COW can run on an exception that route deletion has already
purged. One way is inet6_csk_update_pmtu() or skb_dst_update_pmtu()
acting on a dst that is still held. ip6_dst_ifdown() clears rt->from and
releases the fib6_info, but dst->_metrics still points at the shared
image.

First ordering: the route is deleted, and fib6_info_destroy_rcu() drops
the FIB's metrics reference. The exception dst now holds the last
reference. A COW then frees the old image synchronously in
dst_cow_metrics_generic():

	} else if (prev & DST_METRICS_REFCOUNTED) {
		if (refcount_dec_and_test(&old_p->refcnt))
			kfree(old_p);

Can a sender inside the new rcu_read_lock() section in ip6_setup_cork()
load old_p just before this and then read freed memory? A read-side RCU
section cannot delay a plain kfree().

Second ordering: route deletion queues call_rcu_hurry(&f6i->rcu,
fib6_info_destroy_rcu) before the sender enters rcu_read_lock(). The
sender then loads the old pointer, which dst->_metrics still publishes.
A later COW drops the dst's reference from 2 to 1.

The grace period started before the sender's read-side section, so it
does not wait for the sender. Could
fib6_info_destroy_rcu()->ip_fib_metrics_put() then kfree() the metrics
while ip6_mtu() is still reading them?

dst->_metrics is not an RCU-published pointer. ip_fib_metrics_put(),
ip_dst_metrics_put() and dst_cow_metrics_generic() all free immediately.

For the reader-side section to be enough, would the metrics need
RCU-deferred freeing, such as kfree_rcu() in those put and COW paths? The
alternative would be to enforce the COW-before-purge ordering.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-ip-core-objects-candidate-0007-v2-46f5bb8aa2cc9824a047%40gmail.com
