Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637990;
	b=ymv8nDMGKyJz8pWgK8iPwU+ueMvCQwqgfIXNamCwJhebRnx0Xi23RqBwuCftEh7py+CR
	 sCrX43kHEY5M+ZdL5nKfHFUBh8QkU3I2jfAo8qKLvO6jFHyjTiKC9GfaYKjyYl7+KDM/2
	 7mGnfs1FO/aU7qLesr124ddKk0B0Y/1Q2pBnYylNhwIa+w4fOGqZreI85u/vcXc2tgFRz
	 hPk+Fi4vGGrMB/ckB3b9Ot9sZ04XC0YRHZ+5+g4bcpR5pdGa6W0v4Ty+OC4+KI4ZOZ7WW
	 GEy/el1va1c0FmN8Hun3SxwDpCXvYs2IhgPNQZlA3jm6t0+sasqH+uB/uN+EzDnQ8ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637990;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xOedA95UBVr6IUchxeYQLJLIgKfkEV6sd7a+LlQ2eqY=;
	b=rL/XMmckzqYdOrBMi84xbkDIie63Tr07rarZ4hWZUY9sMQkflZyOu63BuCuu6O5p2xyk
	 MIddJHmkF8YYiUeeDxNruziAhKe3vO2wzwCtgugR9Gd7MKuBfxlJapcSCzQ++M9uGsxi8
	 mLKlMg6PIbYinCL0UH/0k9O+/mL/AFAhYmNFqlFwJGIKOkYym4M5KeaWTRHWKvzvZiHVZ
	 p4bdmZuBZv9eXMYHFTvxjIFMnjsPh2OhmVsu/AXLRZlBCMjmYx3ae9Q+n841sH5BM7vml
	 q+ack1hgcMbT8n1acAJzMUwwUPR74Dmvhcvu4OKdwi7GCzWB4jlceTModBNGV4d2txA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLSTIdhK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477A606A31A;
	Thu, 22 Oct 2026 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bLSTIdhK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB6C1F000C1;
	Thu, 22 Oct 2026 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792637990;
	bh=xOedA95UBVr6IUchxeYQLJLIgKfkEV6sd7a+LlQ2eqY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bLSTIdhK19WKYU92YFi6rCv9yA7v6aXnKsLog6ChLfKzjsu10mEmigzMz0T6zEgzN
	 +LoZUwhju5NtVTrvU0I/yVQQIQzk7cFFrutjCGV6qNYvDM9zOWCfcF8FWEGKSqmeUW
	 mBb2Ql1VymTJ6yCCe56FcUDycL/iQbCQ5r05tLcOj8yyFRVUdptb59T0RnxjgmzOX3
	 /BiYrmSwKqzFZQL+K1RyjND5CB7ER3ra6zVDvQlbNUq5uECbzfl2VCIS7CH+8600q9
	 MnEc2IKZej5d94yroypKswA1QuZP9Ofx7DMndDp8dZpf/0Oc3/uvDUN/WIu0bLZDHg
	 s+YljzY7agwHQ==
Subject: Re: [PATCH net v2] net: gso: validate transport header before
 computing segment length
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemb@google.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 maxk@qualcomm.com, netdev@vger.kernel.org
Date: Thu, 22 Oct 2026 02:59:48 +0000
Message-ID: <179263798891.3135.3227135992904229099@kernel.org>
In-Reply-To:
 <a53dbcdf068b3813689cf2359949578f627f9edd.1792410745.git.mst@redhat.com>
References:
 <a53dbcdf068b3813689cf2359949578f627f9edd.1792410745.git.mst@redhat.com>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes legitimate encapsulated TCP fraglist GRO
  packets fail the GSO length checks.
- [High] net: gso: skb_gso_transport_header_ok() drops XFRM tunnel TCP
  GSO packets
- [Medium] net: skb_inner_transport_header_was_set() returns true for ~0U
  sentinel

--

net: gso: validate transport header before computing segment length

This patch adds skb_gso_transport_header_ok(). With it, the TCP GSO
length validators reject an skb when its transport header (or inner
transport header) is unset or lies outside the linear data.
skb_gso_network_seglen() and skb_gso_mac_seglen() now return a negative
errno, and skb_gso_validate_network_len() and skb_gso_validate_mac_len()
turn that into false.

