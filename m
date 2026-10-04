Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295C30D41F;
	Sun,  4 Oct 2026 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147648; cv=none; b=D7UiFQoC1wAkO3f/JYJsrX4iRhGWFx3UAFUZLjQdBdWVtjVn53HaCvKETGGFxhNztYAo1uaSN4mOBM/u1TxzSMvHD/Zaf728HG9ktiIPo3evSoLuFSySwjJtfoXFPucEbyNjlAzyZZZFydgnZRimLywrvKWIv84fAN6F/E3PNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147648; c=relaxed/simple;
	bh=nZ18ZPCAW9/6X4VvdjQu2sUY3F3ig2qNVltZnLDQ9O0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmQlzRpXEnTC7mtPFbbuhsUnN2hw216haRbEHtioCPnRCKbvXGDHawDCHppdSBCXN2Hx9+dAUlxCtL7oclu+kcP9q04eA4aolmTs0YUUt3RpylYO9d4z7auYPJMp881649o0/diQXEjnMxJbBTblpC/RoNwSZscTFLPSoF639kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpTXxYxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpTXxYxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7381F000FF;
	Sun,  4 Oct 2026 21:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147647;
	bh=RC1yc6hXsA0c3ASRol8ZG9T26SGtytDAHnSJ6UVwfGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XpTXxYxif3vy2CVmABPvTHroX1a98DEcm7BFHVjxnUenAdOC5QU7+m1Q/ODjKEh3q
	 lv8ZFKL16R2M2dzU0LBGKR29+Ep33Te/ZtUsK8tG6SwZ6KapWpqDtcBu4g9vUNO4gQ
	 h0aJhqVgDyRJtWiPo7NvEGbE1ymA+rJqLKQw+N2eSotmzNDPTAv+kodpNWR4uZOe96
	 +EE6+YjutIxIkOG9jC6cqCaY1QgM1FF2o5l4m6r4ClPDvR1HEXxEqb7oAKGjJeLfs8
	 fY92OrSyy6nEHbtppVCuoYd4Duy19/e0nIlWSs6xCp9D6b3udhMxg/SXjVsCTl+6cr
	 IMJKJ70Kq1teA==
Subject: Re: [PATCH net-next v5 02/14] ip_tunnel: make
 __iptunnel_pull_header() return a drop reason
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 21:00:45 +0000
Message-ID: <179114764588.434549.11011384832570880257@kernel.org>
In-Reply-To: <20260930183910.3151873-3-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-3-littlesmilingcloud@gmail.com>
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

- [Low] At this commit, vxlan_rcv() in drivers/net/vxlan/vxlan_core.c
  still ignores the drop reason that __iptunnel_pull_header() now…

--

ip_tunnel: make __iptunnel_pull_header() return a drop reason

__iptunnel_pull_header() and iptunnel_pull_header() used to return -ENOMEM.
They now return an enum skb_drop_reason: the reason from
pskb_may_pull_reason() when a pull fails, SKB_DROP_REASON_NOMEM when
skb_unclone() fails, and SKB_NOT_DROPPED_YET on success. The three callers
in ip_gre and ip6_gre that tested the result with "< 0" now test for a
non-zero value.

> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index bab42b9e277f7..6c2855adff289 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c

[ ... ]

>  	if (!raw_proto && inner_proto == htons(ETH_P_TEB)) {
>  		struct ethhdr *eh;
>
> -		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> -			return -ENOMEM;
> +		reason = pskb_may_pull_reason(skb, ETH_HLEN);
> +		if (unlikely(reason))
> +			return reason;
                        ^^^^

[Severity: Low]
After this change, a truncated inner Ethernet header returns
SKB_DROP_REASON_PKT_TOO_SMALL here. Should vxlan_rcv() be updated in this
patch as well? At this commit it still throws away the returned reason:

drivers/net/vxlan/vxlan_core.c:vxlan_rcv() {
    ...
	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
		reason = SKB_DROP_REASON_NOMEM;
		goto drop;
	}
    ...
}

This means a non-GPE VXLAN packet (protocol ETH_P_TEB, raw_proto false)
with an inner frame shorter than ETH_HLEN is still reported as NOMEM. The
commit message uses exactly this case as its example.

Only the drop reason seen through skb:kfree_skb and drop_monitor is
affected. The packet is dropped either way.

The next patch in the series, "vxlan: report the drop reason of
__iptunnel_pull_header()", changes this to
reason = __iptunnel_pull_header(...), so the problem only exists partway
through the series.

Would it make sense to fold that change into this patch? Alternatively,
the commit message could say that vxlan is converted separately.

>
>  		eh = (struct ethhdr *)skb->data;
>  		if (likely(eth_proto_is_802_3(eh->h_proto)))

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930183910.3151873-1-littlesmilingcloud%40gmail.com
