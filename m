Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550644;
	b=wI+0UAmZStJFWPE8aEWItUur1tQSxc+rkK74hp1+/oWl8rneNyfBC5K3KwMnq9RIziTB
	 PjsQQ1v65d8ORb1uhCOasTcfygk4D4b7OcwBDpaAg62rMrgA96bt9749FAzsuOEKmqIDu
	 O/8hCqThMChfVGyCiE/cAprQPZ+/fhCkwLopqkkmQs3YXRY8h1iDVeOl0kK1zvr5aRHns
	 mY+sWuQvYH66+4zuYL+pQULpHk0LvX3jtVJTTg38IRBNFT4rxhSqJwqhahtlzIlLLU1FJ
	 1PTONI3YWRTZtBiKTA+ce+DgZHUNdpdfTt3DNiYNOrtib1FAkb90Vky9/0dKP8X5xGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550644;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pvMWMt14YWUTlKsuuOS9brN/+GEAU/YOCzBR9QabAX4=;
	b=OvTpfWmDbisnPz8Z7HgnaB4D35JvY1HVmSM2/Owvp8QKinTM3kt1eIUh7pXxYhBiB/nK
	 eJpIHU62oYoKnk3LR7xcm2AID0vnj1d57/nTLHN0i8bSUnid7fWO0ErR5OTOrQmV/zAnq
	 CvWqgVbHjEH3cb8PCVlClw+4x1o+tyklqwPoUVhZj72ETY4M7Qlmmfa4RoRVOhk72sYff
	 qDaO1mxoNuEVz7Y7uBfMy0Ur0C41hywdq4DEf+b1xFTSBdgWHzFeTmRI8OzZSgUrT+oT4
	 3LcS5s1D0bdp1yxzJnhphi9Z3VXSC4JvMyCCyI/RiCy2XeZ9nN+OUdTNFpmnsBBqsWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGSIizvr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66B606A319;
	Wed, 21 Oct 2026 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGSIizvr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C551A1F000C9;
	Wed, 21 Oct 2026 02:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550643;
	bh=pvMWMt14YWUTlKsuuOS9brN/+GEAU/YOCzBR9QabAX4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZGSIizvrzRcR8g52cd07DadGtP30s08v0SHHDCS+XW0/Z3Ji0Wa2r5kr8/Xyrez4M
	 OUtPtEj+d0ce+PFUlgTrxmeVdjK8l8/huauA2YLOfaWiL1vfrgf+pfh0pBz9Im3NCp
	 GCQwTVGeaqoMabJ3f4KwVgNEOPbwJXQKY5rvTTvX8YVa6ljW36GkFv3Z9e3vWHromK
	 XObt7QWJxEqp993lhMfTVj2ezDQXtzQoaPIHYZIvj5ORfbxaB4WFWap/V9djHNE1Cf
	 BqDV/TmflGKAawHB0d5Ek0QlaAUPsrDT1L7WuceYL6d8jiURygADSoOeTe9xQjhxhw
	 pOO8Pk703erFw==
Subject: Re: [PATCH net-next v2 1/3] ipv4: draw rt_genid from a sequence
 shared by all netns
From: netdev-bot+sashiko@kernel.org
To: odys.yuan@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 21 Oct 2026 02:44:02 +0000
Message-ID: <179255064227.3135.1573234159062930165@kernel.org>
In-Reply-To:
 <20261019-bug-net-netns-move-rcu-barrier-v2-1-b6eb7780c492@gmail.com>
References:
 <20261019-bug-net-netns-move-rcu-barrier-v2-1-b6eb7780c492@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit says "a cached route never matches the rt_genid of
  the netns its device moves to".
- [Low] The comment added above rt_genid_seq in net/ipv4/route.c, and the
  commit message, say each netns "bumps on NETDEV_UP before any of its…

--

ipv4: draw rt_genid from a sequence shared by all netns

