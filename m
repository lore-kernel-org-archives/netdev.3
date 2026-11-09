Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266108;
	b=yaBjxyIfyd/3HqIK+wE82DvuSyRHzYMn7V/G7X8Ye5ZyQ4sP276hL0HkM6rsP0WcRba0
	 tjF2g1IQDKyRDUntgFlAH8UctrsB7JZAhzZtuf2vj99jVa0dSSNMF4pkvrFZF5sndNkLX
	 XFmnGeIuZzsfmriM8m9/9a2Qk7yEHGKAO2aTqbR1g5Sz1QUNiGXqP8d4Buc20pqV28k69
	 19GsL9lVQdaYcBwDFCIpUgQ8gvM0XemHqnPD9Uwgqzwu6fjoJR2z+veNbJwDzDRLJlXt8
	 naY3VGqA8zv9f1mkRO8gpHCGH3zXII135Rt7epEOre17PDQHD3mB1E41s4UeE1n4/WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266108;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tB9lHN38Ty8bb2+I+Oll9dJDOQsV75GgqBhd+48vk+c=;
	b=suNAY9z3TpR7/Zcb8N5bCw/w1H12Mzk8L/gfm4MaH7pGiNQVwY/JTdj+bJzoMI99+5DJ
	 MSU9RfVQbizwl2BypQ7UzOVMPDC7bXBodNTlP2Sa9jhZdA+/0PGUDJIKEZT0c/GMBicP5
	 C5GqZH03WS3iuWrqYa84etTMyKXEHOogiBbLv/aShfzeyOO5e33CMRztdnZNjLjjqc7wZ
	 rv6bYnpe2fLEy+gDFHUq6jRDkG5Csi89rcHOMvw9Oy1tlrYSNtxrEsH6M43F+rzoNi+M+
	 ixKbKShWarzMhpUgoBcgXhgVOut67Ai3xyugGAp+y5s7cRgzDJksniX8YE5LHOmhbag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xga/dOEM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA235606A337
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xga/dOEM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7751F0089F;
	Mon,  9 Nov 2026 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794266107;
	bh=tB9lHN38Ty8bb2+I+Oll9dJDOQsV75GgqBhd+48vk+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xga/dOEMecrbJUaU3glOuTv9wwsPRLrTZYOAFpCBsfOIEF0AzvTbRGr07u3S0whm4
	 tp5/rJkNFMc8zCxvHgMATk3Ubnm5lGgQ5DuJr1dTIsqvtPv1unFe1mhQAoNeeOlZTn
	 t+XjCZdjnmchHyP6ZpUWuY99Qf6YO9FndJTFy/NK+OGpe7LkoG1iHfa7/3g5MWyLCs
	 3K9Tm7N+LXPRfBodxClB4aBRnHshVLgQJZyO8iYFt/15EFTX64b/PX0suhwPut73Ku
	 KQZhWV4lhJO0RgkHplSH8pKxZRrCu6grWs4p9kinAOw4nF7uAn4jbRH5H+gmeHGTUh
	 HRpdz54CsenEw==
Subject:
 Re: [PATCH net-next 3/4] ipv6: rpl: keep transport header after SRH insertion
From: netdev-bot+sashiko@kernel.org
To: tactii@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, andrea.mayer@uniroma2.it, justin.iurman@gmail.com,
 aahringo@redhat.com, willemb@google.com, alexander.duyck@gmail.com
Date: Mon, 09 Nov 2026 23:15:06 +0000
Message-ID: <179426610621.994134.4203400456891055869@kernel.org>
In-Reply-To: <20261105201309.3182307-4-tactii@gmail.com>
References: <20261105201309.3182307-4-tactii@gmail.com>
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

- [Low] The commit message has no Fixes: tag, although the patch fixes a
  user-visible regression.
- [Low] In rpl_output() (net/ipv6/rpl_iptunnel.c), the new restore keeps
  transport_header at the same distance from the end of the packet.

--

ipv6: rpl: keep transport header after SRH insertion

