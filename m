Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3534A8A3E;
	Sun,  4 Oct 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147652; cv=none; b=cHfelJklW5WyzanCc01kZp5tUlExgmUgX7aKeuH0DHU0cr528Dljv4AfhIIXsA5ahs5CKfsJIo4KgEVVSLSEg+hKk7KKhTKFSYDdbEQKsYDif316U+CnPTu3JcWgVInQSdeSV2K6Dzm/R4vTuocH8V/qVCnPcri25ZoMCdIX0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147652; c=relaxed/simple;
	bh=AmYwtjuAWh4Cv6ydZcpxBYOZiAwGXn5Ia9HHLqAwvPs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xh2zGi6Wpb9f6w+hI4WwVmcim6/QXAYBhq1mqAwh0i1EsZsjfBqWpz9ni68Y+a+vhjRXK26OsUg9HL91JloHxqP0GZyw7FIB64ATefZXn7fUcKY6lTFMgSuixPCzw+APNxMYivNl3LM39ge4ft5Wxgno2jSvPD+nJ7beCmXYLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHsTB43x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHsTB43x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F180F1F00893;
	Sun,  4 Oct 2026 21:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147650;
	bh=/Vb0LNDb5n+N/Q6+m6TY94qyHacC75xcz/dqQfc3w3A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FHsTB43xysHv1/4A9X0cMWZ5fdwgLw+z8R+5tMqtPFvHJWDwxlWPJ1Xlg7RCPqiVO
	 bmC4JDAbkuSf9zB4aQE362c65PYLny7leUnJpFxrbC3ZXl8vjQFzbBHjN8d1q+FmRB
	 qbP7ZfijkHRFoZVjksjzyPJeaVfiiiYMOM3Hnj9OqdTFCf0yBJDgMbS47TcaNNYkmy
	 Rh8cT4ujqY2qFgrgTyqg96t901XDiNl6xNji4tE3OPw7Yc1iaJhoqEhSKKIaqsKTSx
	 KnSia4k/wp8ASfC7iur+nX7A8BBmhunMKvWmFoBNfJnuvKnFqyOGzCp81p8JPtNZjh
	 JhW8Pf3+l8GdQ==
Subject: Re: [PATCH net-next v5 12/14] ip6_tunnel: make ip6_tnl_xmit() return
 a drop reason
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 21:00:49 +0000
Message-ID: <179114764950.434549.13525459501912673806@kernel.org>
In-Reply-To: <20260930183910.3151873-13-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-13-littlesmilingcloud@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In net/ipv6/ip6_tunnel.c, ip6_tnl_xmit() reports
  SKB_DROP_REASON_DEV_READY every time ip6_tnl_xmit_ctl() refuses a…
- [Low] ip6_tnl_start_xmit() (net/ipv6/ip6_tunnel.c:1487-1488) now
  reports SKB_DROP_REASON_RECURSION_LIMIT when ip6_tnl_addr_conflict()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but on a
  collect_md ip6gretap device, ip6gre_xmit_ipv6()…

--

ip6_tunnel: make ip6_tnl_xmit() return a drop reason

This converts ip6_tnl_xmit(), ipxip6_tnl_xmit(), __gre6_xmit() and the
ip6gre_xmit_*() helpers to return an enum skb_drop_reason instead of 0,
-1 or an errno. ip6_tnl_start_xmit() now frees the skb with the returned
reason. The -EMSGSIZE checks that trigger ICMP errors now check for
SKB_DROP_REASON_PKT_TOO_BIG instead.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index ba080a58ecb2d..9e94ea6b6c20f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c

[ ... ]

