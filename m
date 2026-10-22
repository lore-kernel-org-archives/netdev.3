Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653915;
	b=YKebJqPbLtxzK7NEIRnXWVD878ZCabM3fhGQUq6Fi28MZsOCIdqptum+NM7sKJN+EUIP
	 Lmx2AYsvtP2m18IBuYKQYSpRjnLftZ5x0IPYsUaAjoTMtg90wILqFdEfg1MlPvsulEGVw
	 MxOAfo8QYGaDKi3XUTXw9TrShAMdJh0rjDKEqkT3IkyPVnwoXxk8NI81KooDfptDWaWI1
	 2etfFoxUJYilz8NSpJeelVklNwaMZbxTMYDihhjz27hl57U9/PG85Btvfakqeb3qofOdM
	 scP+Eh0azHEFsHA1ZcOZm7fFvP6fqNiY3v6hrLonjn/5UNPSAIOlLi86E+3ArhbKvmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653915;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xLB6QY4d4CvT3WOgrmnQWFVCi+2+aEn7UHs0/QDERSI=;
	b=w3kZvB5Kfvrwwgk2SI7nuDKZNMEsXg8TiYnIL43/ZS7WXTa3CFGsdSFgsRuPUo69InA3
	 92mjdSuNrdMPLEG0GZxXC57ecyWFhloO4wkzH58cHeW8CErPnUV7rlIA3JRklPij7KETi
	 AEHoHoWswBHhSklMF1O02F8EB0+ZKTmoVQ1/nVQfEHM2dJqpxxeemeavCANBno0e4ehQU
	 2yTQzW8rFXjA4NoBSvyx/ohM9AZXFFrzDiQZThc3Klh9DROKkKRjerHw0rOv2O5CxaURK
	 s7Z9ZPo3gfGFL5u6q0DGCDoXw1ar87Sgtw1hCe9Ue5a/Mke9zpdXAiE3uF2vpiciQNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoHnPMvm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF681606A32A;
	Thu, 22 Oct 2026 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoHnPMvm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413A41F000C3;
	Thu, 22 Oct 2026 07:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792653914;
	bh=xLB6QY4d4CvT3WOgrmnQWFVCi+2+aEn7UHs0/QDERSI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FoHnPMvmurzaYZ6ZRlGvGEJ11DJsdNsB/pI+48uxJ7HC58JVkr+qLuVsG2XY24125
	 NXUXUSMf6Du8wAhz408u5VG6LZaGGGdHTVW/bm7u0c29yi9Q/jMct0ou8dF9UPz5Jk
	 MnDE4VwKtiqqINw/1UdraMYD8zZSyVG2nBROWMlQygnFuvSYPCdfJThm0i72OQKwbS
	 3ejnfnBliG1gghz80yPGiOszlJkMN6/euqq2/QgraFQL9RwCq+ObB3mK/n8ZtZci3E
	 TGIsdofAYmR7SbMFiUPy9i4lQgIrDFja6LqsVOm2BmedvFWyjCm8acLhOvutsJDsA2
	 Ose80bkwBle/A==
Subject:
 Re: [PATCH] ipv6: icmp: use skb_dst_dev_net_rcu() for echo reply and unreach
