Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266109;
	b=Ipd+vYdY+loNS7xelzIAsEsMcVxVS9kEtfeIEnzRtpaSd+wKPayiyXjaDUmBwrQn0XYz
	 Rpvf0qMPpUUjiQwY+o1f4lHRQWGg3puxbZMpC4HMw9gL9S5kDl67B4inyrWeLDhI1Bzkm
	 ud269x2SyiZTemICdBBeYFaT1ptZobKUHo0mQ9r7jh5X+XpdzAwYrLqiKDCw6fulZlfno
	 c8mV+C3V4c8ipVCQiaOkXR+77+ot4ACxqno6fIN8ZwZNWnbkZquvgH9N2FE6FwRbfZ2GC
	 UZJagSTvDKdTEvrcM9omFbBUifpFwntNkzeZKzal5enslKnZSUzwdk7RSRDbZjNSVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266109;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=r0AGVnM01kIUaGkf6kR1dSTWzli43gPVJ7yCU8tXTOU=;
	b=xE+uZW7PfV2L/Wr/d+rIBizKW7rjYyr+hzcQVLoClz5R1biG3nrqVnQIAbvm42eoeQLT
	 G30WkIxm4f2MOwLpduBHOFTwtg+ujE2OQzoO7LEYR0DJMKbq0RhCHrSP5l2p9u6OmDcey
	 YoktZ2x1XcVLrldV0Q2PK7kAqpOUftaVHIgmMNY5+rDPwct+9GB5aYZFjvmjFNMrsAXSj
	 doUSoM5mJg8jd/9cO89RhmQP09KlNlSOjaxB1C9GbEqrj+J3PwWsUb1rEiiWkcl02O+0Z
	 Q91mmesh6oO8PTCdiRdUITFz+yQgm/s/WEeANNzMy5yOVEa6/Q0nQHIPaBLaWLV+oTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6PtGTW2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF888606A335
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6PtGTW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7151F008A4;
	Mon,  9 Nov 2026 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266108;
	bh=r0AGVnM01kIUaGkf6kR1dSTWzli43gPVJ7yCU8tXTOU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J6PtGTW2Grm0erqfGntHv2oMv7ZisI5rejYIVfBKPFw0tGaAVqyQHptd3/uM6eCSm
	 GtfS4LYgsjiXI5X9EytIw8+8381vl2OGiJK46NLjFlWjlwXPOeBNsq6MM5JsV49AOC
	 jUfLLmyZYQv1rFHzW5yTu/iIzoY83nyqhcrJbVxXUygCUJ7JuIQEtmOIpL8OtPsVP8
	 gWHc5PMlPAs7N2Bxqc6q1Bf+VhHmX9bhNC3suERPIgdqaum7FO+uJJOWlTSSTsJMQS
	 THG7bfi+AFlpzOdV3DXVLwBWw/af6lm1MLLWfeXSCO0PZAGmiYIdMy7p7Y/HOD2JQQ
	 2DogSmY8jFPPg==
Subject: Re: [PATCH net-next 4/4] ipv6: ioam: keep transport header after
 inline insertion
From: netdev-bot+sashiko@kernel.org
To: tactii@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrea.mayer@uniroma2.it, justin.iurman@gmail.com,
 aahringo@redhat.com, willemb@google.com, alexander.duyck@gmail.com
Date: Mon, 09 Nov 2026 23:15:07 +0000
Message-ID: <179426610753.994134.12937361068695825700@kernel.org>
In-Reply-To: <20261105201309.3182307-5-tactii@gmail.com>
References: <20261105201309.3182307-5-tactii@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch fixes a user-visible regression but has no Fixes: tag.
- [Low] In ioam6_output() (net/ipv6/ioam6_iptunnel.c:379-387), the new
  restore of transport_header assumes the original transport header sits…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is the same
  failure in the same function ioam6_output().

--

ipv6: ioam: keep transport header after inline insertion

After ioam6_do_inline() runs, the patch puts transport_header back where
it was. It does this by saving the L4 header's distance from the end of
the packet before the insertion. The goal is to stop GSO length checks,
such as qdisc_pkt_len_segs_init(), from reading the inserted hop-by-hop
header as TCP and dropping packets as SKB_BAD_GSO.

