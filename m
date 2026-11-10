Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321299;
	b=Ga2ctiuPnVVEUgH/vcFQ0KJlYIh3JLuPUmedVfxHfeCTHlaDy5UWfz0JnN4QqO80HGv0
	 uD34bQwlgGYwxyacoq+ytXDYSkCcNkhDHDvHtZHkYzovbN6NUvc0fL/U6FndaAz1Pw2hX
	 eiH8S9QKwtjtuBy9L+GkOwu3wsP3WmncrhHL4rvFyNArk0JT0HebgEE30m53SAG8GLi8j
	 jmdpi5tJdceIjfia3ZLeFJce4BXmxNFUD8BUIZDKOuFmJoJADx+sqfaJwMkoozTRNZqPR
	 ijvAN2ma10b8EoKd6a2A21jXmOfVkSEZHrVnscc4/e9Iq3dBAohUXeDxs42iP86r+IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321299;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CepZrkPALFnlxU/+TT1Chrq97rvGlc5mPklH9zNyl1k=;
	b=xg1cUEpEuOKqsUXUFSiQnph0sNkjnLO75hFHlX+Y0LW8ebGlK5d6DF1sJClj8tYDpNyN
	 GC/SmoZqiylcTcA3mRYlkz4Wl2DmCWwHqbzjL1eCt/N8VfSfJr3KDTS6eRI89JSgJeme3
	 vcXw2vjoZA4mWYBCjjwh9BBFIEwdKVeBlfs9vi6EeFbDdr21n5qTSuaItM/rRXU3gN+Li
	 326y+/SR1JrBpQ3q/kZqaGy1wQBixGy7MtnZO9BI6q97BpT7OMRGJt3fJZNc7BjUVQ+6f
	 bsqaA52pep7SPA0ezwTPdbGNO8TddOlH6X8fGOF+JWc+j4CCznMtcPh05PxTkjC5ryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTgUog2L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE8606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTgUog2L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FF71F0089F;
	Tue, 10 Nov 2026 14:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321298;
	bh=CepZrkPALFnlxU/+TT1Chrq97rvGlc5mPklH9zNyl1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gTgUog2LQeeoEPmoiEG0S/Nc35Yw5y0F7HRs5gfqhj3sado+oCHnmERA9Wseim4dR
	 IhhLrn3efd7ZT2vrlg0G3yhazdGliJ0ThiOq3DIb/8y/svYqwANsVJkzWxQlAF/mER
	 afFrhminu3SGC5Bj16U3gcX+HiHjKgTp1/CXVvJvSCr97bote3TSraX1+CPDE3UsEC
	 bSPLlKjdSyy0gJz+2ExtLDvTqHj/sDNFij4/KgVdzCdJ9RD2Idu5yRGBeNiTzvgReX
	 RmnPvog5ySq4V+I/MTXEV3PYm4NvibdnbwZSb09TPPUCd5ht5uD5E/ntxKHDuzUeIh
	 Pbkijhq15uMnA==
Subject: Re: [PATCH net] udp: check frag_list IP family before using
 skb_segment_list()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 kylebot@openai.com
Date: Tue, 10 Nov 2026 14:34:57 +0000
Message-ID: <179432129763.994134.12930210895338778196@kernel.org>
In-Reply-To: <20261106141727.2303218-1-edumazet@kernel.org>
References: <20261106141727.2303218-1-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix in net/ipv4/udp_offload.c:__udp_gso_segment() is
  incomplete.
- [Low] The comment added in net/ipv4/udp_offload.c:__udp_gso_segment()
  (lines 517-521) says the code makes sure "the frag_list skbs still…

--

udp: check frag_list IP family before using skb_segment_list()

This patch adds a check to __udp_gso_segment(). The fraglist fast path,
__udp_gso_segment_list(), is now taken only when the IP version of the
first frag_list skb matches the family being segmented. On a mismatch
the code falls back to __skb_linearize() and skb_segment(), so that
__udpv6_gso_segment_list_csum() does not treat an IPv4 header as a
struct ipv6hdr.

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a2..802365b4780fd 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -514,9 +514,14 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  	}
>  
>  	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> -		 /* Detect modified geometry and pass those to skb_segment. */
> +		/* Detect modified geometry and pass those to skb_segment.
> +		 * SKB_GSO_UDP_L4 is used by both IPv4 and IPv6: also make sure
> +		 * the frag_list skbs still have the IP family we segment for,
> +		 * as their network headers are not rebuilt.
> +		 */