From: netdev-bot+sashiko@kernel.org
To: haoranwangsec@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 07:25:13 +0000
Message-ID: <179265391376.3135.13185703852786757866@kernel.org>
In-Reply-To: <179241613335.5916.18191480036849517944@whr>
References: <179241613335.5916.18191480036849517944@whr>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch now takes the netns in icmpv6_echo_reply() and
  ip6_err_gen_icmpv6_unreach() from skb_dst(skb)->dev_rcu (via…
- [Medium] The commit message's premise is wrong.
- [Medium] The netns conversion is partial, so the changes are internally
  inconsistent.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but it is on the
  line the patch rewrites.
- [Low] This problem wasn't introduced by this patch, but the comment
  above ip6_err_gen_icmpv6_unreach() (net/ipv6/icmp.c:852-857) says the…

--

ipv6: icmp: use skb_dst_dev_net_rcu() for echo reply and unreach

This patch changes how ip6_err_gen_icmpv6_unreach() and
icmpv6_echo_reply() pick the network namespace. They now use
skb_dst_dev_net_rcu(skb) instead of dev_net_rcu(skb->dev). The commit
message says that under a VRF the ingress device netns differs from the
destination netns, and that the IPv4 echo path already uses the dst
netns.

> Under a VRF, skb->dev is the VRF master device, so dev_net_rcu(skb->dev)
> returns the netns of the master rather than the netns the packet is
> destined to.  The route lookup for the unreach and the send policy for
> the echo reply (ratelimit, IPsec, route) then run against the wrong
> namespace.  The rt6_lookup may miss the route to the source, leaving
> skb2->dev unset, and the echo reply is emitted/routed per the ingress
> netns instead of the destination netns.

[Severity: Medium]
Can a VRF master actually be in a different netns from the packet's
destination?

do_set_master() looks the master up in the slave's own netns:

net/core/rtnetlink.c:do_set_master() {
    ...
	upper_dev = __dev_get_by_index(dev_net(dev), ifindex);
    ...
}

VRF devices can't change netns:

drivers/net/vrf.c:vrf_setup() {
    ...
	dev->netns_immutable = true;
    ...
}

A slave that moves to another netns gets NETDEV_UNREGISTER, and
vrf_device_event() removes it from the VRF. vrf_ip6_input_dst() also
does its lookup in dev_net(vrf_dev). Packets that cross netns go through
skb_scrub_packet(), which drops the dst.

So on live receive paths, skb->dev and skb_dst(skb)->dev seem to be in
the same netns, and both expressions return the same struct net.

If rt6_lookup() really misses the VRF route, wouldn't that be because it
is called with oif=0 and no l3mdev? Then the l3mdev FIB rule can't pick
the VRF table, and this patch doesn't change those arguments.

Is there a reproducer for the VRF case described here? There is no
Fixes: tag either. Could the description be reworked so the patch isn't
picked for stable based on this scenario?

> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index a95b0351824f..5bdfbb656301 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -882,7 +882,7 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
>  	skb_pull(skb2, nhs);
>  	skb_reset_network_header(skb2);
>  
> -	rt = rt6_lookup(dev_net_rcu(skb->dev), &ipv6_hdr(skb2)->saddr,
> +	rt = rt6_lookup(skb_dst_dev_net_rcu(skb), &ipv6_hdr(skb2)->saddr,
>  			NULL, 0, skb, 0);

[Severity: Low]
This isn't a bug introduced by this patch, but this line is being
rewritten anyway. The skb passed to rt6_lookup() here is the original
IPv4 ICMP skb. On multipath routes the lookup goes:

rt6_lookup()
  fib6_rule_lookup()
    ip6_pol_route_lookup()
      fib6_select_path()
        rt6_multipath_hash()
          ip6_multipath_l3_keys(skb, ...)
            outer_iph = ipv6_hdr(skb);

This reads the outer IPv4 header as an IPv6 header to build the ECMP
hash keys. The pskb_may_pull() at the top keeps the read inside the
linear area. So the only effect is on which nexthop device ends up in
skb2->dev.

Would it be better to pass skb2 or NULL here?

[Severity: Low]
This is also a pre-existing issue, not one introduced by this patch. The
comment above ip6_err_gen_icmpv6_unreach() only mentions type/code
ICMPV6_DEST_UNREACH/ICMPV6_ADDR_UNREACH. The function also sends
ICMPV6_TIME_EXCEED/ICMPV6_EXC_HOPLIMIT, and the SIT and GRE callers do
pass ICMP_TIME_EXCEEDED:

	if (type == ICMP_TIME_EXCEEDED)
		icmp6_send(skb2, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
			   info, &temp_saddr, IP6CB(skb2));

Should that comment be updated?

>  
>  	if (rt && rt->dst.dev)
> @@ -920,7 +920,7 @@ EXPORT_SYMBOL(ip6_err_gen_icmpv6_unreach);
>  
>  static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
>  {
> -	struct net *net = dev_net_rcu(skb->dev);
> +	struct net *net = skb_dst_dev_net_rcu(skb);

[Severity: High]
Can net end up as &init_net here if the dst has been invalidated?

skb->dev is pinned while the packet is in flight, but dst->dev_rcu can
change. When a route is torn down, dst_dev_put() repoints it:

net/core/dst.c:dst_dev_put() {
    ...
	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
    ...
}

blackhole_netdev is never registered, so its netns stays &init_net.

Here is one path in netns X:

  An echo request to a local address is queued by NFQUEUE at
  NF_INET_LOCAL_IN. __nf_queue() calls skb_dst_force() and dev_hold()s
  skb->dev.

  The local address or route is deleted. After the grace period,
  fib6_info_destroy_rcu()->fib6_nh_release()->fib6_nh_release_dsts()
  calls dst_dev_put() on the pcpu rt6_info that the queued skb still
  holds. nh_rt_cache_flush() also reaches fib6_nh_release_dsts() when an
  IPv6 nexthop group is replaced.

  On NF_ACCEPT, nf_reinject() calls ip6_input_finish() directly.
  nf_ip6_reroute() only does anything for NF_INET_LOCAL_OUT, so the dead
  dst is not checked again.

  icmpv6_rcv() still uses dev_net_rcu(skb->dev), which is X, so the
  echo_ignore_all check passes. icmpv6_echo_reply() then sets
  net = &init_net.

After that, icmpv6_xmit_lock() sets the shared per-cpu ICMPv6 socket's
netns to init_net. The sysctls, IP6_REPLY_MARK, ratelimits,
ip6_dst_lookup() and xfrm_lookup() all run in init_net.

fl6.saddr is X's address, and flowi6_oif is an ifindex from X that gets
resolved in init_net. The reply carries the requester's payload and is
routed and sent from the host namespace.

The unreach hunk above looks affected the same way. The IPv4 input dst
of a queued ICMP error can go through dst_dev_put() via
rt_fibinfo_free()/rt_fibinfo_free_cpus(). ipip6_err() and ipgre_err()
still find the tunnel in dev_net(skb->dev), but rt6_lookup() would then
run in init_net. skb2->dev can then become an init_net device, and
icmp6_send() also runs in init_net.

All of this needs only CAP_NET_ADMIN in X, which an unprivileged user can
get through a user namespace. A route teardown running at the same time
(nh_rt_cache_flush(), rt6_remove_exception()) can also open the window
without nfqueue.

Before this patch, the netns came from skb->dev. That device is pinned
and can't change netns while the packet is queued. Isn't that the more
reliable source for the receiving netns?

The IPv4 sites cited in the commit message seem to have the same
weakness, so matching them doesn't make this change safe.

[Severity: Medium]
The commit message says this now matches the IPv4 path. Is the
conversion complete, though? IPv4 icmp_rcv() takes net from the dst for
the whole receive decision:

net/ipv4/icmp.c:icmp_rcv() {
    ...
	struct net *net = dev_net_rcu(rt->dst.dev);
    ...
}

IPv6 icmpv6_rcv() still uses the ingress device:

net/ipv6/icmp.c:icmpv6_rcv() {
	...
	struct net *net = dev_net_rcu(skb->dev);
	...
	case ICMPV6_ECHO_REQUEST:
		if (!net->ipv6.sysctl.icmpv6_echo_ignore_all)
			reason = icmpv6_echo_reply(skb);
	...
}

That net is used for xfrm6_policy_check() and for the echo_ignore_all
and sysctl_icmp_echo_enable_probe checks. Those checks decide whether
icmpv6_echo_reply() runs at all.

Inside icmpv6_echo_reply(), idev and flowi6_oif still come from
skb->dev. The shared icmp_build_probe() also still uses
dev_net_rcu(skb->dev).

On the unreach path, ipip6_err() and ipgre_err() find the tunnel in
dev_net(skb->dev), rt6_lookup() now uses the dst netns, and icmp6_send()
uses dev_net_rcu(skb2->dev). skb2->dev is set to the lookup's device only
when rt6_lookup() succeeds. So the netns used for sending depends on
whether the lookup succeeded.

The two sources can differ, for example in the invalidated dst case
above. Then a single packet is gated by X's echo_ignore_all, probe and
xfrm settings but answered under init_net's policy.

Shouldn't all of these sites use the same netns source?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179241613335.5916.18191480036849517944%40whr
