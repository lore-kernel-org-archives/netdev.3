Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266105;
	b=s6F3bizRxWR7o8uJHxn9OQnduqbteTbbYrrT2PtGTbxk96D43vDpkH/WXb1O4+kuXxyf
	 BfBKBrgVQW2ffiGyyD5xdsJVVIpnFzBZZC4/MhCNoqeq/z+/pPYY36UzyxjlfV2/1hCU/
	 Lr9DeqmzpBlrWr3gCC022BuMvTPdnTyECyndfoFElcymK3fSaTQmpq3J6U6knkCpOi5SQ
	 A7SKHAYvfpQ6uLUO1FTNe80fTBdzOJ4Rcea33oOjV8l9nMNWzl8IDi7LDU6JiQEcUyCH3
	 6oILbUJg7YGc3EmSw0CWVznhQX3g23Z5wqteJr23ysNQYA4N3Fvl033iZzCMSYWD1Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266105;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=g1aJkuxd0Ur2EcndcqLJniNjLXwxT7nR+FRcSV89gas=;
	b=md1HXnnCeleT2IFynkBeM8jvIooe8TVDVa11Ip6Hp/st5OTZQcoIddRnp5VPAusC4g2O
	 5rviKVCpBGBvEC5MU7po1ylxuPUMKxiWj388kI8gLKuPKDnK9h31h50mzuobhnrRqr7nx
	 MhssNYvxeZULm1s5ldIJ7XuTwdMJU/qgqRjd2qkcQ9LvZkhMjSU29MJkfZ3pRYR9N7Lw3
	 3VcmitJVc50yZUBGIXUIAHQJAy3HQAmDWu9tVd8JvvEIYjNGicUWJzo8D5iJClYplBB5x
	 9O25pApH7D8vONmS45wXQNTW+BZzUEbUfIGBqlIcH3sm+q1/mSkWwVd1L9VqZWmD7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2805Djz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75281606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2805Djz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA12F1F0089F;
	Mon,  9 Nov 2026 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266104;
	bh=g1aJkuxd0Ur2EcndcqLJniNjLXwxT7nR+FRcSV89gas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H2805DjznEqUoyd+zayJbfxuYKRIo4ucQvrxIIiG8S0NTI4VsMpXI1hnK9zaqQqE9
	 ceVVNvN+DY1mRPIwtWbfpmB71aRuo7+cDfFRJqzUiV0IQp6UHZxePKuLshXmRnD9O9
	 Ha13JLCbnWERz1Fh/iyGH+Cb8Lf/S0xjv5QOw+7Z7V/Yjy0ieWpYCzEhr4vqI3P+44
	 9Z3q4tSzdorDQpXxj9Ptv5S5ilgEvuOWs/Q4zvDrlrcK4V8UdG7Mxk9nsv+B3xzA18
	 6xg03CFmHRV9Af8gJlOAPqFPUCiawmG7VSZSyOZ+FIbT+bcndA3XCUVxvZNcNvC/F+
	 plpP3Wfd9bYtA==
Subject:
 Re: [PATCH net-next 1/4] ipv6: fix transport header of forwarded GSO packets
From: netdev-bot+sashiko@kernel.org
To: tactii@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrea.mayer@uniroma2.it, justin.iurman@gmail.com,
 aahringo@redhat.com, willemb@google.com, alexander.duyck@gmail.com
Date: Mon, 09 Nov 2026 23:15:03 +0000
Message-ID: <179426610333.994134.2644370589086394410@kernel.org>
In-Reply-To: <20261105201309.3182307-2-tactii@gmail.com>
References: <20261105201309.3182307-2-tactii@gmail.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ipv6: unvalidated csum_start in ip6_forward() moves
  transport_header backwards
- [Medium] In ip6_forward() (net/ipv6/ip6_output.c), the new else-branch
  sets transport_header to whatever ipv6_skip_exthdr() returns.
- [Low] The commit fixes a user-visible bug: forwarded IPv6 GSO flows
  with destination-options or routing headers stall on Packet Too Big at…

--

ipv6: fix transport header of forwarded GSO packets

This patch resets transport_header in ip6_forward() for GSO packets before
the MTU check. CHECKSUM_PARTIAL packets without encapsulation take it from
csum_start, and other packets with extension headers walk the chain with
ipv6_skip_exthdr(). This keeps skb_gso_validate_network_len() from reading
a bogus TCP header length, which caused Packet Too Big stalls and
SKB_BAD_GSO drops.

