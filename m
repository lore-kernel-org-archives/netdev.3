Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C735C6BE;
	Sun, 11 Oct 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758425; cv=none; b=SUDBetMxhPxFH2ANQvzKDhXFxSXfqeqdSnPLoGJFWNBaSDd1aZ3M+pbCwl31t1ntgoJmJkeHpPjJ/aAmVkrfog2FHLMbC3GbSQFNLLqFKVTv4s562ocR3SHpoQdieg2Toyx1LLgGecbHTR8t8RsTtLPDV7JR+Aj5QM+eGoBg1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758425; c=relaxed/simple;
	bh=IxShT9PYMHtq0d2zYCfZWp4T5J7JzMrOrsnG6YCZE2Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXerKW1wpw3q4QajgQQSnUcAdcprVwZZPld4M6aO4UsQLyWeqjaEq96Et+6QoUbWwgERJau6BIJOsS9p1J1W5B5B32oW5vi4OIIEsDKxxLE+NQaBWibmnEQkU2WSHhx2rbxmKooGgzMJlgNG2Lai543MiLtPxNgftKRYDNvr9R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMUEr7/p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMUEr7/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE521F0089B;
	Sun, 11 Oct 2026 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758424;
	bh=k6XlKFnfVi4/5k41hFdTt5y7yRrRlJp0WwmZIund+20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OMUEr7/p18hHaEwb1ca2J4cCZAhv+xnM+tyOqHSXzaloMVFpm/arWyWLzbNb8Eurt
	 O63M6/7da6ZOcFCA14QmovJX6mdyJhY2O5gbWmgV8+z7QDWR3obi3An4qFe5lAXnSW
	 Qg9uz2KhEhBJ4pmHG/HZeeo8GyusWdH6U6kWpymjtmvIweaCe/9MZvSv88923mqXYC
	 Gxl08qiBTezVfVrcTB+zWxC6zKNDI77llMGzzNKpub9XQ1PzKKONn28PvRoBWCAfAY
	 hkeoc0yt8JrjZSIsJIWZBM2fnxazy/F/fubhNuUgyUK7iBSU2BpjyjM3a6Dvtejh29
	 yOpsOljs57AIw==
Subject: Re: [PATCH net] ip_tunnel: reserve headroom for the encap header
 before pushing it
From: netdev-bot+sashiko@kernel.org
To: theodorlarionov@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 cehrig@cloudflare.com, ast@kernel.org, tom@herbertland.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 22:40:22 +0000
Message-ID: <179175842288.434549.1635440087778323337@kernel.org>
In-Reply-To: <20261010223601.1193655-1-theodorlarionov@gmail.com>
References: <20261010223601.1193655-1-theodorlarionov@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds skb_cow_head(skb, encap_hlen) at the top of
  ip_tunnel_xmit() (net/ipv4/ip_tunnel.c:700), before the first…
