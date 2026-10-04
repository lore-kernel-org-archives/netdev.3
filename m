Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD940861C;
	Sun,  4 Oct 2026 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093956; cv=none; b=VYPQPjr+OumV2jbV05Hsp5MAorn07BMPvVXN4XdWtQwpCpL8ZWUR06L3iO7zpN0uTnu3nnGCzVh9j1nEhdJ2ft6LtSqrK/JtbEhWjYRVHmIs1GsirLUZpqhauqwG7gKkUpwZwchi7uiy+bInaQ56GZq1vjEuWRqgf1roBesI12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093956; c=relaxed/simple;
	bh=elNEEAE0XejRgQ5Eia1tmm8XOp4uWwm6dbKuhXUfVhg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXJqrcpPa1vobfVjiE0eq79s+nDed4h8sgMpJ3O4MLWeApB62p46rVJ02ehq5nc8xARLrvhX0k/ccmwFxizXk7WUUddAhl4lbzuW7PV+vKdJTONrDb4CdBtLOuxx36WDkChDXStnyZFr6ta3UIFKxCjKGt167osQr4RgQyZX6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNi7H38E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNi7H38E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795EF1F00899;
	Sun,  4 Oct 2026 06:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093952;
	bh=eLz2l0AJudarlE2qk+JuyTPWcZBNmTUrv2nUZqCTBgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aNi7H38E6fhnffyBshYri3Wns3VSzB/7nZX95eOSdulzDAjAT4tF24G8+HBixMzA8
	 cOw4zt423euUHMUSkfLgxnaLlKsHHGEEKHFgwGVuEEyjRytuCbtD6h8fheNUzGcPJH
	 RIM13fGvSwwxJ9sahNJj0AbGbckgkNjOcjVfKb1PbOTGVqSaVkSvvI1vY6IH+Wmpf3
	 wouoa7pNeAPxT+7x6MX9sGcHzqoZLmyVEcjNECYOadFKT+sYWyMtsIt3nX1JU8iGqq
	 38NHEMn56CBx99v21vSdMvYzesGbzHVSHFfDdpaeqP80VaS4rwQHeZGxEF5p7Juhia
	 GhvM7GGIytvqw==
Subject: Re: [PATCH net-next 4/7] net: qualcomm: rmnet: Add DL packet
 coalescing support
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com
Date: Sun, 04 Oct 2026 06:05:51 +0000
Message-ID: <179109395104.434549.10935975899617146381@kernel.org>
In-Reply-To:
 <20260930051345.857443-5-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20260930051345.857443-5-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 5 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In the IPv6 branch of rmnet_map_coal_parse_ip_hdr(),
  meta->ip_len is taken directly from the return value of…
- [Medium] rmnet_map_data_check_coal_header() adds up
  nl_pairs[i].num_packets in a `u8 pkts`.
- [Medium] When NETIF_F_GRO_HW is enabled, rmnet_map_coal_segment_loop()
  flushes a run of good packets by calling…
- [Medium] The GRO fast path modifies the original coalesced skb in place
  without first checking skb_cloned() or calling skb_unclone().
- [Medium] The COALESCING case of rmnet_map_process_next_hdr_packet()
  never checks NETIF_F_RXCSUM.
- [Medium] rmnet_map_gso_stamp() copies device-supplied NLO geometry
  straight into gso_size/gso_segs.
- [Low] rmnet_map_coal_validate_bounds() rejects only `plen < hlen`, so
  an NLO with plen == hlen (zero payload per packet) is accepted for any…
- [Low] In rmnet_map_process_next_hdr_packet(), the coalesced skb is
  freed with consume_skb() whenever it is not the head of the output…
- [Low] Drops in the coalescing path are not fully counted.
- [Low] The commit message says every packet queued to the stack gets GSO
  information and a partial checksum set.
- [Low] Documentation and implementation still disagree on the coalescing
  wire format.

--

net: qualcomm: rmnet: Add DL packet coalescing support

This adds support for MAPv5 coalescing frames, where hardware merges
multiple TCP or UDP packets of one flow into a single MAP frame. The frame
is described by up to 6 NLOs and a checksum error bitmap. The driver either
reuses the frame directly with GSO metadata (GRO_HW fast path) or rebuilds
the individual segments, dropping those with checksum errors. The patch
also adds NETIF_F_GRO_HW to hw_features and requires MAPv5 ingress checksum
offload whenever coalescing is enabled.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 577f2758e3855..bb88e19e28d82 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c

