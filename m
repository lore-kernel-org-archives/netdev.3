Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653916;
	b=1fzYWHGZeXmw3ednyn4YP0LvsjolYBEPBqoAWVccQ625K53qazY2b1qluGReenw5lBTC
	 eT/VNEOcLb/ncOWn6p2zp3EDu3PfEmtTfyqiqS1cMLwSa5+p3OH2ir2wZKBw4sUnqnjWy
	 av9ZxbT6y9qTDZC0DO/XBps93utCV7eLVsxBK2S3zdaCR/DIx31FDYUJgfo+PZToC6t8f
	 693fZhCtk4cwQbAuF+gah7jKFmW2OJfjyAFSZT6IIyz1W806YU5jS99ZhQE39GemK6J2o
	 20M381p0QM1Dqdm1DalLojTbhpS2eVLHACp24J18P23wqqmApQocB9IWlV+ZkXtqwAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653916;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yGPjtW4dPyExBLHegpCAYaoNHXzJvfRMMf+pf+UEbrQ=;
	b=kTVzE/uu0BeVY2N7IV9PtHQ4h1QyhgT+Odv7kO+RHGrrWdwaf4o9LQVt3EFJFIZcjoeX
	 mivO4xA31lYLRxu6V1zoJRElv9E0sfFQdCI1xrf4ZZgaNMlGQVa1b1tNHFeUupRbObGFU
	 lBp9Oo3wejEiFaXZ8tOf68Up/Vw15R01gfKRmf1AuNDYv/MCfQyrh4QWbebwYYhv23yg9
	 6Cq58y6lr6NgHrOScbfRkf9oJac3el9JUMLrHsEQ/krvLAJcY9F/b4Y/OW3oXITVbJTJF
	 19M8Eiga8yqhctQ0eE7yvLLaXu7G/pmbmXa4T5r9GMtEDa3tXe2rztn+NAsZFC8NcLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBhz2xlM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876F606A336;
	Thu, 22 Oct 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBhz2xlM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995401F000C1;
	Thu, 22 Oct 2026 07:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792653915;
	bh=yGPjtW4dPyExBLHegpCAYaoNHXzJvfRMMf+pf+UEbrQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bBhz2xlM2v082BJnf1rR1dE4irElqCWR565Z0tgwFxjgAO98FknqeCOFsh0jMKlbi
	 aSn3IViQmWIITFsxaBT5aBZprh6Vg655nBGRUIBzocUcTFLJItcqBIxY6H7C8Sg+WR
	 fNkXFpzMBo/y522vdvNtj/4mkd3HGaCR3xVIN+9nsp9qXaBYCz3JrywyVCDkQ7ImsA
	 tOplc0lxxstVuF0HL1BLFebOuaV8CzkRJFZJnuk5ZoNroHiZEiI9O0tRsEy6KqIzhO
	 O8jypKeBADDHMzzWOrvyNtbccq3h2/aIkpYuBHFLrTVQ40mn3ifQJNmuosBPUd8x+q
	 E2Bz8FlLNFtGg==
Subject: Re: [PATCH] ipv4: icmp: use skb_dst_dev_net_rcu() in icmp_build_probe
From: netdev-bot+sashiko@kernel.org
To: haoranwangsec@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 07:25:15 +0000
Message-ID: <179265391520.3135.6406546959065554687@kernel.org>
In-Reply-To: <179241614083.5916.6651154069510905781@whr>
References: <179241614083.5916.6651154069510905781@whr>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a netns bug that does not exist.
- [Medium] icmp_build_probe() is a shared helper; its comment says
  'Helper for icmp_echo and icmpv6_echo_reply'.
- [Low] icmp_build_probe() now takes the netns for the remote-controlled
  interface lookups from skb_dst(skb)->dev_rcu, and that pointer can…

--

ipv4: icmp: use skb_dst_dev_net_rcu() in icmp_build_probe

This commit changes icmp_build_probe() so that it gets the network
namespace from the skb's dst device via skb_dst_dev_net_rcu(), not from
skb->dev. The commit message says this fixes PROBE device lookups and
reply policy running in the wrong namespace under a VRF.

> The ICMP Extended Echo (RFC 8335) PROBE replies identify the queried
> interface by name/index/address and should look it up and apply policy
> in the netns the packet is destined to, not the netns of the ingress
> device.  Under a VRF, skb->dev is the VRF master, so dev_net_rcu(skb->dev)
> returns the master's netns and the device lookup / reply policy run in
> the wrong namespace.
>
> The rest of the IPv4 ICMP echo path already uses skb_dst_dev_net_rcu(skb)
> (net/ipv4/icmp.c:1123, :1267, :1437), while icmp_build_probe() is the
> exception.

[Severity: Medium]
Can the VRF master actually be in a different netns from the dst device
here?

vrf_ip_rcv() does set skb->dev = vrf_dev. But the master always sits in
the same netns as its slaves, because do_set_master() looks it up in the
slave's own netns:

net/core/rtnetlink.c:do_set_master() {
    ...
	upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
    ...
}

A slave that moves to another netns gets NETDEV_UNREGISTER, and
vrf_device_event() unlinks it.

For local-input routes, ip_rt_get_dev() returns either the l3mdev master
or the loopback device of the same netns:

net/ipv4/route.c:ip_rt_get_dev() {
    ...
	dev = l3mdev_master_dev_rcu(nhc->nhc_dev);
	return dev ? : net->loopback_dev;
}

ip6_rt_get_dev_rcu() does the same thing with dev_net(dev)->loopback_dev.

So on normal receive paths, dev_net_rcu(skb->dev) and
skb_dst_dev_net_rcu(skb) appear to return the same struct net.

Would it be more accurate to describe this as a consistency cleanup? The
other option is to show a setup where the two pointers really differ. As
written, the change reads like a VRF netns fix and could be queued for
net or stable on that basis.

The cited precedent also looks inaccurate. Of the three call sites, only
the one in icmp_echo() is on the echo path. The first is in
icmp_unreach(), which handles ICMP_DEST_UNREACH and similar errors. The
last is the error stats path in icmp_timestamp():

	__ICMP_INC_STATS(skb_dst_dev_net_rcu(skb), ICMP_MIB_INERRORS);

> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 90c0e22c29be..a577dfc652b2 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -1293,7 +1293,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
>  
>  bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
>  {
> -	struct net *net = dev_net_rcu(skb->dev);
> +	struct net *net = skb_dst_dev_net_rcu(skb);

[Severity: Medium]
icmp_build_probe() is shared with IPv6; the comment above it says
"Helper for icmp_echo and icmpv6_echo_reply". Is the change in IPv6
behaviour intended? The subject and commit message only mention IPv4.

The IPv6 caller still gets its netns from skb->dev:

net/ipv6/icmp.c:icmpv6_echo_reply() {
	struct net *net = dev_net_rcu(skb->dev);
    ...
	if (icmph->icmp6_type == ICMPV6_EXT_ECHO_REQUEST)
		if (!icmp_build_probe(skb, (struct icmphdr *)&tmp_hdr))
			goto out_dst_release;
    ...
}

icmpv6_rcv() does the same. After this patch, a single ICMPv6 Extended
Echo request uses two netns sources:

The dst netns controls the sysctl_icmp_echo_enable_probe check and the
dev_get_by_name(), dev_get_by_index(), ip_dev_find() and ipv6_dev_find()
lookups.

The skb->dev netns controls everything else:
icmpv6_echo_ignore_multicast/anycast, IP6_REPLY_MARK, sock_net_uid(),
icmpv6_xmit_lock(), the route and xfrm lookup, icmpv6_global_allow() and
the ICMP6 MIB counters.

Before the patch, the helper and its IPv6 caller used the same netns.

If the two netns can differ, as the commit message says, wouldn't IPv6
keep the problem the patch claims to fix, and also split one reply
across two namespaces? Would it be cleaner to pass net in from each
caller, or to convert both callers the same way?

[Severity: Low]
Can skb_dst_dev_net_rcu() return init_net here for a packet that was
received in another netns?

dst_dev_put() switches the dst device to blackhole_netdev, even though
skbs may still hold the dst:

net/core/dst.c:dst_dev_put() {
    ...
	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
    ...
}

rt_fibinfo_free() and fib6_nh_release_dsts() call it.
rt_flush_dev() and rt6_uncached_list_flush_dev() make the same switch
when a device is unregistered. blackhole_netdev is allocated through
alloc_netdev, which calls dev_net_set(dev, &init_net), so it belongs to
init_net.

A PROBE skb in netns X can keep its dst across this switch through
NFQUEUE, because __nf_queue() calls skb_dst_force(). Suppose the local
address or route is deleted while the packet is queued, and the packet
is then reinjected at LOCAL_IN:

icmpv6_rcv()
  icmpv6_echo_reply()     net = dev_net_rcu(skb->dev)      /* netns X */
    icmp_build_probe()    net = skb_dst_dev_net_rcu(skb)   /* init_net */

icmp_build_probe() would then check init_net's
sysctl_icmp_echo_enable_probe and resolve the name, index or address
chosen by the sender in init_net. The reply would say whether that
init_net interface exists, whether it is up, and whether it has IPv4 or
IPv6 addresses.

icmpv6_echo_reply() still builds and routes the reply in netns X, so the
sender would receive it. Before the patch the helper used skb->dev, so
these lookups stayed in netns X.

This only happens if init_net has icmp_echo_enable_probe=1, which is off
by default, and the window is narrow. On IPv4, icmp_rcv(), icmp_echo()
and icmp_reply() already used the dst netns, so this patch extends that
existing exposure to the probe lookups.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179241614083.5916.6651154069510905781%40whr