> diff --git a/net/core/gso.c b/net/core/gso.c
> index e96ef63500648..874e4c8b1f1bb 100644
> --- a/net/core/gso.c
> +++ b/net/core/gso.c
> @@ -131,6 +131,35 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>  }
>  EXPORT_SYMBOL(__skb_gso_segment);
>  
> +/*
> + * TSO processing (but not UDP/SCTP GSO, which uses fixed header
> + * sizes) reads the TCP header as specified by
> + * skb->transport_header/inner_transport_header.  Make sure it is
> + * there to read.
> + */
> +static bool skb_gso_transport_header_ok(const struct sk_buff *skb)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	int thoff;
> +
> +	if (unlikely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
> +		return true;
> +
> +	if (skb->encapsulation) {
> +		if (!skb_inner_transport_header_was_set(skb))
> +			return false;

[Severity: High]
Does this break TCP GSO over IPsec tunnel and BEET mode SAs that use
ESP offload?

xfrm_dev_offload_ok() succeeds for software ESP GSO via
esp4_offload/esp6_offload and also for XFRM_DEV_OFFLOAD_CRYPTO. When
it does, xfrm_output() sets skb->encapsulation on a GSO skb before the
outer mode has run:

net/xfrm/xfrm_output.c:xfrm_output() {
	...
		skb->encapsulation = 1;

		if (skb_is_gso(skb)) {
			...
			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
			goto out;
		}
	...
}

For a plain TCP skb, inner_protocol is 0, so xfrm_output_gso() is not
taken. The skb goes through xfrm_output2(), xfrm_output_resume()
and xfrm_output_one() to xfrm4_prepare_output(). That calls
xfrm_inner_extract_output(), which reaches xfrm4_tunnel_check_size()
and skb_gso_validate_network_len(). Only after that does
xfrm4_tunnel_encap_add() call skb_set_inner_transport_header(). In
BEET mode, xfrm4_beet_encap_add() does not set it at all.
xfrm6_prepare_output() and xfrm6_tunnel_check_size() follow the same
order.

So the skb seen by skb_gso_transport_header_ok() has encapsulation
set, SKB_GSO_TCPV4 or SKB_GSO_TCPV6 in gso_type and
inner_transport_header == 0. Before this patch,
skb_gso_network_seglen() returned a bogus but small value that passed
the MTU check. The unsigned subtraction of transport_header in
skb_gso_transport_seglen() cancelled against the transport_header -
network_header term. Now the check fails every time.

xfrm4_tunnel_check_size() (with DF set) and xfrm6_tunnel_check_size()
then return -EMSGSIZE and report an MTU error. For local sockets that
goes through xfrm_local_error(), otherwise through ICMP_FRAG_NEEDED or
ICMPV6_PKT_TOOBIG. The reported MTU is one the flow already fits in.
As far as I can tell, every TCP GSO packet on such an SA is dropped.
That makes this a regression for what looks like a common IPsec
setup, and the Fixes: tag means it is likely to be backported to
stable.

Should xfrm set the inner headers before xfrm_inner_extract_output()
runs? Or should this check key off the tunnel gso_type bits rather
than skb->encapsulation alone? Falling back to the outer transport
header when inner_transport_header is unset might be another option,
though skb_gso_transport_seglen() would need the same treatment.

[Severity: Medium]
Does this treat an inner transport header that was copied from an
unset outer one as set?

skb_inner_network_header_was_set() can get away with a > 0 test
because network_header starts at 0 and is never set to ~0U. That does
not hold for transport_header. __finalize_skb_around() initialises it
to (typeof(skb->transport_header))~0U and skb_unset_transport_header()
puts it back there. skb_reset_inner_headers() copies it verbatim:

include/linux/skbuff.h:skb_reset_inner_headers() {
	...
	skb->inner_transport_header = skb->transport_header;
}

bpf_skb_net_grow() does the same. iptunnel_handle_offloads(),
bpf_lwt_push_ip_encap(), bpf_push_seg6_encap() and gtp_dev_xmit() all
go through skb_reset_inner_headers(). An skb whose transport header
was never set, or was unset as gro_cells_receive() does, therefore
ends up with skb->encapsulation = 1 and inner_transport_header ==
0xffff.

For such an skb, skb_inner_transport_header_was_set() returns true.
skb_gso_transport_header_ok() then only rejects it through the bounds
test on thoff = 0xffff - skb_headroom(skb). Consider a large linear
GSO skb where
skb_headroom(skb) + skb_headlen(skb) >= 65535 + sizeof(struct tcphdr),
for example one that bpf_skb_net_grow() has just linearized. It passes
that test, and inner_tcp_hdrlen() in skb_gso_transport_seglen() then
reads payload at skb->head + 0xffff as a TCP header. The access stays
within the linear area, but the segment length is then computed from
arbitrary payload bytes. That is what the unset check is meant to
prevent.

The helper lives in include/linux/skbuff.h, so other callers may pick
it up with the same blind spot. Should it also treat
(typeof(skb->inner_transport_header))~0U as unset, the way
skb_transport_header_was_set() does for the outer header?

[Severity: High]
Can this reject legitimate TCP fraglist GRO packets that arrive inside a
UDP tunnel?

udp_gro_complete() sets skb->encapsulation before it calls the tunnel's
inner gro_complete. It also clears encap_mark so that inner frag_list
completion can run:

net/ipv4/udp_offload.c:udp_gro_complete() {
    ...
		NAPI_GRO_CB(skb)->encap_mark = 0;
		...
		skb->encapsulation = 1;
		err = udp_sk(sk)->gro_complete(sk, skb,
				nhoff + sizeof(struct udphdr));
    ...
}

tcp4_check_fraglist_gro() sets is_flist = !sk && !skb_is_gso(skb) and
never looks at encapsulation. Any inner flow without a local socket
qualifies, for example forwarded traffic or containers behind a VXLAN
bridge. tcp4_gro_complete() then returns early:

net/ipv4/tcp_offload.c:tcp4_gro_complete() {
    ...
	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;

		__skb_incr_checksum_unnecessary(skb);

		return 0;
	}
    ...
	tcp_gro_complete(skb);
    ...
}

tcp_gro_complete() is the only TCP GRO code that sets the inner
transport header:

net/ipv4/tcp_offload.c:tcp_gro_complete() {
    ...
	if (skb->encapsulation)
		skb->inner_transport_header = skb->transport_header;
    ...
}

tcp6_gro_complete() has the same flist early return.

The resulting skb has encapsulation set, a gso_type that includes
SKB_GSO_UDP_TUNNEL, SKB_GSO_FRAGLIST and SKB_GSO_TCPV4, and
inner_transport_header == 0.

Before this patch, skb_gso_transport_seglen() read the TCP data offset
relative to skb->head, which is inside the headroom. The unsigned
arithmetic gave a value that passed the size check. After this patch,
skb_gso_validate_network_len() and skb_gso_validate_mac_len() always
return false for these skbs.

Some effects of that:

tcf_police_mtu_check() always takes the exceed action, even with the
default tcfp_mtu of ~0.

ip_exceeds_mtu() returns true, so ip_forward() sends ICMP_FRAG_NEEDED
with the route MTU and drops DF transit tunnel traffic. GRO applies to
that traffic when it matches a wildcard-bound local tunnel socket. The
sender already honours that MTU, so the flow stays blackholed.

ip_finish_output_gso() falls back to software segmentation and
fragmentation.

Triggering this needs rx-gro-list enabled on the NIC and a UDP tunnel
socket with gro_receive, but the packets themselves come from remote
traffic. The patch also has a Fixes: tag, so it will likely be
backported to stable kernels that have TCP fraglist GRO.

Would it make sense to set inner_transport_header in the flist branch of
tcp4_gro_complete() and tcp6_gro_complete() when skb->encapsulation is
set? Another option is to skip the encapsulated check here for
SKB_GSO_FRAGLIST skbs.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/a53dbcdf068b3813689cf2359949578f627f9edd.1792410745.git.mst%40redhat.com
