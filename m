Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519551624D5
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790923150; cv=none; b=uzXHNtfgyIRTRIXkMnN04hX6QVvW0N+v3q531j+ZyFkFFCMLtfgX86wI2F4mO1InINfGpDkyUAfczIbauDtMVvVW/DIags4N+H/jYXnumN3gO1wxMBT/OAFiWd7oP0xvaKGU1PQbMayvZltnxlZe2+tMlMLj+AN75WkidkIVLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790923150; c=relaxed/simple;
	bh=iLEqvKcSD3Svhe3b0q71tWXNB/+IDXKY0F0REHJuUEc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tMADv3mkovPexETUVOSDizxj+eYPJzBbSyP8GNEiGSBEcwl7SHH7eWDYKnkLj80JpNuWhKehoOFd2K8EkflVwQM/nHu70RPgALQErCSiyvzzRc+pmdM67KLayUweU/35i0DWZ30NhR03ImyPfohr5YO2RBvz1xgdFCxfxF9tbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou0WAZdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou0WAZdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF4F1F000FF;
	Fri,  2 Oct 2026 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790923149;
	bh=owjfKeoR7JTehK9a/Q/bK6ekQxZLR1ycFylzwJ1PvC4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ou0WAZdOU/sgFGOKt//Aj0QxRSyLC87BKZce/eT1ZGMt63pdAbmjchkdWV8y6FoR5
	 Qut6mZu2+Z6sXBe+vRU6Q5+CYb3SJ6B0hlgIssH5KkY/kJ90YUbw21oZf3zzrQq5yM
	 /DCQVD6Vqrq5hQO3BN9qcDgDgjlcJFs/0PC8i6+C5uzhHmK/MAZnA9wP6G+mE8Ufjh
	 wDIEPpXHfqp0Vp9pnMBJqfxcCI/VE6lPrSIBpfG/OCvk9SKPNT29ZJhjTYArpoOHp1
	 0T1vv6sUtmPaRklNZN7MbNTdKd+1wKII2ZweeLO6Wfy8hqjt5W96E36ApSaMJO3uVF
	 QMds2CjbS7eVQ==
Subject: Re: [PATCH net 1/2] ieee802154: 6lowpan: look up the neighbour short
 address in lowpan_xmit()
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alex.aring@gmail.com, falemi@asu.edu, netdev@vger.kernel.org
Date: Fri, 02 Oct 2026 06:39:08 +0000
Message-ID: <179092314828.434549.12977909355456421653@kernel.org>
In-Reply-To: <20260928183753.3550210-2-edumazet@kernel.org>
References: <20260928183753.3550210-2-edumazet@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, lowpan_xmit() (net/ieee802154/6lowpan/tx.c:272)
  resets skb->network_header to skb->data but leaves…

Pre-existing issues:
- [Medium] At this commit, AF_PACKET SOCK_RAW senders reach lowpan_xmit()
  without dev_hard_header() ever being called.

--

ieee802154: 6lowpan: look up the neighbour short address in lowpan_xmit()

This commit moves the neighbour short address lookup from
lowpan_header_create() to lowpan_header(). The lookup then runs after the
IPv6 header has been copied into the skb. lowpan_xmit() now pulls the IPv6
header into the linear area and resets the network header to skb->data.

> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> index 4df76ff50699..2d83a810e610 100644
> --- a/net/ieee802154/6lowpan/tx.c
> +++ b/net/ieee802154/6lowpan/tx.c

[ ... ]

> @@ -230,6 +236,9 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
>  
>  	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
>  
> +	if (info.daddr.mode == IEEE802154_ADDR_LONG)
> +		lowpan_neigh_short_addr(skb, ldev, &info.daddr);

[Severity: Medium]
This issue was not introduced by this patch, but is info.daddr.mode ever
initialized here for AF_PACKET SOCK_RAW senders?

packet_snd() and tpacket_fill_skb() only call dev_hard_header() for
SOCK_DGRAM:

net/packet/af_packet.c:packet_snd() {
    ...
	if (sock->type == SOCK_DGRAM) {
		offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
    ...
}

So for SOCK_RAW, lowpan_header_create() never writes the struct
lowpan_addr_info at lowpan_skb_priv(skb). That headroom is memory from
sock_alloc_send_pskb() that has not been zeroed.

The memcpy() above copies it into info, and the new check branches on the
uninitialized daddr.mode. As before this patch, the rest of the
uninitialized daddr/saddr still reaches lowpan_header_compress(), the
ackreq decision and wpan_dev_hard_header().

The next patch in the series, "6lowpan: fix warning in
lowpan_compress_addr_64()", appears to fix this. It removes
lowpan_skb_priv() and builds daddr/saddr from the pushed pseudo header and
wpan_dev.

[ ... ]

> @@ -255,10 +264,12 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
>  
>  	pr_debug("package xmit\n");
>  
> -	if (skb->protocol != htons(ETH_P_IPV6)) {
> +	if (skb->protocol != htons(ETH_P_IPV6) ||
> +	    !pskb_may_pull(skb, sizeof(struct ipv6hdr))) {
>  		kfree_skb(skb);
>  		return NET_XMIT_DROP;
>  	}
> +	skb_reset_network_header(skb);

[Severity: High]
This resets only the network header. Can skb->transport_header go stale
for AF_PACKET SOCK_RAW senders as a result?

At this commit ldev->hard_header_len is sizeof(struct ipv6hdr). For
SOCK_RAW with len >= 80, packet_snd() therefore leaves the network header
at data + 40:

	} else if (reserve) {
		skb_reserve(skb, -reserve);
		if (len < reserve + sizeof(struct ipv6hdr) &&
		    dev->min_header_len != hard_header_len)
			skb_reset_network_header(skb);
	}

packet_parse_headers()->skb_probe_transport_header() then parses bytes
40..79 as the IPv6 header. transport_header ends up around data + 80, or
stays unset (0xffff) if parsing fails. tpacket_fill_skb() on the TX ring
path also places the network header hard_header_len bytes after skb->data.

After this reset the network header is at data + 0. If byte 6 (nexthdr) is
IPPROTO_UDP, lowpan_header_compress()->lowpan_nhc_do_compression() only
fixes the transport header when the two offsets are equal:

net/6lowpan/nhc.c:lowpan_nhc_do_compression() {
    ...
	if (skb->transport_header == skb->network_header)
		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
    ...
}

That check no longer holds, so udp_compress() does:

	const struct udphdr *uh = udp_hdr(skb);

at the stale offset. That is bytes 80..87, or skb->head + 0xffff if the
transport header was never set.

Can this read out of bounds, and can the bytes it reads go into the
transmitted 802.15.4 frame as the UDP ports and checksum?

Only this intermediate commit seems to be affected. The next patch in the
series, "6lowpan: fix warning in lowpan_compress_addr_64()", sets
hard_header_len to LOWPAN_PSEUDO_HDR_LEN. It also calls __skb_pull() on the
pseudo header before skb_reset_network_header(). The reset network header
then matches where AF_PACKET put it.

Could the two changes be reordered or combined so that this commit is safe
to bisect?

A separate part of this was not introduced by this patch and is still
present at the end of the series. pskb_may_pull() only guarantees the IPv6
header in the linear area (8 + 40 bytes after the next patch). If nexthdr
is UDP and the payload is shorter than 8 bytes, can udp_compress() read up
to 8 bytes past skb->tail?

>  
>  	WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928183753.3550210-1-edumazet%40kernel.org