- [High] In ip_md_tunnel_xmit(), the headroom is sized from one live read
  of the shared tun_info->encap: `encap_hlen =…
- [Low] The new early skb_cow_head(skb, encap_hlen) in ip_tunnel_xmit()
  (net/ipv4/ip_tunnel.c:700) runs on every packet, including tunnels…

Pre-existing issues:
- [Low] ip_tunnel_xmit() now does `encap = READ_ONCE(tunnel->encap);`
  (net/ipv4/ip_tunnel.c:696) under the comment 'Size and push the encap…

--

ip_tunnel: reserve headroom for the encap header before pushing it

This patch adds an early skb_cow_head() for the FOU/GUE encap header length
at the start of ip_tunnel_xmit() and ip_md_tunnel_xmit(). The goal is that
ip_tunnel_encap() no longer pushes the encap header into headroom that was
never reserved. ip_tunnel_xmit() also takes one READ_ONCE() snapshot of
tunnel->encap and uses it for both the reservation and the push.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..38ab3c3bf5c9a 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c

[ ... ]

> @@ -587,6 +588,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  		     ip_tunnel_info_af(tun_info) != AF_INET))
>  		goto tx_error;
>  	key = &tun_info->key;
> +	encap_hlen = ip_encap_hlen(&tun_info->encap);
> +	if (encap_hlen < 0)
> +		goto tx_error;
> +	if (skb_cow_head(skb, encap_hlen))
> +		goto tx_dropped;

[Severity: High]
Is tun_info->encap stable between this reservation and the push?

The headroom is sized here from one read of tun_info->encap. The header is
then pushed later in ip_md_tunnel_xmit() using separate reads:

	if (!tunnel_hlen)
		tunnel_hlen = ip_encap_hlen(&tun_info->encap);

	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
		goto tx_error;

The fou/gue build_header callbacks also read e->flags again.

tun_info is not necessarily private to this skb. bpf_skb_set_tunnel_key()
attaches the per-CPU md_dst to every skb it handles on that CPU, and then
rewrites it in place:

net/core/filter.c:bpf_skb_set_tunnel_key() {
	struct metadata_dst *md = this_cpu_ptr(md_dst);
    ...
	skb_dst_drop(skb);
	dst_hold((struct dst_entry *) md);
	skb_dst_set(skb, (struct dst_entry *) md);

	info = &md->u.tun_info;
	memset(info, 0, sizeof(*info));
    ...
}

bpf_skb_set_fou_encap() also writes info->encap.type/flags/sport/dport in
place.

Suppose an skb is tagged on CPU0, queued on a qdisc of a collect_md ipip
device, and sent from CPU1. Meanwhile CPU0's tc BPF program rewrites the
same md_dst (memset to TUNNEL_ENCAP_NONE, then GUE). Could CPU1 reserve 0
or 8 bytes here and then push a 12-20 byte GUE header?

That would hit the same skb_under_panic() in fou_build_udp() that this
patch fixes. In the mirred mirror case it would overwrite the bytes in
front of skb->data instead.

ip_tunnel_xmit() takes a local copy of the encap config for this reason.
Would a local snapshot here close the same gap on the md path? For example:

	struct ip_tunnel_encap encap = tun_info->encap;

used for the reservation, tunnel_hlen and ip_tunnel_encap().

>  	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
>  	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
>  	tos = key->tos;

[ ... ]

> @@ -679,11 +686,23 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,

[ ... ]

> +	/* Size and push the encap header from one copy of the config. */
> +	encap = READ_ONCE(tunnel->encap);

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch, but the
writer side has no matching marked store for this READ_ONCE().
ip_tunnel_encap_setup() zeroes t->encap and then fills it in with plain
stores:

net/ipv4/ip_tunnel.c:ip_tunnel_encap_setup() {
    ...
	memset(&t->encap, 0, sizeof(t->encap));

	hlen = ip_encap_hlen(ipencap);
	if (hlen < 0)
		return hlen;

	t->encap.type = ipencap->type;
	t->encap.sport = ipencap->sport;
	t->encap.dport = ipencap->dport;
	t->encap.flags = ipencap->flags;
    ...
}

So a snapshot taken during changelink can still be half-written. It might
see type NONE right after the memset, or a new type with sport/dport still
0.

The length and the push now both come from the local copy. Because of
that, the worst case is a few packets sent without encap or with UDP port
0, plus a possible KCSAN report. The old plain reads could already see
these same states.

Would it make sense to build the new config in a local struct and store it
once on the writer side, as a follow-up?

> +	encap_hlen = ip_encap_hlen(&encap);
> +	if (encap_hlen < 0)
> +		goto tx_error;
> +	if (skb_cow_head(skb, encap_hlen)) {
> +		DEV_STATS_INC(dev, tx_dropped);
> +		kfree_skb(skb);
> +		return;
> +	}

[Severity: High]
Can this new skb_cow_head() free the memory that tnl_params points to?

For GRE devices with header_ops (NBMA or a multicast remote), ipgre_xmit()
passes ip_tunnel_xmit() a tnl_params pointer that lives inside the skb
head:

net/ipv4/ip_gre.c:ipgre_xmit() {
    ...
	if (dev->header_ops) {
		int pull_len = tunnel->hlen + sizeof(struct iphdr);

		if (skb_cow_head(skb, 0))
			goto free_skb;
		...
		tnl_params = (const struct iphdr *)skb->data;

		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
		skb_pull(skb, pull_len);
    ...
}

That pointer reaches ip_tunnel_xmit() through __gre_xmit():

	ip_tunnel_xmit(skb, dev, tnl_params, tnl_params->protocol);

If skb_cow_head(skb, encap_hlen) ends up in pskb_expand_head(), the old head
is freed. Every later read of tnl_params (->daddr, ->tos, ->saddr,
->frag_off, ->ttl) then reads freed memory. Those values feed the route
lookup and the outer IP header.

Before this patch, the only skb_cow_head() in ip_tunnel_xmit() ran after the
last tnl_params read.

For the reallocation to happen, the headroom at entry has to be smaller than
encap_hlen. In the GRE header_ops path the tunnel config is read three times
without locking:

  - tunnel->hlen in ipgre_xmit(), for pull_len
  - tunnel->tun_hlen in __gre_xmit()
  - tunnel->encap here

ipgre_changelink() writes t->encap and t->hlen in
ipgre_newlink_encap_setup(). It later writes tun_hlen and hlen in
ipgre_link_update(). There is no synchronize_net() in between.

For example, take a single "ip link set" that changes encap from none to GUE
with remcsum (0 -> 20 bytes) and o_flags to csum|key|seq (tun_hlen 4 -> 16).
If a packet is between the hlen read and the tun_hlen read, it has about
H0 + 8 bytes of headroom, where H0 is the headroom it arrived with. For
small H0 that is below 20.

Before the patch, that race ended in skb_under_panic(). With the patch it
looks like it becomes a silent use-after-free read.

Doesn't this contradict this part of the commit message?

    ip_tunnel_xmit() reads tunnel->encap once, so a concurrent
    changelink cannot change the length between the reservation and the
    push.

Would either of these avoid it: copying *tnl_params to a local struct before
the early skb_cow_head(), or moving the reservation after the last
tnl_params read?

[Severity: Low]
Should this skb_cow_head() be skipped when encap_hlen is 0?

__skb_cow() calls pskb_expand_head() whenever skb_header_cloned() is true,
even when delta is 0. ipip_tunnel_xmit() and sit pass skbs through without
uncloning them.

Take a header-cloned skb going into a plain ipip tunnel with no encap, such
as the mirred mirror case from the commit message. It is now uncloned here.
If its headroom is still too small, the later skb_cow_head(skb,
max_headroom) reallocates it a second time.

Before the patch, one pskb_expand_head() in the max_headroom call handled
both. Either guarding this call with if (encap_hlen), or reserving the full
estimate in one call, would avoid the extra allocation and copy per packet.

> +
>  	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
>  	connected = (tunnel->parms.iph.daddr != 0);
>  	payload_protocol = skb_protocol(skb, true);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010223601.1193655-1-theodorlarionov%40gmail.com