This commit stops incrementing rt_genid separately in each netns. Instead,
every bump takes its value from one global sequence that never returns 0.
The goal is that a route cached through a device can never match the
rt_genid of the netns the device moves into.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 595a3b7f17830..25bebbb30bf3c 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -393,6 +393,26 @@ static inline int ip_rt_proc_init(void)
>  }
>  #endif /* CONFIG_PROC_FS */
>  
> +/*
> + * Draw rt_genid bumps from one sequence shared by all netns. A route keeps
> + * the genid of the netns it was created in, and is checked against the netns
> + * its device is in now, so distinct values make that check fail once the
> + * device has moved. Every netns starts at 0, which the sequence never hands
> + * out, and bumps on NETDEV_UP before any of its devices can carry traffic.
> + */

[Severity: Low]
Is the last sentence of this comment accurate? The commit message makes
the same claim:

  "A netns bumps its rt_genid on NETDEV_UP before its devices can carry
  traffic"

In net/core/dev.c, __dev_open() marks the device up and activates it
before any notifier runs:

    netif_set_up(dev, true);
    dev_set_rx_mode(dev);
    dev_activate(dev);

netif_open() only sends NETDEV_UP after __dev_open() has returned:

    rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP | IFF_RUNNING, GFP_KERNEL, 0, NULL);
    call_netdevice_notifiers(NETDEV_UP, dev);

So rt_cache_flush() in fib_netdev_event() runs after the device can
already transmit.

The NETDEV_UP bump also doesn't always happen. For a device with no
in_device, for example one whose MTU is too small for IPv4,
fib_netdev_event() returns early:

    in_dev = __in_dev_get_rtnl(dev);
    if (!in_dev)
        return NOTIFY_DONE;

The nonzero genid on cached routes seems to come from the FIB insertion
paths instead, such as fib_table_insert()->rt_cache_flush() and the
NETDEV_UP case of fib_inetaddr_event().

The next patch in the series, "net: remove rcu_barrier() from
__dev_change_net_namespace()", depends on this invariant. Could the
comment and the commit message describe the ordering that actually holds?

> +static atomic_t rt_genid_seq;
> +
> +void rt_genid_bump_ipv4(struct net *net)
> +{
> +	int genid;
> +
> +	do {
> +		genid = atomic_inc_return(&rt_genid_seq);
> +	} while (!genid);
> +	atomic_set(&net->ipv4.rt_genid, genid);
> +}

[Severity: Medium]
The commit message says:

  "so a cached route never matches the rt_genid of the netns its device
  moves to."

Doesn't that only hold modulo 2^32? rt_genid_seq is one 32-bit atomic_t
shared by every netns, and rtable::rt_genid is an int. The loop only
skips 0, so values start repeating after 2^32 - 1 bumps.

Anyone who can create a user namespace and a netns can advance the
shared counter by writing /proc/sys/net/ipv4/route/flush. Each write
makes ipv4_sysctl_rtcache_flush() call rt_cache_flush(), and
sysctl_route_net_init() keeps the flush entry for netns owned by non-init
user namespaces:

    /* Don't export non-whitelisted sysctls to unprivileged users */
    if (net->user_ns != &init_user_ns) {
        if (tbl[0].procname != ipv4_route_flush_procname)
            table_size = 0;
    }

Suppose a route is cached in netns A with genid X, and its device then
moves to netns B. If B's genid equals X before
free_fib_info_rcu()->nexthop_free_rcu() gets to dst_dev_put(), the check
in rt_is_expired() passes:

    res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));

ipv4_dst_check() then accepts the dst, and the socket in A keeps sending
through a device that B now owns.

This is hard to hit, because B's bump has to land on the unknown X
within a few RCU grace periods. However, the follow-up patch "net: remove
rcu_barrier() from __dev_change_net_namespace()" removes the barrier. It
then relies on genid uniqueness alone to reject every FIB-cached route
through the moved device, not just routes that use nexthop objects.

Would an approach that doesn't depend on a wrapping 32-bit value work
here? For example, the move could invalidate the cached dsts, or call
dst_dev_put() on them, synchronously. Another option would be to check
the netns the route was created in.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492%40gmail.com
