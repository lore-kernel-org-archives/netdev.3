Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550645;
	b=FN9eOaSzd3j4FFmhtIXofw9xkMmnTuDQ6NXbA4hrjHOhywORNPZwhQALZSQh7BJWagM7
	 BNQI7Ey2MgpRcZMChH4leSWMe7ofmmDPJCJSJLMx+TYVKvKdg4hPraPWVCsdwj3rRn/3l
	 6yHCxICqBk7mkVMEK6ehGEs3lWL2v38qiVwChZqjw/4T5lOoDnvRmE0fJd9VydC8Mk15p
	 lNjk2FlcdqQdAakIKXpGdjvp+CqmPYKiuA9zNWYEPzFERoyVlsac8O6bziK46ahD9E3tX
	 NvdkItFbSW81UkHE1oh9LDOILq72QPU50LuEwmaL1LGlWfJNoDq8rrLj//wtPtnKb7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550645;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fhXwTLayHhEjfuB8H6CpJD9JxBRYQxQI/6yoeaD4A9s=;
	b=n1tQvILHM+Wt91lTt/jgEhnmSeaGyD5y2bxd0W+1XeIZlzdDylnJmRQ9rDDpFzAuTwwu
	 1I9BuMlF7TX2ptbt2HIroYp6IK4Tz12puk/cy2SOZut7AIXT9L8BbYanS317bytvYuQm1
	 wnfZoQ4YtQVdD4SUuFSq72KTC4IcB44XPTcmywmJpDCOyN6FiyD45XoIcHt3vmm5n6HgX
	 utQYS843fk9ng+GAor8EBrZ2EIQPmeIqQumSRJbRQobEoCvbs04wDZXmwHeM20bna3Tmr
	 Bab4agyR2hn5M1UwCRK4Irj0abktx8zTt/5y7XqbihYulqdFduhk/+De5qlv98QkHAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcQ9Hdqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12B606A325;
	Wed, 21 Oct 2026 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcQ9Hdqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EE91F000CB;
	Wed, 21 Oct 2026 02:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550644;
	bh=fhXwTLayHhEjfuB8H6CpJD9JxBRYQxQI/6yoeaD4A9s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kcQ9HdqyTDWt3Cc5wPm6lO4giqL7/MLpascGT5xg+qGIgM4TAgpLXZ3ihrsgyPa4n
	 mycZNN160zIVb/vSCM09xYWVq3Z1UX8CS4ZuddVHwKy4GjzOD7SKtFGSyW1ctxYfEn
	 mwXz1q9piSal6aquXSyuDk2v2Pr+HE8TebJOMBXUlbtt1ZIdT4TBHbBxj9l4KnPBVH
	 H5EmxlUGzCza7bK2TrN6LWwiDjQRgOsTDwMaPkjmx/HUiRsFRwvLa1bPa8GdglU3e5
	 5x0+Uzwh32Mr/EkHEKXmd8NwFs5P3zPMvkY1Buf8jlkhsFkafqWYwd07ol1XYznnyv
	 0ApNbFkZ5jwBg==
Subject: Re: [PATCH net-next v2 2/3] ipv6: take fib6_sernum from a sequence
 shared by all netns
From: netdev-bot+sashiko@kernel.org
To: odys.yuan@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 02:44:03 +0000
Message-ID: <179255064369.3135.12582761962798145012@kernel.org>
In-Reply-To:
 <20261019-bug-net-netns-move-rcu-barrier-v2-2-b6eb7780c492@gmail.com>
References:
 <20261019-bug-net-netns-move-rcu-barrier-v2-2-b6eb7780c492@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] fib6_new_sernum() (net/ipv6/ip6_fib.c) now takes every
  fib6_sernum value from one global 31-bit sequence, fib6_sernum_seq.
- [Medium] Every netns still starts at the same constant 1
  (`atomic_set(&net->ipv6.fib6_sernum, 1)` in inet6_net_init,…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  leans on it.

--

ipv6: take fib6_sernum from a sequence shared by all netns

This patch changes fib6_new_sernum() so that it takes values from one
global atomic sequence shared by all network namespaces. Before, each
netns had its own counter. The goal is that a per-cpu nexthop route cached
in one netns can no longer pass rt6_is_valid() against the sernum of the
netns its device moved to.

> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 0dc6ebee6e568..28d20d6def401 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -89,13 +89,22 @@ static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
>  	write_unlock_bh(&net->ipv6.fib6_walker_lock);
>  }
>  
> +/*
> + * Draw fib6_sernum bumps from one sequence shared by all netns, so that a
> + * route cached against one netns never matches the sernum of another one,
> + * e.g. after its device moved. Every netns starts at 1 and the sequence only
> + * hands out values from 2 up: 0 means no sernum to check.
> + */

[Severity: Medium]
Every netns still starts with the same value in inet6_net_init():

net/ipv6/af_inet6.c:inet6_net_init() {
    ...
	atomic_set(&net->ipv6.fib6_sernum, 1);
    ...
}

