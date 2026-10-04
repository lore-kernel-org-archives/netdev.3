Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E33161BE;
	Sun,  4 Oct 2026 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147649; cv=none; b=t0t6gSoTR/zkmJbM2O6ySrhjoE5T1+Y9UfDJoQdBRWz8bhiWnI7ey2NtMCLu/iu9EhRAElu55CEjjyTdmkEi1GA56fJDgC8lprEf1QCWrqn3moOqTINoOy2MzTZT4uxWWIAlAotGGhMIvgP2LMdl5gMRHV/GWIOKgHD2gfmRbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147649; c=relaxed/simple;
	bh=xEBhRZVRhaqdwalcWkkvq3ZgG6IKQ00mG/x2j7ejy+8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LX9CRsmU96fBBy0Aba5TlkdLk+W1TQXUhXw1vE9PHP45wUml9/nu9pEVr4F82Zun/WuHDhIR74YooFc513dCsaQFR0A2R7RTtKPnTQ9/kr1w9itEgks7wLaeIv2Vx8I7lZNr2jPsMOpMUXfYU6MxFfvQ4xRqW8PtN15vGSAdTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKYp5qTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKYp5qTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E571F00893;
	Sun,  4 Oct 2026 21:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147648;
	bh=RqyZM75gcrO8EDODpBhPgqfbxfn238Sl94w56ECJskc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IKYp5qTIcEV6ZGC4+PA/S5qngt9bo8iT8j2p916HR3ESSjw5Xcw9lOhDqfysZunjM
	 xWnylsAQtXSvEOHzmgjDmuR8B54KbncXNjZ/4CUU32RQj/o3533V2SbbEp8cJgdBhJ
	 vk788IH+31hHcOmGG5ksy1GK3rjRgtmz14zo34Ph4RM+97uHxwR3+gpxy1wNoFH7kD
	 l21IGjB4/XAIzIB745SQGE3q4CGduzL111Bio5vKouNmo94OljsINNt4+On/DlUNiY
	 gOiSbJN9shKLrOQUCEmLtsR1rTuYQmKmuyvgW0ZEt1VR/6/RYPe2JJ4oFh+8pHSWkx
	 vKpdCFH4OSNWw==
Subject: Re: [PATCH net-next v5 05/14] ip6_tunnel: add drop reasons to the
 receive path
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 21:00:47 +0000
Message-ID: <179114764714.434549.10541167690659165045@kernel.org>
In-Reply-To: <20260930183910.3151873-6-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-6-littlesmilingcloud@gmail.com>
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

- [Low] In ipxip6_rcv() (net/ipv6/ip6_tunnel.c, line 978), every packet
  that ip6_tnl_rcv_ctl() refuses is now dropped with…

--

ip6_tunnel: add drop reasons to the receive path

This patch replaces the plain kfree_skb() calls in __ip6_tnl_rcv() and
ipxip6_rcv() with kfree_skb_reason(). Where possible it reuses the
reasons that ip_tunnel_rcv() and the length helpers already return. It
also gives the early drops in ipxip6_rcv() their own reasons.

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac017..52f6a38657b9f 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c

[ ... ]

> @@ -952,21 +965,30 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
>  	if (t) {
>  		u8 tproto = READ_ONCE(t->parms.proto);
>  
> -		if (tproto != ipproto && tproto != 0)
> +		if (tproto != ipproto && tproto != 0) {
> +			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
>  			goto drop;
> -		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
> +		}
> +		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
> +			reason = SKB_DROP_REASON_XFRM_POLICY;
>  			goto drop;
> +		}
>  		ipv6h = ipv6_hdr(skb);
> -		if (!ip6_tnl_rcv_ctl(t, &ipv6h->daddr, &ipv6h->saddr))
> +		if (!ip6_tnl_rcv_ctl(t, &ipv6h->daddr, &ipv6h->saddr)) {
> +			reason = SKB_DROP_REASON_DEV_READY;
>  			goto drop;
> +		}

[Severity: Low]
Does SKB_DROP_REASON_DEV_READY fit any of the cases where
ip6_tnl_rcv_ctl() refuses a packet?

include/net/dropreason-core.h documents it as:

	 * @SKB_DROP_REASON_DEV_READY: the device is not ready to xmit/recv due to
	 * any of its data structure that is not up/ready/initialized,
	 * e.g., the IFF_UP is not set, or driver specific tun->tfiles[txq]
	 * is not initialized

ip6_tnl_rcv_ctl() does not look at device state. It returns 0 in three
cases:

  - the tunnel has neither IP6_TNL_F_CAP_RCV nor a per-packet capability
    that allows receive for these addresses
  - laddr is not multicast and is not a non-tentative local address
  - raddr is local and IP6_TNL_F_ALLOW_LOCAL_REMOTE is not set

The IFF_UP example cannot apply either. ip6_tnl_lookup() only returns
tunnels that are already up:

ip6_tnl_lookup() {
    ...
		    !(t->dev->flags & IFF_UP))
			continue;
    ...
}

So dropwatch, drop_monitor and BPF users of skb:kfree_skb would report
a misconfigured endpoint, a missing capability, or a spoofed or looped
source as a device readiness problem.

The commit message says DEV_READY "describes only the first" case and
leaves a proper split for a follow-up. The later patches "ip6_tunnel:
make ip6_tnl_xmit() return a drop reason" and "ip6_gre: add drop
reasons to the transmit path" use DEV_READY the same way for
ip6_tnl_xmit_ctl(). By the end of the series, the DEV_READY kernel-doc
is still unchanged, but the series does update the docs for
TUNNEL_INVALID_HDR, TUNNEL_NOT_FOUND and RECURSION_LIMIT.

Would it be better to widen the DEV_READY kernel-doc, or to add a
tunnel address/capability reason for these call sites?

> -		if (iptunnel_pull_header(skb, 0, tpi->proto, false))
> +		reason = iptunnel_pull_header(skb, 0, tpi->proto, false);
> +		if (reason)
>  			goto drop;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930183910.3151873-1-littlesmilingcloud%40gmail.com