> read that header as TCP, and since commit 7fb4c1967011 ("net: pull
> headers in qdisc_pkt_len_segs_init()"), a bogus doff below 5 there makes
> __dev_queue_xmit() drop each GSO packet of the flow as SKB_BAD_GSO. This

[Severity: Low]
Should this patch carry a Fixes: tag?

The commit message names 7fb4c1967011, which added the SKB_BAD_GSO drop
in qdisc_pkt_len_segs_init() in net/core/dev.c. The notes below the ---
line name 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with
lwtunnels"). Those notes are discarded when the patch is applied, and
neither commit is listed as a Fixes: tag.

Without one, stable trees that contain 7fb4c1967011 may not pick up this
fix.

The sibling patches in the series also have no Fixes: tags: "ipv6: sr:
keep transport header after inline SRH insertion", "ipv6: rpl: keep
transport header after SRH insertion" and "ipv6: fix transport header of
forwarded GSO packets".

> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index cfb2c41634a0b..27b47f0c8bf8f 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c

[ ... ]

> @@ -375,10 +376,16 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
>  			goto out;
>  
> +		if (skb_transport_header_was_set(skb))
> +			tail_len = skb->len - skb_transport_offset(skb);
> +
>  		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, dst);
>  		if (unlikely(err))
>  			goto drop;
>  
> +		if (tail_len >= 0)
> +			skb_set_transport_header(skb, skb->len - tail_len);
> +

[Severity: Low]
Does this restore in ioam6_output() assume that the original transport
header starts at or after offset sizeof(struct ipv6hdr)?

ioam6_do_inline() moves the first 40 bytes to the new data start and
inserts the hop-by-hop header right after them:

    hdr = ipv6_hdr(skb);
    memmove(hdr, oldhdr, sizeof(*oldhdr));

So only bytes at offset 40 or later keep their distance from the end of
the packet.

rawv6_send_hdrinc() in net/ipv6/raw.c sets:

    skb->transport_header = skb->network_header;

so skb_transport_offset() is 0 by the time the packet reaches
ioam6_output() via NF_HOOK(..., dst_output)->lwtunnel_output(). In inline
mode, and in auto mode because skb->dev is NULL, tail_len becomes
skb->len. After the insertion, transport_header ends up at hdrlen.

hdrlen is a multiple of 8 and at least 16. That puts transport_header in
the middle of the new IPv6 header, or inside the hop-by-hop TLVs, rather
than on a header boundary. Before this patch it pointed at the start of
the hop-by-hop header, at offset 40.

These packets are not GSO, so the wrong offset may only be seen by code
that reads skb->transport_header directly, such as tracing or BPF.

Would checking skb_transport_offset(skb) >= sizeof(struct ipv6hdr) before
saving tail_len keep the old placement in this case? The sibling seg6 and
rpl patches in this series appear to use the same pattern.

>  		break;
>  	case IOAM6_IPTUNNEL_MODE_ENCAP:
>  do_encap:

[Severity: High]
This isn't a bug introduced by this patch, but can the encap branch of
ioam6_output() still drop TCP GSO packets the same way?

ioam6_do_encap() does:

    skb_push(skb, len);
    skb_reset_network_header(skb);
    skb_mac_header_rebuild(skb);
    skb_set_transport_header(skb, sizeof(*hdr));

That leaves transport_header pointing at the outer hop-by-hop header.
ioam6_do_encap() never calls iptunnel_handle_offloads(), and it never sets
skb->encapsulation, the inner transport header, inner_protocol or
SKB_GSO_IPXIP6.

When skb->encapsulation is clear, qdisc_pkt_len_segs_init() does:

    hdr_len = skb_transport_offset(skb);
    ...
    th = (const struct tcphdr *)(skb->data + hdr_len);
    tlen = __tcp_hdrlen(th);
    if (tlen < sizeof(*th))
        return SKB_DROP_REASON_SKB_BAD_GSO;

Here __tcp_hdrlen() reads the first trace-type byte of the hop-by-hop
header. That gives the same trace-type dependent drop that the commit
message describes for inline mode. skb_gso_validate_network_len() in
ip6_finish_output_gso() reads the same bogus doff.

When software segmentation is needed, ipv6_gso_segment() skips the
hop-by-hop header, finds IPPROTO_IPV6 and calls ip6ip6_gso_segment(),
which does:

    if (!(skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6))
        return ERR_PTR(-EINVAL);

This fails whatever the trace type is.

The commit message says the bug "affects forwarded packets too". In
IOAM6_IPTUNNEL_MODE_AUTO, forwarded packets have skb->dev set and take
do_encap instead of do_inline:

    ip6_forward()->dst_output()->lwtunnel_output()->ioam6_output()
        ->ioam6_do_encap()

Would forwarded TCP GSO traffic in auto mode, and any traffic in encap
mode, still be dropped after this patch?

seg6_do_srh() in net/ipv6/seg6_iptunnel.c calls
iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6) and sets the inner
transport header and inner protocol. Does ioam6_do_encap() need something
similar?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105201309.3182307-1-tactii%40gmail.com
