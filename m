Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144E4F85DA;
	Mon, 19 Oct 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415832; cv=none; b=d2t9erPGdEYdvDMY9TeSQkQj2dhmJcIcAcHOGbaFRyrD97nfDO2MQsZSLp0wnNtFL2ms3eO0Yz+CHrELa4dDjiS83GlPt86rXZfwMvcOg6IK4nmiQmfqjHe7W/joEYTrQTC7cB7l1cvC8qRns860xQs+8L3Fq4S7Ks+RM7xsaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415832; c=relaxed/simple;
	bh=1njOqoKjm3j0KX3/NQp4//Zdp7Cf8gNgJlE4JmkmkRw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHUegMQTgtdkNJtwTifu/MA8LAuyUD76oi0rDnmAegiw6T5OYGmlg6cUZy/x52NDNTHSv/W2ojYsRjp1B/JrTvMzYWXQoR8HMtcENQAwSX1BEj3asharY8jdZi3EwrEByp+MUn2UhkTMmJOxhVy0g3syapTblYHl5FVqr2mh1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+UQ2EkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+UQ2EkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7338D1F000C5;
	Mon, 19 Oct 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415830;
	bh=heFGwc+EYK7SZjmGKGCZlZwPQyJ0aykNGCcBYBC5xKQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W+UQ2EkOoSNDxv7eI9OH3I9u2W1Qakc8CM2n9fwPFtEfX1Co87HAMvNGNp9Jn/G2J
	 icr+b35bPFdZJ9+p9NCMJZ9fN4SyMEJoWcaRbIQGYQ25xqNgzrULoTD/prGYWbn5XZ
	 hq88z/Z1arX+9NsSK/LHkiIIoRJEKe/usbuigL6sCQ42g1Dnwss1XUoriZS9/OfBBl
	 SJr7uyEXdvbWu6aTNYeU7wSDVDXG7M+sIOEXmRlIoB6yCiBI0EJUUAChZIBVEpZxl8
	 aWWHo1rwiGMXccftu+VWrKG4zAWU1szROmdHB/ALIcDlD6/lsJoRWjRBsYQfQtQQl7
	 WWBURTJi3c7jQ==
Subject: Re: [PATCH net v3 3/4] ipmr: set up GSO state for tunnel vifs
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, steffen.klassert@secunet.com, willemb@google.com,
 jiayuan.chen@linux.dev, mfleming@cloudflare.com, almasrymina@google.com,
 bigeasy@linutronix.de, richardbgobert@gmail.com, ecree.xilinx@gmail.com,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 13:17:08 +0000
Message-ID: <179241582899.3135.13813714752467284187@kernel.org>
In-Reply-To: =?utf-8?q?=3C5b5fb061bec2fc8d75c448b41159e0e338c89cbe=2E1792327?=
 =?utf-8?q?155=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
References: =?utf-8?q?=3C5b5fb061bec2fc8d75c448b41159e0e338c89cbe=2E17923271?=
 =?utf-8?q?55=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ip_encap() (net/ipv4/ipmr.c:1844-1846) now calls
  iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4) and then…
- [Medium] ip_encap() (net/ipv4/ipmr.c:1862) still sets the outer header
  with `iph->tot_len = htons(skb->len)`.

--

ipmr: set up GSO state for tunnel vifs

