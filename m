Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59B374A08
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578718; cv=none; b=lSogfRgMJm+FnEXXHLfzf+OOZF9Bwo+jpuYCPKoS5jxcO6xdS++y1xutFBOOFRLiMe7ymnYxdiFJfN9X5NQTjQ6i5rUJIj9WwkIrDGWoZN9BTbPQc86bQIuKsY0hXBrTqUyWGHPuhNCTYMPD6DYhF0uZIQFXn8NrhCFwPcUXkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578718; c=relaxed/simple;
	bh=TRms3AggULax/qh8HcxeQu8a4Wao2INujbC4eD2oLiA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwpSjGV8wWrxkfsoYWBYhVa4rdf9iNq7ZOeL8etb4CWfgGBZz4upyMApC94IjTLVW77snSWca6IRYvaY55eYWvMjQRJehfmDYQc7nLNRj8FVwWJfFl1zj/OAsPXF33uwGKuGP/QLSmxXv6ikQBe7xm2C90nZUTbG1MuaEfd9wNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ3+glRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ3+glRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517701F000FF;
	Mon, 28 Sep 2026 06:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790578716;
	bh=JXppAeJs7F3YJiS+M4URDCqtwaydlqi3xaiBcea/zNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jZ3+glRp0sUWRaua4qQBGGnTsaZhqPtftxmtruUqtLK4BehJtaUpg0do3VEgPSmOM
	 5Dk8tWOxA+bWQ+/Un0qS5dYuMe3+QlOiwhhW93jpw33I7JClAvrkvNhEoeCZbq5iC3
	 RBijxdQtV1Cej2j5Rgc2Za6dHed7jXEupNOeeWrNyTTRpz6EjY9F5+EV8/ac/7WlHi
	 t2naJ0qv8tRE8P6T3lLWN5M81dDaPCOlf1FfKV6/yBg+x7+bS8UsJO4jqtdG7WWgRs
	 Crd2p8kiXRJoHygciq2RXauVMykFFZiSUlLFzKKD35SJUaJ/j12kUnQ8GrkwT6y78o
	 4hkbO3qZdrOtQ==
Subject: Re: [PATCH net] ipvs: fix infinite loop with ipvlan L3 from
 unconditional ipvs_property clear
From: netdev-bot+sashiko@kernel.org
To: chenguang.zhao@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 kerneljasonxing@gmail.com, netdev@vger.kernel.org, zhaochenguang@kylinos.cn,
 syzbot+2b120190d9e54ad8c65d@syzkaller.appspotmail.com
Date: Mon, 28 Sep 2026 06:58:35 +0000
Message-ID: <179057871587.3145.9792082208113210515@kernel.org>
In-Reply-To: <20260924063312.1194019-1-chenguang.zhao@linux.dev>
References: <20260924063312.1194019-1-chenguang.zhao@linux.dev>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The replacement for de2c211868b9's reset only covers the single-
  skb receive functions.
- [High] net: ipvs: SNAT bypass for bridged packets due to rx_handler
  interception
- [Medium] The new unconditional ipvs_reset() in ip_rcv()/ipv6_rcv()
  clears ipvs_property on every packet delivered through the single-…
- [Low] The recorded commit message does not describe the fix.

--

ipvs: fix infinite loop with ipvlan L3 from unconditional ipvs_property clear

This patch moves ipvs_reset() in skb_scrub_packet() back under the xnet
check, so ipvs_property is only cleared when an skb crosses a netns. That
fixes an infinite LOCAL_OUT recursion when IPVS NAT sits above ipvlan L3.
To keep the bpf_redirect fix from de2c211868b9, it also adds ipvs_reset()
to ip_rcv() and ipv6_rcv() right before the PRE_ROUTING hook.

Closes: https://syzkaller.appspot.com/bug?extid=2b120190d9e54ad8c65d

> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> Fix it with two changes:
>
> 1. Move ipvs_reset() back inside the xnet guard in skb_scrub_packet(),
>    so ipvs_property is only cleared when the skb actually crosses a
>    netns boundary. This restores IPVS re-entry protection for the
>    ipvlan path.
>
> 2. To preserve the bpf_redirect fix, add ipvs_reset() in ip_rcv() and
>    ipv6_rcv() right before the NF_HOOK into PREROUTING. Every
>    redirected packet enters the stack through these points, so
>    clearing ipvs_property there covers the original use case without
>    affecting the ipvlan code path.