So 1 is the one value that can still be shared across namespaces. The
commit message relies on two ordering claims to rule this out:

  "Every netns bumps its fib6_sernum when a route is inserted, so before
  a route through it can be cached, and the new netns does so before the
  moved device can transmit, when NETDEV_UP adds a route through it."

Are both of these claims true?

In fib6_add(), fib6_add_rt2node() publishes the route to RCU readers
first:

	rcu_assign_pointer(rt->fib6_node, fn);
	rcu_assign_pointer(*ins, rt);

The sernum is bumped only after that, back in fib6_add():

	__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));

Could a concurrent lookup on another CPU reach ip6_rt_pcpu_alloc() in
between and record the pre-bump value?

	pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));

For the first route insert in netns A, that value would be 1.

On the destination side, addrconf_notify() can skip route insertion on
NETDEV_UP:

	case NETDEV_UP:
	case NETDEV_CHANGE:
		if (idev && idev->cnf.disable_ipv6)
			break;

		if (dev->priv_flags & IFF_NO_ADDRCONF) {
			...
			break;
		}

It also skips when addrconf_link_ready() fails. In those cases netns B can
still be at 1 when the moved device first transmits.

Would a socket in A that cached the nexthop route with sernum 1 then pass
rt6_is_valid() against B's 1? If so, it would keep sending through the
device that now belongs to B.

Would seeding each netns's initial fib6_sernum from fib6_sernum_seq close
this?

> +static atomic_t fib6_sernum_seq = ATOMIC_INIT(1);
> +
>  static int fib6_new_sernum(struct net *net)
>  {
> -	int new, old = atomic_read(&net->ipv6.fib6_sernum);
> +	int new, old = atomic_read(&fib6_sernum_seq);
>  
>  	do {
> -		new = old < INT_MAX ? old + 1 : 1;
> -	} while (!atomic_try_cmpxchg(&net->ipv6.fib6_sernum, &old, new));
> +		new = old < INT_MAX ? old + 1 : 2;
> +	} while (!atomic_try_cmpxchg(&fib6_sernum_seq, &old, new));

[Severity: Medium]
Does the "never matches" guarantee in the comment above still hold once
fib6_sernum_seq wraps from INT_MAX back to 2?

Netns A keeps the same value s for as long as its tree does not change.
Nexthop routes newly cached there keep copying s in ip6_rt_pcpu_alloc().

Meanwhile the shared counter advances on every fib6_add()/fib6_del(),
fib6_flush_trees(), nexthop update and PMTU exception insert in any netns.
The PMTU case goes through rt6_insert_exception()->fib6_update_sernum(),
and a remote host can trigger it with ICMPv6 Packet Too Big.

After INT_MAX - 1 draws, s is handed out again. It could go to netns B,
for example through the NETDEV_UP route insert after a device moves from
A to B.

rt6_is_valid() only compares integers:

	return rt6->sernum == rt_genid_ipv6(dev_net(rt6->dst.dev));

and ip6_dst_check() accepts the dst on that result alone:

	if (rt->sernum)
		return rt6_is_valid(rt) ? dst : NULL;

If this happens before nexthop_free_rcu() releases A's per-cpu routes,
could a socket in A keep transmitting through the device that now belongs
to B?

Before this patch, no other netns could advance A's or B's counter. Now
any netns can push the shared sequence through its cycle. That includes
a netns owned by an unprivileged user namespace that loops
RTM_NEWROUTE/RTM_DELROUTE.

The commit message doesn't mention this limit. The next patch in the
series, "net: remove rcu_barrier() from __dev_change_net_namespace()",
appears to rely on the same guarantee and leaves fib6_new_sernum()
unchanged.

To get the guarantee the comment describes, would the cached route need to
be bound to its netns, or would a wider generation counter be needed?

> +	atomic_set(&net->ipv6.fib6_sernum, new);
>  
>  	return new;
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Still,
the new scheme depends on rt6_is_valid() correctly reading the netns that
the device belongs to right now, and rt6_is_valid() uses plain dev_net()
with no RCU protection:

	return rt6->sernum == rt_genid_ipv6(dev_net(rt6->dst.dev));

ip6_dst_check() calls it before taking rcu_read_lock():

	if (rt->sernum)
		return rt6_is_valid(rt) ? dst : NULL;

	rcu_read_lock();

The IPv4 counterpart, rt_is_expired(), does this read under RCU:

	rcu_read_lock();
	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
	rcu_read_unlock();

ip6_dst_check() is reached from sk_dst_check(), which gets the dst through
sk_dst_get(). That helper drops RCU before ->check() runs, for example on
udpv6_sendmsg()->ip6_sk_dst_lookup_flow(). The dst keeps the net_device
alive, but not the netns behind dev->nd_net.

Suppose the reader is preempted after loading nd_net, and in the meantime
the device leaves that netns and the netns is torn down. Could the reader
then read net->ipv6.fib6_sernum from freed memory?

Would it make sense to use rcu_read_lock() and dev_net_rcu() here, as the
IPv4 side does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492%40gmail.com