This patch changes ip_encap() to call iptunnel_handle_offloads() with
SKB_GSO_IPXIP4 and then skb_set_inner_ipproto(skb, IPPROTO_IPIP), the same
way ipip_tunnel_xmit() does. It also reserves one outer IP ID per segment
through ip_select_ident_segs(). ip_encap() now returns an error, and
ipmr_prepare_xmit() passes that error on.

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c452..6f2eb571f30f7 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1835,12 +1835,17 @@ static struct notifier_block ip_mr_notifier = {

[ ... ]

> +static int ip_encap(struct net *net, struct sk_buff *skb,
> +		    __be32 saddr, __be32 daddr)
>  {
> +	const struct iphdr *old_iph;
>  	struct iphdr *iph;
> -	const struct iphdr *old_iph = ip_hdr(skb);
>  
> +	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
> +		return -1;
> +	skb_set_inner_ipproto(skb, IPPROTO_IPIP);

[Severity: Medium]
What happens here if the GSO skb already has skb->encapsulation set?

ipip_tunnel_xmit() runs as ndo_start_xmit on a device with IPIP_FEATURES
and no hw_enc_features. Because of that, validate_xmit_skb() segments an
already-encapsulated GSO skb in software before it reaches
iptunnel_handle_offloads(). ip_encap() has no such filter.

GRO can hand ipmr skbs like this. For GRE, gre_gro_complete() sets
encapsulation = 1 and SKB_GSO_GRE, and inet_gro_complete() sets
inner_protocol to htons(ETH_P_IP). VXLAN and other UDP tunnels with a local
GRO socket behave the same way.

For these skbs, iptunnel_handle_offloads() skips skb_reset_inner_headers()
because encapsulation is already set. It then ORs SKB_GSO_IPXIP4 into the
existing tunnel gso_type. skb_set_inner_ipproto() overwrites the
inner_ipproto byte of the inner_protocol union and sets
inner_protocol_type to ENCAP_TYPE_IPPROTO.

For GRE, software segmentation goes through
inet_gso_segment()->ipip_gso_segment(), which now succeeds. After that,
gre_gso_segment() does:

net/ipv4/gre_offload.c:gre_gso_segment() {
    ...
	skb->protocol = skb->inner_protocol;
    ...
}

inner_protocol is now 0x0400 instead of 0x0800, so skb_mac_gso_segment()
fails. Doesn't that mean the packet is still dropped in validate_xmit_skb()
after DEV_STATS_INC(tx_packets)? That is the symptom the commit message
says this patch fixes.

For a UDP tunnel, skb_udp_tunnel_segment() takes the ENCAP_TYPE_IPPROTO
branch and calls inet_offloads[IPPROTO_IPIP]. inet_gso_segment() then
parses the inner Ethernet frame as an IPv4 header.

Some NICs have hw_enc_features covering both the existing tunnel type and
IPXIP4. On those, the doubly encapsulated skb would reach hardware with
inner headers that skip the middle tunnel layer.

Remote GRE or VXLAN traffic can reach this. It needs a multicast group
with an MFC entry that has a VIFF_TUNNEL oif:

ip_mr_input()->ipmr_queue_fwd_xmit()->ipmr_prepare_xmit()->ip_encap()

Would it make sense to segment in software, or reject, GSO skbs that
already have skb->encapsulation set before calling
iptunnel_handle_offloads()?

> +
> +	old_iph = ip_hdr(skb);
>  	skb_push(skb, sizeof(struct iphdr));
>  	skb->transport_header = skb->network_header;
>  	skb_reset_network_header(skb);
> @@ -1855,11 +1860,12 @@ static void ip_encap(struct net *net, struct sk_buff *skb,
>  	iph->protocol	=	IPPROTO_IPIP;
>  	iph->ihl	=	5;
>  	iph->tot_len	=	htons(skb->len);

[Severity: Medium]
Can tot_len be truncated here, now that ip_encap() turns GSO skbs into
valid IPXIP4 GSO packets?

The inner IPv4 datagram can be up to 65535 bytes. skb_gro_receive() only
rejects when p->len + len >= GRO_LEGACY_MAX_SIZE for non-TCP, or
>= gro_ipv4_max_size (default 65536) for TCP. Local UDP_SEGMENT is capped
at IP_MAX_MTU.

After the 20-byte push, skb->len can be 65536 to 65555. htons() then
truncates tot_len to 0 to 19, which is less than ihl * 4. With BIG TCP GRO
it can be any truncated value. ip_send_check() then computes the checksum
over that value.

The iptunnel_xmit() path this patch mirrors goes through __ip_local_out(),
which does:

	iph_set_totlen(iph, skb->len);

inet_gro_complete() does the same. iph_set_totlen() writes 0 above
IP_MAX_MTU.

Software segmentation hides the problem, because inet_gso_segment()
rewrites tot_len for each segment. Anything that sees the unsegmented GSO
skb sees the malformed header. That includes FORWARD and POST_ROUTING
netfilter (for example xt_length via iph_totlen()), egress tc/BPF, packet
taps and pass-through devices.

veth, for example, advertises NETIF_F_GSO_ENCAP_ALL in hw_enc_features and
NETIF_F_GSO_SOFTWARE in features. The peer namespace gets the GSO skb
intact, and ip_rcv_core() drops it:

net/ipv4/ip_input.c:ip_rcv_core() {
    ...
	len = iph_totlen(skb, iph);
	if (skb->len < len) {
    ...
	} else if (len < (iph->ihl*4))
		goto inhdr_error;
    ...
}

Both ipmr_queue_fwd_xmit() and ipmr_queue_output_xmit() reach this through
ipmr_prepare_xmit()->ip_encap().

When UDP GRO forwarding, fraglist GRO or TCP GRO aggregates multicast
traffic, a remote sender can pick segment sizes that put the aggregate in
this range. For example, 50 x 1310-byte UDP payloads gives 65528. Once a
VIFF_TUNNEL vif exists, a local UDP_SEGMENT sender can do the same.

At this commit, only DF-clear GSO skbs near 64K get past the MTU check in
ipmr_prepare_xmit(). The issue is still there at the end of the series.
The follow-up patch checks the length of each segment instead, which also
lets DF-set GSO aggregates reach this code.

Should this use iph_set_totlen(iph, skb->len) instead?

> -	ip_select_ident(net, skb, NULL);
> +	ip_select_ident_segs(net, skb, NULL, skb_shinfo(skb)->gso_segs ?: 1);
>  	ip_send_check(iph);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792293419.git.julius%40bairaktaris.de