After rpl_do_srh() inserts the RPL SRH, rpl_output() now restores
skb->transport_header from its distance to the end of the packet.
Before this, transport_header was left at the SRH. Since commit
7fb4c1967011, that causes __dev_queue_xmit() to drop GSO packets of
the flow as SKB_BAD_GSO.

> rpl_do_srh_inline() leaves transport_header at the inserted RPL SRH,
> although the L4 header has not moved. GSO length checks then read the
> SRH as TCP, and since commit 7fb4c1967011 ("net: pull headers in
> qdisc_pkt_len_segs_init()"), a bogus doff below 5 there makes
> __dev_queue_xmit() drop each GSO packet of the flow as SKB_BAD_GSO.

[ ... ]

> Signed-off-by: Matt Vollrath <tactii@gmail.com>

[Severity: Low]
Should this patch have a Fixes: tag?

The note below the --- line says transport_header has pointed at the
inserted SRH since commit a7a29f9c361f ("net: ipv6: add rpl sr tunnel").
That note is dropped when the patch is applied, so git never records it.

Commit 7fb4c1967011 carries "Fixes: e876f208af18", so it is likely to be
backported to stable. Stable trees that take it would start dropping RPL
GSO flows in qdisc_pkt_len_segs_init(). Without a Fixes: tag, stable
tooling might not pick up this fix along with it.

Perhaps something like:

Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")

The sibling patch "ipv6: sr: keep transport header after inline SRH
insertion" seems to have the same omission.

> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index 4e10adcd70e89..0556bb9890410 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c

[ ... ]

> @@ -214,10 +215,16 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	dst = dst_cache_get(&rlwt->cache);
>  	local_bh_enable();
>  
> +	if (skb_transport_header_was_set(skb))
> +		tail_len = skb->len - skb_transport_offset(skb);
> +
>  	err = rpl_do_srh(skb, rlwt, dst);
>  	if (unlikely(err))
>  		goto drop;
>  
> +	if (tail_len >= 0)
> +		skb_set_transport_header(skb, skb->len - tail_len);
> +

[Severity: Low]
Does the distance to the end of the packet stay the same when the
original transport header was inside the 40-byte IPv6 header?

rpl_do_srh_inline() pulls the IPv6 header and pushes 40 + hdrlen bytes.
It then moves the old IPv6 header to the new front. Only bytes after the
original IPv6 header keep their distance to the end of the packet.

An IPV6_HDRINCL raw socket can get here with a transport offset of 0:

net/ipv6/raw.c:rawv6_send_hdrinc() {
    ...
	skb->transport_header = skb->network_header;
    ...
}

rawv6_send_hdrinc()
  NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, ..., dst_output)
    dst_output()
      lwtunnel_output()
        rpl_output()

In that case tail_len is skb->len. After the insertion skb->len has grown
by hdrlen, so skb_set_transport_header() sets the offset to hdrlen. If
the compressed SRH is shorter than 40 bytes, that points into the IPv6
address fields. If it is longer, it points into the SRH.

Before this patch the offset was sizeof(struct ipv6hdr), the start of
the SRH, which is at least a header boundary:

net/ipv6/rpl_iptunnel.c:rpl_do_srh_inline() {
    ...
	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
    ...
}

These raw packets are CHECKSUM_NONE and not GSO, so the SKB_BAD_GSO path
does not apply to them. Egress users of skb_transport_offset(), such as
act_pedit with TCP/UDP header types, would still see the new non-boundary
offset.

The SRH decap code in seg6_local handles a transport header that is
before, inside or after the removed header. Could the restore here be
limited to the case where the old skb_transport_offset(skb) is at least
sizeof(struct ipv6hdr)?

seg6_output_core() in "ipv6: sr: keep transport header after inline SRH
insertion" and ioam6_output() in "ipv6: ioam: keep transport header after
inline insertion" use the same unguarded tail_len pattern.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105201309.3182307-1-tactii%40gmail.com