[Severity: Low]
This isn't a bug, but the "Fix it with two changes" text is below the ---
separator, so it gets dropped when the patch is applied.

The commit recorded in git ends at Signed-off-by. It never mentions the
new ipvs_reset() calls in ip_rcv() and ipv6_rcv().

Could this explanation be moved above the ---?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b4edbd06655e..4a5c9b69d8b7 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6306,11 +6306,10 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  	skb->offload_fwd_mark = 0;
>  	skb->offload_l3_fwd_mark = 0;
>  #endif
> -	ipvs_reset(skb);
> -
>  	if (!xnet)
>  		return;
>
> +	ipvs_reset(skb);
>  	skb->mark = 0;
>  	skb_clear_tstamp(skb);
>  }
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 9860178752b8..00f3b328e90a 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -609,6 +609,7 @@ int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt,
>  	if (skb == NULL)
>  		return NET_RX_DROP;
>
> +	ipvs_reset(skb);
>  	return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
>  		       net, NULL, skb, dev, NULL,
>  		       ip_rcv_finish);

[Severity: High]
Does this leave a stale flag on packets that never reach ip_rcv()
because a bridge rx_handler consumes them first?

Suppose IPVS has already marked a packet, and the packet is then
redirected into an interface that is a bridge port in the same netns.
Two examples are bpf_redirect() to ingress (__bpf_rx_skb() ->
____dev_forward_skb()) and a veth whose peer is enslaved to a bridge
in the same netns. In both cases the scrub now runs with xnet=false,
so ipvs_property is kept:

  ____dev_forward_skb()
    skb_scrub_packet(skb, false)     /* flag kept */
  netif_rx()
    ...
      __netif_receive_skb_core()
        br_handle_frame()            /* RX_HANDLER_CONSUMED */

ip_rcv() and ipv6_rcv() are never called on the port device, so the
new ipvs_reset() calls do not run.

With br_netfilter enabled, br_nf_pre_routing() and br_nf_forward_ip()
still pass the bridged packet through the IPv4/IPv6 netfilter hooks.
The IPVS FORWARD hook then bails out:

	if (skb->ipvs_property)
		return NF_ACCEPT;

That skips SNAT for the NAT reply. This is the same failure that
de2c211868b9 fixed, now for bridged traffic instead of routed
traffic, and it can leak real server addresses. In the parent tree
the unconditional reset in skb_scrub_packet() covered this case.

Frames the bridge passes up to the host via br_pass_frame_up() do
reach ip_rcv() on the bridge device and get reset. Frames the bridge
forwards do not.

Is relying on ip_rcv()/ipv6_rcv() enough here? Or should the reset
stay in the xnet=false paths that re-inject into RX, such as
____dev_forward_skb(), and be skipped only for the ipvlan outbound
case that causes the recursion?

[Severity: High]
Does this also cover the batched receive path? ip_packet_type and
ipv6_packet_type register .list_func handlers as well, and
__netif_receive_skb_list_ptype() calls those for list delivery:

net/core/dev.c:__netif_receive_skb_list_ptype() {
    ...
	if (pt_prev->list_func != NULL)
		INDIRECT_CALL_INET(pt_prev->list_func, ipv6_list_rcv,
				   ip_list_rcv, head, pt_prev, orig_dev);
    ...
}

ip_list_rcv() calls ip_rcv_core() and then enters PRE_ROUTING through
ip_sublist_rcv() without calling ipvs_reset():

net/ipv4/ip_input.c:ip_sublist_rcv() {
	NF_HOOK_LIST(NFPROTO_IPV4, NF_INET_PRE_ROUTING, net, NULL,
		     head, dev, NULL, ip_rcv_finish);
    ...
}

ipv6_list_rcv()->ip6_sublist_rcv() behaves the same way.

Now that skb_scrub_packet() only resets the flag when xnet is true, it
looks like the stale flag survives this path:

IPVS NAT in netns N sets skb->ipvs_property = 1
veth_xmit()                        /* peer also in netns N */
  veth_forward_skb()
    __dev_forward_skb()
      ____dev_forward_skb()
        skb_scrub_packet(skb, false)   /* flag kept */
