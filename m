Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC04973B0;
	Mon, 19 Oct 2026 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415830; cv=none; b=qwbgi5DIsQ5Jy6gGDn3+vM/1UAWS4/65BPAqASEbFDR5QLCPfXJmO0KI//CXzQHUtp7x26kSP726XXNTtXTzXl65I2kA0UHHACtl7PiDIq7OszxQGZtRiPZIYXvUrjGBtG5sJiI0aya6VaYdT2QCOgS1L62g63TvOWlC68MC7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415830; c=relaxed/simple;
	bh=bZUqQWktStaMbxALkgR06bKcmC0j8bzHKglsGIUUxKs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBlyG6piKBXxvtj55TTPtrZbX+K9s9ho5XzitT09ZUhJWfbmfW9bFZ38SWctn9S2N9FXCQAiuVpAtRMPB+Rh+y5m4TNoUo+gJX1k4oAVjOqYQXo3xw007YEC4eoyDnjSCiELE7VsU8PA9FWjy4tUR78mce1nEmD1Ffhw2+KNhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3CYLSMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3CYLSMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E8B1F000C4;
	Mon, 19 Oct 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415828;
	bh=1u+xUNOp+6+cEQa0Ok+c/jSZhF4TwAVaD9sAPvnyKSM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i3CYLSMeAv/f3iPEQj5GIeDN4NXwpfRgLd5WbCzD3aIyNvsVFLKFvX3C+qWvYRQu/
	 nUsSu+NQPvoOjxo3tGNHx2AZpeLbndnIF+zt6FInrTUc7lTrSN+IGbKjfB1b67reZw
	 +5DQ/OKS1HpsDjy0PdyMHtW6I2DtFYq1SeN9zJs0hLfk7BzxaxdTQqG0pdaCeiRIKd
	 mua8bb8wzo0ADIt3VBSchj2wL0UxeoX5LP3AR2VjB3Zz2mCU45KEWj7Wt4l2VMidmV
	 nKO+LAX378SVyb6Qj5XVLd3JH1qUl0BqOnYQLCq1n7yA94rBQbMviCC8CXW1JGEb5+
	 B2KqMF2/HV51Q==
Subject: Re: [PATCH net v3 2/4] ip_tunnel: move the TCP fixed-ID flag to the
 inner header
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, steffen.klassert@secunet.com, willemb@google.com,
 jiayuan.chen@linux.dev, mfleming@cloudflare.com, almasrymina@google.com,
 bigeasy@linutronix.de, richardbgobert@gmail.com, ecree.xilinx@gmail.com,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 13:17:07 +0000
Message-ID: <179241582749.3135.6106878374160339370@kernel.org>
In-Reply-To: =?utf-8?q?=3C44dce02a36429356aa12372bd928fc79d45bb965=2E1792327?=
 =?utf-8?q?155=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
References: =?utf-8?q?=3C44dce02a36429356aa12372bd928fc79d45bb965=2E17923271?=
 =?utf-8?q?55=2Egit=2Ejulius=40bairaktaris=2Ede=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new hunk in iptunnel_handle_offloads() assumes that whenever
  skb->encapsulation is 0, SKB_GSO_TCP_FIXEDID describes the skb's…
- [Medium] ip_tunnel: iptunnel_handle_offloads() breaks inner fixed ID
  for GRE/UDP GSO

--

ip_tunnel: move the TCP fixed-ID flag to the inner header

When a GSO packet is encapsulated, iptunnel_handle_offloads() now moves
SKB_GSO_TCP_FIXEDID to SKB_GSO_TCP_FIXEDID_INNER. The aim is that software
segmentation keeps fixed IDs on the header that GRO merged with fixed IDs,
which becomes the inner header after encapsulation.

> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index bab42b9e277f7..752ddba1298b6 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -174,18 +174,29 @@ EXPORT_SYMBOL_GPL(iptunnel_metadata_reply);
>  int iptunnel_handle_offloads(struct sk_buff *skb,
>  			     int gso_type_mask)
>  {
> +	bool inner = false;
>  	int err;
>
>  	if (likely(!skb->encapsulation)) {
>  		skb_reset_inner_headers(skb);
>  		skb->encapsulation = 1;
> +		inner = true;
>  	}
>
>  	if (skb_is_gso(skb)) {
> +		struct skb_shared_info *shinfo;
> +
>  		err = skb_header_unclone(skb, GFP_ATOMIC);
>  		if (unlikely(err))
>  			return err;
> -		skb_shinfo(skb)->gso_type |= gso_type_mask;
> +
> +		shinfo = skb_shinfo(skb);
> +		/* The header SKB_GSO_TCP_FIXEDID described is now the inner one */
> +		if (inner && (shinfo->gso_type & SKB_GSO_TCP_FIXEDID)) {
> +			shinfo->gso_type &= ~SKB_GSO_TCP_FIXEDID;
> +			shinfo->gso_type |= SKB_GSO_TCP_FIXEDID_INNER;
> +		}

[Severity: Medium]
iptunnel_handle_offloads() is not only used by the IP-in-IP tunnels.
gre_handle_offloads() in ip_gre and ip6_gre, vxlan_build_skb(),
__fou_build_header(), __gue_build_header() and
udp_tunnel_handle_offloads() (geneve, bareudp) all call it. That means
the conversion to SKB_GSO_TCP_FIXEDID_INNER now also happens for GRE
and UDP tunnels. Does their software GSO path ever look at the inner
bit?

inet_gso_segment() picks the bit from the nesting level:

	encap = SKB_GSO_CB(skb)->encap_level > 0;
	...
	fixedid = !!(skb_shinfo(skb)->gso_type &
		     (SKB_GSO_TCP_FIXEDID << encap));

ipip_gso_segment() and ip4ip6_gso_segment() keep encap_level non-zero
when they recurse into inet_gso_segment() for the inner IPv4 header.
gre_gso_segment() and __skb_udp_tunnel_segment() do not. Both set up
the inner skb with:

	skb->encapsulation = 0;
	SKB_GSO_CB(skb)->encap_level = 0;

They do this before calling skb_mac_gso_segment() or
gso_inner_segment(). So when inet_gso_segment() runs on the inner IPv4
header of a GRE or UDP tunnel packet, encap is 0. It then tests
SKB_GSO_TCP_FIXEDID, which this patch has just cleared.
SKB_GSO_TCP_FIXEDID_INNER is never consulted for that header.

Take a TCPv4 flow that GRO merged with fixed IDs (tcp4_gro_complete()
sets SKB_GSO_TCP_FIXEDID). Forward it into a GRE or VXLAN tunnel device
where it is segmented in software:

  ipgre_xmit() / vxlan_xmit_one() -> iptunnel_handle_offloads()
    (SKB_GSO_TCP_FIXEDID becomes SKB_GSO_TCP_FIXEDID_INNER)
  __skb_gso_segment() -> inet_gso_segment() for the outer header
    -> gre_gso_segment() / __skb_udp_tunnel_segment()
       (encap_level reset to 0)
    -> inet_gso_segment() for the inner header
       (encap == 0, so fixedid == 0)

Wouldn't the inner header then get iph->id = htons(id++) on every
segment? That is the inner ID rewriting this patch sets out to avoid.

For an IPv6 outer header (ip6_gre, VXLAN6, GENEVE6, bareudp over IPv6,
FOU6/GUE6) carrying inner IPv4, this looks like a plain regression.
Before the patch SKB_GSO_TCP_FIXEDID stayed set, the inner
inet_gso_segment() ran with encap_level 0, and the fixed inner IDs
were preserved. With the patch they start incrementing.

Should the move be limited to the tunnels whose GSO path keeps
encap_level non-zero for the inner header (the SKB_GSO_IPXIP4 and
SKB_GSO_IPXIP6 cases)? Or is the intent to also change
gre_gso_segment() and __skb_udp_tunnel_segment() so that the inner
inet_gso_segment() tests SKB_GSO_TCP_FIXEDID_INNER? Either way, the
bit written here and the bit read at segmentation time need to agree
for every caller of iptunnel_handle_offloads().

[Severity: High]
This assumes SKB_GSO_TCP_FIXEDID always describes the current outermost
header when skb->encapsulation is 0. Does the decap side keep that true?

iptunnel_pull_offloads() in include/net/ip_tunnels.h only clears the
encap GSO bits and resets encapsulation:

include/net/ip_tunnels.h:iptunnel_pull_offloads() {
    ...
		skb_shinfo(skb)->gso_type &= ~(NETIF_F_GSO_ENCAP_ALL >>
					       NETIF_F_GSO_SHIFT);
	}

	skb->encapsulation = 0;
    ...
}

It does not move SKB_GSO_TCP_FIXEDID_INNER back to SKB_GSO_TCP_FIXEDID.
It also does not drop the SKB_GSO_TCP_FIXEDID bit that belonged to the
outer header it removed. This function is reached from
__iptunnel_pull_header() (VXLAN, GRE, Geneve, IPIP), fou_recv_pull(),
gue_udp_recv() and the seg6 decap path. bpf_skb_net_shrink() in
net/core/filter.c behaves the same way.

GRO sets the outer bit independently in tcp4_gro_complete():

	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);

inet_gso_segment() then picks a bit based on the nesting level:

	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));

Take a decap and re-encap gateway (for example VXLAN to GRE, or IPIP to
IPIP) where the received outer header had fixed IDs and the inner header
had incrementing IDs:

  vxlan/gre rcv -> __iptunnel_pull_header() -> iptunnel_pull_offloads()
    (the stale outer SKB_GSO_TCP_FIXEDID survives, encapsulation = 0)
  gro_cells_receive() -> ... -> ip_forward()
  ipgre_xmit() -> gre_handle_offloads() -> iptunnel_handle_offloads()
    (inner == true, so the stale bit becomes SKB_GSO_TCP_FIXEDID_INNER)
  inet_gso_segment() with encap == 1
    (fixedid is set for the inner header)

Wouldn't this give every segment the same inner IPv4 ID, even though
those IDs originally incremented? Before this patch, the wrong state
ended up on the new outer header. With the patch it ends up on the inner
one.

There is a second case. Take an skb that is encapsulated and then
decapsulated again without being segmented, such as a tunnel into a
netns over veth. Before this patch it kept SKB_GSO_TCP_FIXEDID. It now
carries SKB_GSO_TCP_FIXEDID_INNER, and that bit is ignored after decap.
Won't IDs that were originally fixed now come out incrementing?

A related problem predates this patch and has been there since
3271f19bf7b9: a decapsulated, forwarded GSO packet is segmented using
the fixed-ID state of the removed outer header, and its own
SKB_GSO_TCP_FIXEDID_INNER state is ignored.

Would a matching decap step in iptunnel_pull_offloads() and
bpf_skb_net_shrink() fix this? That step would set SKB_GSO_TCP_FIXEDID
from SKB_GSO_TCP_FIXEDID_INNER and clear the inner bit. Without it, the
fixed-ID flags can still describe the wrong header after crossing a
tunnel boundary.

> +		shinfo->gso_type |= gso_type_mask;
>  		return 0;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792293419.git.julius%40bairaktaris.de