[ ... ]

> @@ -518,13 +539,482 @@ static bool rmnet_map_get_csum_valid(struct sk_buff *skb)
>  	return !!(hdr->csum_info & MAPV5_CSUMINFO_VALID_FLAG);
>  }
>  
> -int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
> +/* Stamp GSO metadata so the network stack can segment a coalesced SKB. */
> +static void rmnet_map_gso_stamp(struct sk_buff *skb,
> +				struct rmnet_map_coal_metadata *coal_meta)
> +{
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);
> +
> +	if (coal_meta->trans_proto == IPPROTO_TCP)
> +		shinfo->gso_type = (coal_meta->ip_proto == 4) ?
> +				   SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> +	else
> +		shinfo->gso_type = SKB_GSO_UDP_L4;
> +
> +	shinfo->gso_size = coal_meta->data_len;
> +	shinfo->gso_segs = coal_meta->pkt_count;

[Severity: Medium]

Can gso_size and gso_segs end up inconsistent with skb->len here? In
rmnet_map_coal_gro_fast_path() both values come straight from the NLO:

    coal_meta->data_len = ntohs(coal_hdr->nl_pairs[0].pkt_len) - hlen;
    coal_meta->pkt_count = coal_hdr->nl_pairs[0].num_packets;

rmnet_map_coal_validate_bounds() only checks that the claimed data fits in
the skb (<=). The fast path then reuses the original skb without trimming
it or checking that skb->len == hlen + data_len * pkt_count.

For example, data_len 1 and pkt_count 2 on a 64KB skb gives gso_size 1 and
gso_segs 2. Software GSO or TSO on the forwarding path would then produce
tens of thousands of segments.

SKB_GSO_DODGY is not set, so the dev->gso_max_segs check and qdisc
accounting trust gso_segs. Should the length consistency be checked, or
should SKB_GSO_DODGY be set, since this geometry is supplied by the device?

> +}

[ ... ]