> skb_gso_validate_network_len() then reads a bogus TCP header length. An
> overestimate makes ip6_forward() answer with Packet Too Big at the
> current MTU, and the flow stalls. Since commit 7fb4c1967011 ("net: pull
> headers in qdisc_pkt_len_segs_init()"), a bogus doff below 5 also makes
> __dev_queue_xmit() drop the packet as SKB_BAD_GSO.

[ ... ]

> Signed-off-by: Matt Vollrath <tactii@gmail.com>

[Severity: Low]
Should this patch carry a Fixes: tag and a stable Cc? The only pointer to
where the bug came from, fe6cc55f3a9a ("net: ip, ipv6: handle gso skbs in
forwarding path"), is in the notes below the --- separator, and git am
strips those.

Stable trees that pick up 7fb4c1967011 would start dropping these
forwarded packets as SKB_BAD_GSO. Nothing in the commit points the stable
tooling at this fix.

Would a trailer like this in the commit body work, along with a mention of
7fb4c1967011?

Fixes: fe6cc55f3a9a ("net: ip, ipv6: handle gso skbs in forwarding path")

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..60ac56afbd06b 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -662,6 +662,23 @@ int ip6_forward(struct sk_buff *skb)
>  
>  	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
>  
> +	if (skb_is_gso(skb)) {
> +		if (skb->ip_summed == CHECKSUM_PARTIAL && !skb->encapsulation) {
> +			skb_set_transport_header(skb,
> +						 skb_checksum_start_offset(skb));
> +		} else if (ipv6_ext_hdr(hdr->nexthdr)) {
> +			u8 nexthdr = hdr->nexthdr;
> +			__be16 frag_off;
> +			int thoff;
> +
> +			thoff = ipv6_skip_exthdr(skb, skb_network_offset(skb) +
> +						 sizeof(*hdr), &nexthdr,
> +						 &frag_off);
> +			if (thoff >= 0)
> +				skb_set_transport_header(skb, thoff);

[Severity: High]
Can the CHECKSUM_PARTIAL branch move transport_header backwards, into
the fixed IPv6 header or even in front of skb->data?

csum_start is taken as is here. Nothing checks that
skb_checksum_start_offset(skb) is at least skb_network_offset(skb) +
sizeof(*hdr). Before this patch, the forwarding path kept the
transport_header set by ip6_rcv_core(), which never pointed inside the
fixed header.

For packets injected through tun/tap, macvtap or af_packet with
VIRTIO_NET_HDR_F_NEEDS_CSUM, csum_start comes from userspace. The check
in __virtio_net_hdr_to_skb() runs while skb->data still points at the
Ethernet header:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
    ...
		if (!skb_partial_csum_set(skb, start, off))
			return -EINVAL;
		if (skb_transport_offset(skb) < nh_min_len)
			return -EINVAL;
    ...
}

nh_min_len is sizeof(struct ipv6hdr) for VIRTIO_NET_HDR_GSO_TCPV6, so a
csum_start of 40 is accepted. After eth_type_trans() pulls the 14 byte
Ethernet header, that is offset 26 from the network header, in the
middle of the source address. A routed TCPV6 GSO packet built this way
takes this branch and gets transport_header set inside the IPv6
header. From there:

ip6_forward()
  ip6_pkt_too_big()
    skb_gso_validate_network_len()
      skb_gso_network_seglen()
        skb_gso_transport_seglen()
          thlen = tcp_hdrlen(skb);

This reads doff out of the address bytes. The network header length
comes out 14 bytes short and thlen is garbage, so the MTU checks here
and in ip6_finish_output_gso() use the wrong segment length.
qdisc_pkt_len_segs_init() later reads the same bogus doff.

It gets worse if the offset goes negative. bpf_prog_run_generic_xdp()
calls __skb_pull() after bpf_xdp_adjust_head() without adjusting
csum_start, so ip_summed can stay CHECKSUM_PARTIAL with csum_start
behind skb->data. A negative transport offset wraps the unsigned
arithmetic in skb_gso_network_seglen(), which lets the packet past the
MTU checks. Then, in qdisc_pkt_len_segs_init():

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
		hdr_len = skb_transport_offset(skb);
    ...
		th = (const struct tcphdr *)(skb->data + hdr_len);
    ...
}

hdr_len is an unsigned int. With a transport offset between -20 and -1
the length passed to pskb_may_pull() wraps to a small value that
passes, and th ends up about 4 GiB past skb->data on 64-bit. Reading
th->doff there would oops.

Would it be enough to use csum_start only when
skb_checksum_start_offset(skb) >= skb_network_offset(skb) +
sizeof(*hdr), and fall back to the ipv6_skip_exthdr() walk otherwise?

[Severity: Medium]
Can this make tcp_hdrlen() read past the linear data of the skb?

For each extension header, ipv6_skip_exthdr() reads only the 2-byte
generic header through skb_header_pointer(). After the last one it adds
hdrlen without a bounds check, and for destination or routing options
hdrlen can be up to 2048 bytes:

net/ipv6/exthdrs_core.c:ipv6_skip_exthdr() {
    ...
		nexthdr = hp->nexthdr;
		start += hdrlen;
    ...
}

So thoff can point into the page frags or past skb->len. The only check
here is thoff >= 0.

Right after this, the MTU check reads the TCP header directly at the new
offset:

ip6_forward()
  ip6_pkt_too_big()
    skb_gso_validate_network_len()
      skb_gso_network_seglen()
        skb_gso_transport_seglen()
          thlen = tcp_hdrlen(skb);

tcp_hdrlen() reads tcp_hdr(skb)->doff with no pskb_may_pull() and no
skb_header_pointer().

The else branch runs for TCP GSO skbs that are neither CHECKSUM_PARTIAL
nor encapsulated. Two examples are fraglist GRO (CHECKSUM_UNNECESSARY) and
virtio_net_hdr GSO packets without NEEDS_CSUM.

On ingress, only the extension header chain that was actually parsed gets
linearized. Suppose the chain is rewritten before ip6_forward(), for
example by nftables payload mangling in PREROUTING or by a tc BPF
store_bytes. Then the new thoff can land far past skb_headlen(), possibly
past skb->end. Both of those need CAP_NET_ADMIN, which an unprivileged
user namespace has inside its own netns.

Before this patch, transport_header on this path pointed just past the
fixed header, or past a hop-by-hop header that ipv6_parse_hopopts() had
already pulled. Either way the read stayed inside the linear data.

Would a pskb_may_pull(skb, thoff + sizeof(struct tcphdr)) check for TCP
GSO cover this, keeping the old transport_header if the pull fails?

> +		}
> +	}
> +
>  	mtu = ip6_dst_mtu_maybe_forward(dst, true);
>  	if (mtu < IPV6_MIN_MTU)
>  		mtu = IPV6_MIN_MTU;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105201309.3182307-1-tactii%40gmail.com
