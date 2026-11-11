Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428391;
	b=vfhBTo2dSai3AIGHQEtfMZLz2QWl6V3HUKKiclK15eFA2gEDKOUNrxMYJOMOfQqFehbN
	 +2kRNqw+B9EfgSHH9NMFgmxN5jy6OyUao9IPRTvQdd4l+wfN1TNw1Rw4ci0/Es0W5L63g
	 gt+QMD0CDjx/VYaon7ZM/BmPffBLOzQLDJ3Cg4OYMhTZSCR5poWF7hLikHWjFVSS52T4f
	 CMwRH1zhl157S5MAPVq7lFPlE/LH1tSo6jGHg3OR8Qoco2YrksNq3osceXFM/JhnBYiIN
	 1gPoGxJ1QIZfmLL7m0cH0rFRYDJo5AdpL8y5o25eD1BPBwN9zpOze/xMNRlFcdXF3aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428391;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=a+gesJPSmmndHlH+Ac7ljKzTorF0pDpjV1q4cg3H9YQ=;
	b=Lm8J3gnfqAH9G3+KYrJvsB6PLr9Y3nlPY23vQPz15od9zsKtx2fKfKwJuV9SNfziUf0k
	 zXjMlbIiZfy3ny0K21j2qO+5Fjef20THfhAvKrtCxHYP38H9B5RZB5utNiDZU4GbT8m+G
	 yqA50WzVJ40CNcyVpFSPAwMiXoG/kDsd3HFlj7PDxsI/uaN1S4oQvA4TXemAdVqdfWnAK
	 sN87LsGgvHwWXJsNFmSXyYdL2IxJBlRU9moS2uqYXch6AFsBcXdm0qGShaxq/7vRcHuJZ
	 CaNinRqQxxbrpgcJotetBm75PI+VthBeD4BTUg0xS5BaOVwb2pKzBxihuK+5dzrsK4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RG/EE9qj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83A606A31C;
	Wed, 11 Nov 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RG/EE9qj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6071F00A05;
	Wed, 11 Nov 2026 20:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428391;
	bh=a+gesJPSmmndHlH+Ac7ljKzTorF0pDpjV1q4cg3H9YQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RG/EE9qj/CkRU/Ooo+VZYRdY/UviBErQlWrHy47qg13eklvnei9W4t0Jz2yXVNFaX
	 RKe0gHWTi4qXDatxp8Rms51qY+uiLGIKxQLxA/JH7aplbLyWC/zifK0dEQXFEN32/g
	 MhcFoZxK0c5Vw2ZtLFLCMur09iX1DZX0lEsipxbgY6oETH3HQXkory9jEr8rwywOTu
	 hvwCE8tULwSYWFbDkAxapbdYo0lKv2jOaLQXblTQf+49I2ZUmn1JdnkXQd4U78/8Fa
	 m4IrOJOhokCSmxEnUgWu+0/x476zrt9hB8yuzHNS3sYk2lGrRyNRjovxUknNSHecsk
	 WaZP0MD/dsAhw==
Subject: Re: [PATCH net-next v3 2/4] ipv6: take fib6_sernum from a sequence
 shared by all netns
From: netdev-bot+sashiko@kernel.org
To: qiliang.yuan@linux.dev
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 20:19:50 +0000
Message-ID: <179442839004.2199510.6039710822182786717@kernel.org>
In-Reply-To: <20261109-bug-net-netns-move-rcu-barrier-v3-2-6084b02610b3@linux.dev>
References: <20261109-bug-net-netns-move-rcu-barrier-v3-2-6084b02610b3@linux.dev>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

ipv6: take fib6_sernum from a sequence shared by all netns

This patch makes fib6_new_sernum() take its values from one global atomic
sequence shared by all netns, which only hands out values from 2 up. The
goal is that a per-cpu nexthop route cached in one netns cannot match the
fib6_sernum of another netns after its device moves. Every netns still
starts its fib6_sernum at 1.

> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index e1d49897d6ab0..827051cbf7482 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -123,13 +123,23 @@ static void fib6_walkers_skip_rt(struct net *net, struct fib6_info *rt)
>  	fib6_walkers_replace_leaf(net, rt, next);
>  }
>  
> +/*
> + * Draw fib6_sernum bumps from one sequence shared by all netns, so that a
> + * route cached against one netns does not match the sernum of another one,
> + * e.g. after its device moved, until the sequence wraps. Every netns starts
> + * at 1 and the sequence only hands out values from 2 up: 0 means no sernum
> + * to check.
> + */
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
> +	atomic_set(&net->ipv6.fib6_sernum, new);
>  
>  	return new;
>  }

[Severity: High]
Is the value 1 still shared by every netns after this change?

inet6_net_init() in net/ipv6/af_inet6.c still does:

    atomic_set(&net->ipv6.fib6_sernum, 1);

The shared sequence never hands out 1. So a netns that has never changed
its fib6 tree stays at 1, the same value every other fresh netns starts
with.

The commit message says "Inserting a route bumps fib6_sernum, so the
routes a netns caches carry values drawn from the sequence". Does that
hold for routes cached while the insertion is still in progress?
fib6_add() publishes the route before it bumps the sernum:

fib6_add()
  fib6_add_rt2node_nh() / fib6_add_rt2node()
    rcu_assign_pointer(*ins, rt);
    inet6_rt_notify(RTM_NEWROUTE, rt, info, nlflags);
  fib6_purge_rt() for each entry on purge_list
  __fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));

In that window, a concurrent RCU-only lookup in netns A can find the new
nexthop route and go through
ip6_pol_route()->rt6_make_pcpu_route()->ip6_rt_pcpu_alloc(), which does:

    if (f6i->nh)
        pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));

If this is the first fib6 change in A, the cached value is 1.
rt6_get_cookie() then gives that value to a socket that connects at that
moment.

Once the bump happens the dst is invalid in A. But suppose the socket
does not send until the device has moved to a netns B that has never
changed its fib6 tree. rt6_is_valid() then evaluates this as 1 == 1:

    return rt6->sernum == rt_genid_ipv6(dev_net(rt6->dst.dev));

and ip6_dst_check() accepts the stale dst. Could the socket in A then
keep sending through B's device until nexthop_free_rcu() releases the
per-cpu routes? None of this needs the sequence to wrap.

Both preconditions look reachable:

In A, the nexthop device only needs IFF_UP and IPv6 enabled. addrconf
adds no routes while the link is not ready (for example a veth with
carrier off), or for IFF_NO_ADDRCONF devices.

In B, disable_ipv6 makes addrconf_notify() stop before it adds any
route. An IPv6-disabled container netns therefore stays at sernum 1
for good.

The later patch in this series, "net: remove rcu_barrier() from
__dev_change_net_namespace()", does not close this window and may make
it longer. Nothing later in the series changes the initial value or the
order of publishing and bumping.

Would it make sense to also seed each netns's initial fib6_sernum from
fib6_sernum_seq in inet6_net_init()? Alternatively, could the sernum be
bumped before the route becomes visible to readers?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-bug-net-netns-move-rcu-barrier-v3-0-6084b02610b3%40linux.dev