> -static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
> +static inline enum skb_drop_reason ip6gre_xmit_ipv6(struct sk_buff *skb,
> +						    struct net_device *dev)
>  {
>  	struct ip6_tnl *t = netdev_priv(dev);
>  	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
> +	enum skb_drop_reason reason;
>  	int encap_limit = -1;
>  	struct flowi6 fl6;
>  	__u8 dsfield = 0;
>  	__u32 mtu;
> -	int err;
>  
>  	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
> -		return -1;
> +		return SKB_DROP_REASON_RECURSION_LIMIT;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does
this check drop valid traffic on a collect_md ip6gretap device?

In collect_md mode t->parms.raddr is ::. The real endpoint is taken from
the tunnel metadata later, in __gre6_xmit():

	fl6->daddr = key->u.ipv6.dst;

Take an inner IPv6 packet whose source is ::, for example a DAD neighbour
solicitation or an MLD report sent before a link-local address exists.
Suppose it is bridged into the tunnel and tc tunnel_key or BPF gives it
valid IPv6 transmit metadata. It matches ipv6_addr_equal(::, ::) here and
is dropped before __gre6_xmit() can use the metadata destination.

ip6erspan_tunnel_xmit() does the same raddr == saddr check only in its
non-collect_md branch. Should ip6gre_xmit_ipv6() also skip the check when
t->parms.collect_md is set?

This patch only turns "return -1" into SKB_DROP_REASON_RECURSION_LIMIT. The
commit message also notes that these packets were dropped before.

[ ... ]

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 52f6a38657b9f..7e444115f4314 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c

[ ... ]

> @@ -1192,8 +1203,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	if (use_cache)
>  		dst = dst_cache_get(&t->dst_cache);
>  
> -	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
> +	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr)) {
> +		reason = SKB_DROP_REASON_DEV_READY;
>  		goto tx_err_link_failure;
> +	}

[Severity: Low]
Is SKB_DROP_REASON_DEV_READY the right reason for every refusal from
ip6_tnl_xmit_ctl()?

ip6_tnl_xmit_ctl() returns 0 in three cases:

- the local address is not configured yet,
- the remote address is found on this node,
- the tunnel lacks IP6_TNL_F_CAP_XMIT for the given addresses.

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit_ctl() {
    ...
		if (unlikely(!ipv6_chk_addr_and_flags(net, laddr, ldev, false,
						      0, IFA_F_TENTATIVE)))
			pr_warn_ratelimited("%s xmit: Local address not yet configured!\n",
					    p->name);
		else if (!(p->flags & IP6_TNL_F_ALLOW_LOCAL_REMOTE) &&
			 ...
			pr_warn_ratelimited("%s xmit: Routing loop! Remote address found on this node!\n",
					    p->name);
    ...
}

The kernel-doc in include/net/dropreason-core.h describes DEV_READY as:

 * @SKB_DROP_REASON_DEV_READY: the device is not ready to xmit/recv due to
 * any of its data structure that is not up/ready/initialized,
 * e.g., the IFF_UP is not set, or driver specific tun->tfiles[txq]
 * is not initialized

That description covers only the first case. The routing loop case is
closer to SKB_DROP_REASON_RECURSION_LIMIT, which ip6_tnl_xmit() already
uses for tdev == dev.

As a result, a tunnel whose remote address is local shows up in
drop_monitor or skb:kfree_skb as a device that is not ready. Later in the
series, ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit() use the same
mapping when ip6_tnl_xmit_ctl() fails.

The commit message acknowledges this and leaves the split for a follow-up.
Could ip6_tnl_xmit_ctl() return a reason as part of this series instead?

[ ... ]

> @@ -1462,27 +1484,31 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		ipproto = IPPROTO_IPIP;
>  		break;
>  	case htons(ETH_P_IPV6):
> -		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb)))
> +		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb))) {
> +			reason = SKB_DROP_REASON_RECURSION_LIMIT;
>  			goto tx_err;
> +		}

[Severity: Low]
Does RECURSION_LIMIT describe these drops on a tunnel that has no fixed
exit point?

On collect_md devices and NBMA ip6tnl devices, t->parms.raddr is ::. So
ip6_tnl_addr_conflict() matches every inner IPv6 packet whose source is
::. The raddr == saddr check in ip6gre_xmit_ipv6() above behaves the same
way on a collect_md ip6gretap device.

The kernel-doc for this reason says:

 * @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device, e.g. a
 * tunnel whose route to its remote end goes out of the tunnel device
 * itself.

On the IPv4 side it is only used for the tdev == dev route loop. A packet
from :: on such a tunnel is not a loop.

The commit message acknowledges this and says the reason "names the check
that drops them".

The next patch, "ip6_gre: add drop reasons to the transmit path", only
reclassifies ip6gretap packets without IPv6 tunnel metadata, as
SKB_DROP_REASON_TUNNEL_TXINFO. Packets from :: that do carry metadata are
still reported as RECURSION_LIMIT.

Could packets from :: be reported under a different reason on tunnels
whose raddr is ::?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930183910.3151873-1-littlesmilingcloud%40gmail.com
