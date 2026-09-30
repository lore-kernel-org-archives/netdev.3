Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F84C9E02
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773690; cv=none; b=lA7HxTOiCXjalzzU9S/nJPHxvaOBxs2S9QGBvyW+Viu6t4RGXYFV9uellvHxuw89I95vNwKTnCHPDTyscVsByYoc0aE/4jZQODScpFhKU74rWMJPEJlssag3cJCxtLOHBgiPwttC+PTYcAkD/MHBmTS6Z1zkImT1Zf+aHBu2AXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773690; c=relaxed/simple;
	bh=/iY3Wx2p0Yd3R73QyRWv8/Sai+X0eAoAjyFYiisdRqw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tplCEQV1qWGbaRY4kaLxkNaXMWo22oytF3f3rq9RfcPLumTEZXM8EPX0ov3U9gDclZ2qUv5ct9QGibrycKKBK1ePE9REf7vwXdD09OkssAxdy6PBTCZ3ZUeAM3nBP7Mm8kPAhtQfMojO6ASVBCz/AqTe1ff4A67wrUppbJ8Mvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAadq3kM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAadq3kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438401F00893;
	Wed, 30 Sep 2026 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773671;
	bh=YAsymrkqiMJjcxb2DPzNHgGRjjv5pUDL6LDL5vSCvKs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mAadq3kMOlJ9Ost/fx9cV/sppMb999FJq8QfCRA16gbKXgqJ9ULtL9C5Q66TJRttf
	 DOWMtDZsjU/cxxj0RRH7Uxe21V4HX70A8hOHJKthkWgySefjv6ip3GR4OaxU8OsLC7
	 LMNd5tJHV9StZH7ILwld+W4Op4ZzZOv/EWB3Oja9uvW14ChIpD5AARQZvDp6Blnuee
	 t21lfP6ahA4Sv60ry9DyFKOJMDq02tw/tHuLC6GPoCAml+0dH/1d3M9SmZ8QH39PIT
	 gNDeUpT2rLDFPvR6caFqjnV6N0lkP9H6roJNqIXmrIyNNZdUsg14LwM7vX5IRWnH7v
	 m0+bPweblJ2zA==
Subject: Re: [PATCH net 2/2] net/sched: sch_teql: keep skb->dev consistent on
 the arp-queue path
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Wed, 30 Sep 2026 13:07:50 +0000
Message-ID: <179077367081.434549.3367341827161501919@kernel.org>
In-Reply-To: <QDISC-6HS9.v1.20260928064754@mojatatu.com.2>
References: <QDISC-6HS9.v1.20260928064754@mojatatu.com.2>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new line `skb->dev = n1->dev;` in
  neigh_update_process_arp_queue() (net/core/neighbour.c:1339) runs for…

--

net/sched: sch_teql: keep skb->dev consistent on the arp-queue path

This moves the skb->dev = slave assignment in teql_master_xmit() to before
teql_resolve(), so an skb parked on the slave's arp_queue names the slave.
It also makes neigh_update_process_arp_queue() set skb->dev = n1->dev
before reinjecting each queued skb through n1->output().

Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 7448320f7ad52..5823f5007812b 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1336,6 +1336,7 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
>  			if (n2)
>  				n1 = n2;
>  		}
> +		skb->dev = n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);

[Severity: Medium]
Is the "identity for every other parker" claim in the commit message
accurate?

The commit message says:

  Restore skb->dev = n1->dev at the reinjection point; this is the
  identity for every other parker (neigh_resolve_output() parks with
  skb->dev == neigh->dev, ndisc probes carry no skb)

When a dst is attached, n1 is replaced by n2 = dst_neigh_lookup_skb(dst,
skb). For IPv4 that is ipv4_neigh_lookup(), which picks the neighbour on
the dst's device and not on the device the skb was parked on:

net/ipv4/route.c:ipv4_neigh_lookup() {
    ...
	dev = dst_dev_rcu(dst);
	if (likely(rt->rt_gw_family == AF_INET)) {
		n = ip_neigh_gw4(dev, rt->rt_gw4);
    ...
}

So this new line runs for every neighbour table, and it can change the
egress device for parkers other than teql.

One case is bpf_redirect_neigh() with BPF_F_NEXTHOP from tc egress. The
tc egress hook runs in __dev_queue_xmit() before the IFF_XMIT_DST_RELEASE
drop. __bpf_redirect_neigh_v4() replaces the dst only in the !nh branch:

net/core/filter.c:__bpf_redirect_neigh_v4() {
    ...
		skb_dst_drop(skb);
		skb_dst_set(skb, &rt->dst);
	}
    ...
}

With an explicit nexthop, the original route dst (say on eth0) stays
attached. bpf_out_neigh_v4() then sets skb->dev to the BPF target (say
eth1) and calls neigh_output() on ip_neigh_gw4(eth1, nh). If that
neighbour is unresolved, the skb is parked on eth1's neighbour.

When it resolves, n2 is the neighbour on eth0, and this line sets
skb->dev = eth0. Do the queued packets now leave through the route device
instead of the device the BPF program chose?

Before this patch they went out eth1 with eth0's L2 header, which was
also wrong, but the behaviour was different.

A second case is bridged DNAT in br_netfilter with pass_vlan_indev set.
br_nf_pre_routing_finish() only calls br_nf_pre_routing_finish_bridge()
when skb_dst(skb)->dev is the VLAN upper device (br0.VID), and that
function does:

net/bridge/br_netfilter_hooks.c:br_nf_pre_routing_finish_bridge() {
    ...
	skb->dev = bridge_parent(skb->dev);
    ...
	neigh = dst_neigh_lookup_skb(dst, skb);
    ...
			ret = READ_ONCE(neigh->output)(neigh, skb);
    ...
}

Here skb->dev is br0 while the neighbour is on br0.VID, so skb->dev ==
neigh->dev does not hold. Before this patch, parked skbs left through br0,
the same as skbs that were not parked.

With this change, won't parked skbs go through dev_queue_xmit(br0.VID)
and vlan_dev_hard_start_xmit()? That path can rewrite the hwaccel VLAN
TCI/PCP from the egress QoS map and bumps the VLAN device stats. Parked
and non-parked packets would then take different paths.

Could the fix be kept inside teql instead? Another option is to limit it
to the teql master/slave case, where n2 differs from the parking
neighbour, so other neighbour users keep their current skb->dev.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v1.20260928064754%40mojatatu.com