> +static void
> +__rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
> +			     struct rmnet_map_coal_metadata *coal_meta,
> +			     struct sk_buff_head *list, u8 pkt_id,
> +			     bool csum_valid)
> +{

[ ... ]

> +	skbn = alloc_skb(hlen + dlen + RMNET_MAP_DEAGGR_HEADROOM, GFP_ATOMIC);
> +	if (!skbn)
> +		goto next_pkt;

[Severity: Low]

Should the drops in the coalescing path be counted? In this patch none of
these update a counter:

- checksum-error segments
- alloc_skb() failures here
- whole frames rejected by rmnet_map_data_check_coal_header(),
  rmnet_map_coal_parse_ip_hdr(), rmnet_map_coal_parse_trans_hdr() or
  rmnet_map_coal_validate_bounds()

The existing MAPv4/MAPv5 checksum code in this file counts each outcome.

The later commit "Add ethtool stats for DL coalescing" adds coal_csum_drop
and counters for header errors and invalid IP/transport headers. At the
end of the series, two cases are still uncounted: segments lost to
alloc_skb() failure, and frames rejected by
rmnet_map_coal_validate_bounds().

[ ... ]

> +	if (iph->version == 4) {
> +		meta->ip_proto = 4;
> +		meta->ip_len = iph->ihl * 4;
> +		meta->trans_proto = iph->protocol;
> +		meta->ip_header = iph;
> +		if (meta->ip_len < sizeof(*iph) || coal_skb->len < meta->ip_len)
> +			return false;

[ ... ]

> +	} else if (iph->version == 6) {
> +		if (coal_skb->len < sizeof(*ip6h))
> +			return false;
> +
> +		ip6h = (struct ipv6hdr *)iph;
> +		protocol = ip6h->nexthdr;
> +		meta->ip_proto = 6;
> +		ret = ipv6_skip_exthdr(coal_skb, sizeof(*ip6h), &protocol,
> +				       &frag_off);
> +		if (ret < 0 || frag_off)
> +			return false;
> +
> +		meta->ip_len = (u16)ret;

[Severity: Critical]

Is meta->ip_len checked against coal_skb->len anywhere in the IPv6 branch?
The IPv4 branch above checks coal_skb->len < meta->ip_len, but here the
return value of ipv6_skip_exthdr() is used as is.

ipv6_skip_exthdr() only reads the 2-byte generic header of each extension
header. It then does start += hdrlen and returns start without comparing
it with skb->len.

Suppose the last extension header is a Hop-by-Hop header with hdrlen 255
and nexthdr TCP or UDP. ip_len then ends up about 2KB past the end of the
packet.

After that, both of these underflow as u32 and the checks pass.

rmnet_map_coal_parse_trans_hdr():

    avail = coal_skb->len - meta->ip_len;

rmnet_map_coal_validate_bounds():

    if (total_data + nlo_len > coal_skb->len - hlen)

As a result, th->doff and uh->check are read out of bounds.

Because ip_len > sizeof(struct ipv6hdr) forces gro = false, the frame goes
through rmnet_map_coal_segment_loop()->__rmnet_map_segment_coal_skb(),
which does:

	skb_put_data(skbn,
		     coal_skb->data + coal_meta->ip_len + coal_meta->trans_len +
		     coal_meta->data_offset,
		     dlen);
	...
	memcpy(skbn->data, coal_meta->ip_header, coal_meta->ip_len);

Could this copy adjacent kernel heap memory into new skbs that
rmnet_deliver_skb_list() then hands to the stack, where a packet socket on
the rmnet device can read it?

The input comes from modem firmware, or from any lower device rmnet is
stacked on, including the ARPHRD_ETHER path. rmnet links can be created
over rtnetlink with CAP_NET_ADMIN, which is available inside a user
namespace.

This code is unchanged at the end of the series. The later patches only
add stat counters to this function.

[ ... ]

> +static bool rmnet_map_coal_validate_bounds(struct sk_buff *coal_skb,
> +					   struct rmnet_map_v5_coal_header *coal_hdr,
> +					   u8 num_nlos, u32 hlen)
> +{
> +	u32 total_data = 0;
> +	u32 nlo_len;
> +	u16 plen;
> +	u8 i;
> +
> +	for (i = 0; i < num_nlos; i++) {
> +		plen = ntohs(coal_hdr->nl_pairs[i].pkt_len);
> +
> +		if (plen < hlen)
> +			return false;

[Severity: Low]

Should plen == hlen be rejected as well? That NLO has zero bytes of
payload per packet, and it passes for any num_packets.

data_len then becomes 0. In the fast path with pkt_count > 1,
rmnet_map_gso_stamp() sets gso_size 0 and gso_segs N, plus a TCP/UDP
gso_type, on a CHECKSUM_PARTIAL skb. The GRO segmentation path likewise
merges consecutive zero-payload packets into one header-only skb with
gso_size 0.

skb_is_gso() only looks at gso_size, so the stack treats these as single
packets. N empty UDP datagrams become one, the rest are lost, and the skb
is left with gso_type and gso_segs set while gso_size is 0.

> +
> +		nlo_len = (u32)(plen - hlen) * coal_hdr->nl_pairs[i].num_packets;
> +		if (total_data + nlo_len > coal_skb->len - hlen)
> +			return false;

[ ... ]

> +static bool rmnet_map_coal_gro_fast_path(struct sk_buff *coal_skb,
> +					 struct rmnet_map_v5_coal_header *coal_hdr,
> +					 struct rmnet_map_coal_metadata *coal_meta,
> +					 struct sk_buff_head *list,
> +					 u8 num_nlos, bool gro)
> +{

[ ... ]

> +	coal_skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	if (coal_meta->pkt_count > 1) {
> +		rmnet_map_partial_csum(coal_skb, coal_meta);
> +		rmnet_map_gso_stamp(coal_skb, coal_meta);
> +	}

[Severity: Medium]

Is it safe to modify coal_skb in place here without checking skb_cloned()
or calling skb_unclone()?

rmnet_map_partial_csum() writes tp->check or up->check into the packet
data. rmnet_map_gso_stamp() writes gso_type, gso_size and gso_segs into
skb_shinfo().

rmnet_config_data_format_valid() allows RMNET_FLAGS_INGRESS_COALESCE
without RMNET_FLAGS_INGRESS_DEAGGREGATION. In that case this is the skb
received from the real device:

rmnet_map_ingress_handler() {
    ...
    } else {
        if (rmnet_map_validate_packet_len(skb, data_format))
            __rmnet_map_ingress_handler(skb, port, data_format);
    ...
}

rmnet_rx_handler() only calls skb_linearize(), which does nothing for a
linear skb. There is no skb_share_check() on this path either.

With a ptype_all tap such as af_packet active on the real device,
packet_rcv() holds a clone that shares the same data and shinfo. Would
that clone then see the rewritten L4 checksum and GSO fields?

[ ... ]

> +			if (csum_err) {
> +				if (coal_meta->pkt_count)
> +					__rmnet_map_segment_coal_skb(coal_skb,
> +								     coal_meta,
> +								     list,
> +								     total_pkt,
> +								     true);
> +				coal_meta->pkt_count = 1;
> +				__rmnet_map_segment_coal_skb(coal_skb, coal_meta,
> +							     list, total_pkt,
> +							     false);
> +			} else {
> +				coal_meta->pkt_count++;
> +			}
> +		}
> +
> +		/* Flush remaining packets from this NLO */
> +		if (coal_meta->pkt_count)
> +			__rmnet_map_segment_coal_skb(coal_skb, coal_meta, list,
> +						     total_pkt, true);

[Severity: Medium]

Is total_pkt the right pkt_id for these two flushes of a good run? At both
points total_pkt is the index of the packet after the run, either the
checksum-error packet or one past the end of the NLO. It is not the index
of the first packet in the run.

__rmnet_map_segment_coal_skb() uses it directly:

    iph->id = htons(ntohs(iph->id) + pkt_id);

So an NLO0 with 5 packets gets base+5 instead of base+0, and an NLO1 with
3 packets gets base+8 instead of base+5.

The !gro path passes each packet's own index with pkt_count 1, which
suggests base+k is the intended mapping.

These skbs are stamped SKB_GSO_TCPV4 or SKB_GSO_UDP_L4 without
SKB_GSO_TCP_FIXEDID. Any later resegmentation, for example when
forwarding, would produce overlapping IP IDs.

Should this be total_pkt - coal_meta->pkt_count?

[ ... ]

> +static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
> +					    u64 *nlo_err_mask)
> +{
> +	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
> +	struct rmnet_map_v5_coal_header *coal_hdr;
> +	u8 num_nlos, pkts = 0;

[ ... ]

> +	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
> +		u8 err = coal_hdr->nl_pairs[i].csum_error_bitmap;
> +		u8 pkt = coal_hdr->nl_pairs[i].num_packets;
> +
> +		mask |= ((u64)err) << (8 * i);
> +		pkts += pkt;
> +		if (pkts > RMNET_MAP_V5_MAX_PACKETS)
> +			return -EINVAL;

[Severity: Medium]

Can pkts wrap before this comparison? It is a u8, so num_packets of
[48, 208] sums to 0. [48, 255, 255, 255, 255, 255] never exceeds 48 after
truncation, even though it describes 1323 packets.

rmnet_map_coal_validate_bounds() only limits payload bytes. With pkt_len
equal to hlen, or a small data_len, any count gets through.

rmnet_map_coal_segment_loop() then walks every claimed packet:

- after 48 shifts nlo_err_mask is zero, so every later packet is treated
  as checksum-valid
- the u8 total_pkt wraps, which corrupts the IPv4 ID offsets
- with GRO_HW off, or when error bits are set, it does one
  alloc_skb(GFP_ATOMIC) per packet in softirq context

This loop also sums all RMNET_MAP_V5_MAX_NLOS slots instead of only the
first num_nlos. At the end of the series, priv->stats.coal_pkts += pkts
records the wrapped value.

Could pkts use a wider type, and could the loop stop at num_nlos?

> +	}
> +
> +	*nlo_err_mask = mask;
> +	return 0;
> +}
> +
> +int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
> +				      struct sk_buff_head *list,
> +				      u16 len, u32 data_format)
>  {
>  	struct rmnet_priv *priv = netdev_priv(skb->dev);
> +	u64 nlo_err_mask;
> +	int rc;
>  
>  	switch (rmnet_map_get_next_hdr_type(skb)) {
> +	case RMNET_MAP_HEADER_TYPE_COALESCING:
> +		if (!(data_format & RMNET_FLAGS_INGRESS_COALESCE))
> +			return -EINVAL;
> +

[Severity: Medium]

Should this case check NETIF_F_RXCSUM, as the
RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD case below does?

rmnet never sets dev->features, so RXCSUM is off by default.
netdev_fix_features() also clears GRO_HW when RXCSUM is off. Every
coalesced frame then goes through
rmnet_map_coal_segment_loop()->__rmnet_map_segment_coal_skb()->
rmnet_map_partial_csum(). That path sets CHECKSUM_PARTIAL and keeps or
drops packets based only on the hardware error bitmap.

The segmentation path also ignores MAPV5_COALINFO_CSUM_VALID_FLAG, which
the fast path requires.

As a result, turning rx-checksum off has no effect on coalesced traffic.
The later commit "Work around coalescing hardware quirks" shows that the
hardware verdict can be wrong, and the RXCSUM check is still missing at
the end of the series.

> +		rc = rmnet_map_data_check_coal_header(skb, &nlo_err_mask);
> +		if (rc)
> +			return rc;
> +
> +		rc = rmnet_map_segment_coal_skb(skb, nlo_err_mask, list, len);
> +		if (rc)
> +			return rc;
> +
> +		if (skb_peek(list) != skb)
> +			consume_skb(skb);

[Severity: Low]

What happens when segmentation queues nothing? If every segment had a
checksum error, or every alloc_skb() in __rmnet_map_segment_coal_skb()
failed, the list is empty and skb_peek() returns NULL. The frame was
dropped, but consume_skb() reports it as normally consumed, so drop
monitor and the kfree_skb tracepoints never see it.

Should this use kfree_skb(), or kfree_skb_reason(), when the list is
empty?

Segments lost to alloc_skb() failure are also not counted, even after
"Add ethtool stats for DL coalescing", which only adds coal_csum_drop.

> +		break;
> +

[ ... ]

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> index 5f921cddf82b4..e1e319683a558 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
> @@ -323,6 +323,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
>  	rmnet_dev->hw_features = NETIF_F_RXCSUM;
>  	rmnet_dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
>  	rmnet_dev->hw_features |= NETIF_F_SG;
> +	rmnet_dev->hw_features |= NETIF_F_GRO_HW;

[Severity: Low]

The commit message says:

  Any packet queued to the network stack would have the gso information
  populated in the skb and partial checksum set.

Does that match the code? The commit message does not mention this new
GRO_HW toggle. It is only added to hw_features, nothing in rmnet sets
dev->features, and GRO_HW also depends on RXCSUM, so it starts off.

With GRO_HW off, rmnet_map_coal_segment_loop() sets pkt_count to 1 for
every packet, so this never runs:

    if (coal_meta->pkt_count > 1)
        rmnet_map_gso_stamp(skbn, coal_meta);

With GRO_HW on, single-packet fast-path frames get CHECKSUM_UNNECESSARY,
not CHECKSUM_PARTIAL.

Could the commit message describe the GRO_HW feature and how each mode
behaves?

>  
>  	priv->real_dev = real_dev;
>  
> diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
> index c44bf6e80ecb4..5df4d417f3d2c 100644
> --- a/include/linux/if_rmnet.h
> +++ b/include/linux/if_rmnet.h
> @@ -70,5 +70,36 @@ struct rmnet_map_v5_csum_header {
>  #define MAPV5_HDRINFO_HDR_TYPE_FMASK	GENMASK(7, 1)
>  #define MAPV5_CSUMINFO_VALID_FLAG	BIT(7)
>  
> +#define RMNET_MAP_HEADER_TYPE_COALESCING   1
>  #define RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD 2

[Severity: Low]

At this commit,
Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst still
lists next header type 1 as Reserved and says the next header can only be
the checksum header.

The later commit "docs: networking: Add documentation for the coalescing
support in rmnet" fixes the type table. However, it describes the checksum
error bitmap as per-NLO:

  CSUM error bitmap is a per-packet bitmask. Bit N is set when packet N
  in this NLO has a bad checksum.

The comment on rmnet_map_data_check_coal_header() says the opposite: one
flat stream across the NLO slots, indexed by the packet's absolute
position in the frame. rmnet_map_coal_segment_loop() walks it that way.

The docs also don't mention that the coalescing header is counted in
pkt_len. Which interpretation of the bitmap is correct?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930051345.857443-1-subash.a.kasiviswanathan%40oss.qualcomm.com