veth_poll()                        /* peer has GRO or XDP, use_napi */
  napi_gro_receive()
    ... netif_receive_skb_list_internal()
      ip_list_rcv()                    /* ipvs_property still 1 */

Then ip_vs_out_hook() returns early:

	if (skb->ipvs_property)
		return NF_ACCEPT;

ip_vs_in_hook() does the same. That brings back the skipped SNAT that
de2c211868b9 fixed, and whether it happens depends on the receiving
device's GRO/XDP state.

skb_do_redirect() with BPF_F_PEER looks affected as well:

net/core/filter.c:skb_do_redirect() {
    ...
		if (unlikely(!dev ||
			     !(dev->flags & IFF_UP) ||
			     net_eq(net, dev_net(dev))))
			goto out_drop;
		skb_scrub_packet(skb, false);
    ...
}

This path only runs when the target is in another netns, yet it scrubs
with xnet=false. As a result, ipvs_property now crosses the netns
boundary and can reach ip_list_rcv() in the target netns.

The notes say "Every redirected packet enters the stack through these
points", but that doesn't seem to be true for NAPI/GRO list delivery.

Would it work better to do the reset in ip_rcv_core()/ip6_rcv_core(), to
add it to both list handlers, or to clear the flag in the xnet=false
forwarders that re-inject into RX?

> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index d332ec60f915..05917095ef6d 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -348,6 +348,7 @@ int ipv6_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt
>  	skb = ip6_rcv_core(skb, dev, net);
>  	if (skb == NULL)
>  		return NET_RX_DROP;
> +	ipvs_reset(skb);
>  	return NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
>  		       net, NULL, skb, dev, NULL,
>  		       ip6_rcv_finish);

[Severity: Medium]
Can the unconditional clear here, and the one in ip_rcv() above, drop
an ipvs_property that IPVS set on purpose?

Take a local client connecting to a VIP whose DR real server is on the
same host:

LOCAL_OUT ip_vs_in_hook()
  ip_vs_dr_xmit()                 /* local route */
    ip_vs_send_or_cont(..., 1)
      skb->ipvs_property = 1;     /* returns NF_ACCEPT */
loopback_xmit()                   /* no scrub */
  __netif_rx()
    process_backlog()
      ip_rcv()
        ipvs_reset(skb)           /* flag cleared */
LOCAL_IN ip_vs_in_hook()

At LOCAL_IN the early return no longer fires:

	/* Already marked as IPVS request or reply? */
	if (skb->ipvs_property)
		return NF_ACCEPT;

So ip_vs_in_stats(), ip_vs_set_state() and the in_pkts update run a
second time for the same packet:

	ip_vs_in_stats(cp, skb);
	ip_vs_set_state(cp, IP_VS_DIR_INPUT, skb, pd, iph.len);
	...
		pkts = atomic_inc_return(&cp->in_pkts);

	if (ipvs->sync_state & IP_VS_STATE_MASTER)
		ip_vs_sync_conn(ipvs, cp, pkts);

xt_ipvs --ipvs rules at INPUT would also stop matching these packets. In
the parent tree the flag survived loopback, and LOCAL_IN skipped them.

There is a similar concern for ignore_tunneled. ip_vs_in_hook() marks the
outer packet:

		/* The only way we'll see this packet again is if it's
		 * encapsulated, so mark it with ipvs_property=1 so we
		 * skip it if we're ignoring tunneled packets
		 */
		if (sysctl_ignore_tunneled(ipvs))
			skb->ipvs_property = 1;

With this patch, ip_tunnel_rcv() keeps the mark because its scrub uses
xnet=false. It then calls gro_cells_receive(), which falls back to
netif_rx() in three cases:

  - there are no cells
  - skb_cloned(skb) is true, for example when a packet tap is active
  - netif_elide_gro(dev) is true

The netif_rx() path reaches ip_rcv() and clears the mark. The GRO path
reaches ip_list_rcv() and keeps it. So whether the sysctl works now
depends on GRO/XDP/tap state.

The parent tree already cleared the mark in ip_tunnel_rcv() through the
unconditional scrub from de2c211868b9, so the ignore_tunneled part is not
new. This patch also doesn't restore the pre-de2c211868b9 behaviour for
it.

Is there a way to clear only stale flags here, instead of every packet
that comes in through ip_rcv() and ipv6_rcv()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924063312.1194019-1-chenguang.zhao%40linux.dev