[Severity: Low]
This isn't a bug, but the comment says the code makes sure "the frag_list
skbs still have the IP family we segment for". The condition below only
looks at skb_shinfo(gso_skb)->frag_list, which is the first member.

The idea that every member has the same family as the first one is only
stated in the changelog. Could the comment say that only the first
frag_list skb is checked, and why that is enough?

>  		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
> -		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
> +		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
> +		    ip_hdr(skb_shinfo(gso_skb)->frag_list)->version == (is_ipv6 ? 6 : 4))
>  			return __udp_gso_segment_list(gso_skb, features, is_ipv6);

[Severity: High]
Is it enough to check only the first frag_list skb here? The changelog
says "All skbs in the list belong to the same flow, so they share the
same IP family". On devices with hard_header_len == 0, though, GRO seems
able to append an IPv4 skb to an IPv6 head.

In gro_list_prepare(), maclen comes from skb->dev->hard_header_len. For
tun in IFF_TUN mode and for wireguard this is 0, so the memcmp() compares
nothing. skb->protocol is never compared:

net/core/gro.c:gro_list_prepare() {
    unsigned int maclen = skb->dev->hard_header_len;
    ...
		else if (!diffs)
			diffs = memcmp(skb_mac_header(p),
				       skb_mac_header(skb),
				       maclen);
    ...
}

inet_gro_receive() then checks only the version of the new skb. When p
is an IPv6 skb, it reads p at IPv4 offsets and never checks
iph2->version:

net/ipv4/af_inet.c:inet_gro_receive() {
    ...
		iph2 = (struct iphdr *)(p->data + off);
    ...
		if ((iph->protocol ^ iph2->protocol) |
		    ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
		    ((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {
    ...
}

On an IPv6 head these bytes are saddr[1] and saddr[4..11], and the
sender chooses them. The reverse direction is blocked, because
ipv6_gro_receive() masks first_word with 0xF00FFFFF, and that mask
covers the version nibble.

udp_gro_receive_segment() checks ports, is_flist, ip_summed/csum_level
and gro_receive_network_flush(). It then calls skb_gro_receive_list(p,
skb), which does not check the family.

So an IPv6 head A could end up with frag_list = [B (IPv6), C (IPv4)].
The new check passes because B is version 6. skb_segment_list() keeps
C's own 20 byte IPv4 header and only adjusts the transport header.

If the head's addresses or ports were changed, for example by NAT66, tc
pedit or BPF, the early return in __udpv6_gso_segment_list_csum() is not
taken. The loop then treats C as IPv6:

net/ipv4/udp_offload.c:__udpv6_gso_segment_list_csum() {
    ...
	while ((seg = seg->next)) {
		uh2 = udp_hdr(seg);
		iph2 = ipv6_hdr(seg);

		__udpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
					 &uh2->source, uh->source);
		__udpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
					 &uh2->dest, uh->dest);
	}
    ...
}

The *oldip = *newip stores in __udpv6_gso_segment_csum() write offsets
8-23 and 24-39 of C's network header. pskb_may_pull(skb,
skb_gro_offset(skb)) only guarantees 28 bytes are linear, up to the end
of the UDP header. That allows a write of up to 12 bytes past the linear
part, into tailroom or skb_shared_info.

With rx-gro-list enabled, a tun device in an unprivileged user namespace
appears to be enough to reach this path. Remote peers on wireguard or
point-to-point tunnels may also be able to send such packets.

Isn't this the same write past the linear part that the patch is meant
to fix? Would it be better to check every frag_list member here? Another
option is to block cross-family merges in GRO, for example by checking
p's IP version in inet_gro_receive().

>  
>  		ret = __skb_linearize(gso_skb);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106141727.2303218-1-edumazet%40kernel.org
