Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F84446E1;
	Sat, 10 Oct 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624550; cv=none; b=fhcMUihNvvR+SCXsbFDdfuX4qJu6G4YBl8FU5Wu+i5c0AcPjjHQ2nLURIqd3fYez992YmsCV76qbinbQmNqPsIBehZHa6SbRyByAYFGihtBfD9aaEb+kXfAZ8bKMjRtqNg0BySfHzuZSDTS+wwzp5lDEYiGBHvnaJ+u42+Lx6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624550; c=relaxed/simple;
	bh=8t6CtCTIduJHHbFZntbUJvT33peBVR8S+ilvUFz7O8o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7jWkb8JPBXicXHQBzIKlCNPBz023oihGvwz3dLG+UqNgrOhbs6EGj+S9AJlRLLBjJ2rB4DQpJwdnR3sd0VfIIeh0AOLTZCYDHAINlgbQNnSrYpBmiE0Er/NMGakZGu7Rz3sPa/aElcglZ4h0g4v4okAEDfY0DGJ/KCr3PQXbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahf66T5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahf66T5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2851F00893;
	Sat, 10 Oct 2026 09:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624548;
	bh=Ogg2S4tmyUYtQ2uqOpUlRS0fOnCkd96VbCTZqf5kf+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ahf66T5dF70Ph3PizgGvOLPWQCxpRIwBK0XUterSHPHwO2crFULnwiGw2hMCfXNC4
	 BP9VL0qnKReeeKXvEVR88isa6LCVaZ8A/LXAaeIXoya87vE94Z4aVEFGk1hTU09eYc
	 fjNKleTf5YiWn2/T9hYxj+GJKKQT9+moa6y0PVXgB7Z1D3VwQBXptR6x0M31ua8HrX
	 MC+3xLlufeaekR+hL7FiimmClsBE5vvH9qnfvIi2hBMG3O1xJjzffKWU430LdItkf6
	 v712h2H7Z7Ag2O6drNexuZXSvoE3FeAg5Kb9FeCOVuq+EDHE5Hi17WTz2qvWOOxb1c
	 vygGTAzv02eXw==
Subject: Re: [PATCH net-next v3 5/8] net: qualcomm: rmnet: Add DL packet
 coalescing support
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:07 +0000
Message-ID: <179162454724.434549.1110899091990382859@kernel.org>
In-Reply-To:
 <20261009084351.317632-6-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-6-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Clearing NETIF_F_GRO_HW (or NETIF_F_RXCSUM) on an rmnet device
  does not stop the modem from coalescing.
- [Medium] rmnet_map_coal_gro_fast_path() hands the original coalesced
  skb to the stack with gso_size/gso_segs stamped from the NLOs and the…
- [Medium] rmnet_vnd_rx_fixup() adds 1 to rx_pkts per delivered skb.
- [Medium] rmnet_map_gso_stamp() sets gso_type to only SKB_GSO_TCPV4 or
  SKB_GSO_TCPV6 and never adds SKB_GSO_TCP_ACCECN when the retained TCP…
- [Low] The commit message says 'A single-packet frame is passed with
  CHECKSUM_UNNECESSARY when both features are enabled'.
- [Low] Several pieces of text no longer match the code after this patch.
- [Low] __rmnet_map_segment_coal_skb() decides whether a segment is the
  last one (and so keeps FIN/PSH) by comparing byte offsets: `hlen +…
- [Low] rmnet_map_coal_parse_ip_hdr() validates the IPv4 version, ihl and
  fragment bits, but never verifies the original IPv4 header checksum.

--

net: qualcomm: rmnet: Add DL packet coalescing support

This commit adds support for MAPv5 downlink coalescing frames. In these
frames, hardware merges up to 48 packets of a flow into one MAP frame
described by up to 6 NLOs. Coalesced frames are delivered as GSO skbs
through a fast path, or segmented in the driver using a per-packet
checksum error bitmap. The commit also advertises NETIF_F_GRO_HW and
requires MAPv5 ingress checksum offload when coalescing is requested.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 577f2758e3855..5ffb811d7ef1a 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c

[ ... ]

> @@ -518,13 +539,530 @@ static bool rmnet_map_get_csum_valid(struct sk_buff *skb)
>  	return !!(hdr->csum_info & MAPV5_CSUMINFO_VALID_FLAG);
>  }
>  
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

[Severity: Medium]
Should SKB_GSO_TCP_ACCECN be set here when the retained TCP header has CWR
set? tcp_gro_complete() sets it for software aggregates:

net/ipv4/tcp_offload.c:tcp_gro_complete() {
    ...
	if (th->cwr)
		shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
}

When the flag is absent, tcp_gso_segment() clears CWR on every segment
after the first:

	ecn_cwr_mask = !!(skb_shinfo(gso_skb)->gso_type & SKB_GSO_TCP_ACCECN);
	...
		th->cwr &= ecn_cwr_mask;

Suppose the hardware coalesces CWR-bearing AccECN packets and the
aggregate is then forwarded (for example, tethering) and segmented in
software. Segments 2..N would lose CWR, which changes the ACE feedback
they carry.

Frames with PSH or FIN are flushed through GRO_NORMAL without
tcp_gro_complete(), so software GRO wouldn't restore the flag either.

[ ... ]

> +static void
> +__rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
> +			     struct rmnet_map_coal_metadata *coal_meta,
> +			     struct sk_buff_head *list, u8 pkt_id,
> +			     bool csum_valid)
> +{

[ ... ]

> +	if (!csum_valid)
> +		goto next_pkt;
> +
> +	skbn = alloc_skb(hlen + dlen + RMNET_MAP_DEAGGR_HEADROOM, GFP_ATOMIC);
> +	if (!skbn)
> +		goto next_pkt;

[Severity: Medium]
Should these drops be counted? Packets dropped for a set bitmap bit, or
because alloc_skb() failed, are freed here without updating any counter.

The uAPI description of rx_packets in struct rtnl_link_stats64 includes
packets the host had to drop in the driver.

rmnet_vnd_rx_fixup() also still adds one per delivered skb:

	pcpu_ptr->stats.rx_pkts++;
	pcpu_ptr->stats.rx_bytes += skb->len;

With rmnet_map_gso_stamp(), one skb can now stand for up to 48 wire
packets (gso_segs). Won't rx_packets undercount on the coalesced path?

The later patch "net: qualcomm: rmnet: Add DL coalescing statistics" adds
rx_dropped and rx_alloc_fail accounting for the checksum drop and the
allocation failure. It counts those in packets, while rx_packets counts
skbs.

Even at the end of the series, a GSO skb still counts as one in
rx_packets. The rejection in rmnet_map_segment_coal_skb() when features
are off still has no counter.

> +
> +	skb_reserve(skbn, hlen + RMNET_MAP_DEAGGR_HEADROOM);
> +	skb_put_data(skbn,
> +		     coal_skb->data + coal_meta->ip_len + coal_meta->trans_len +
> +		     coal_meta->data_offset,
> +		     dlen);
> +
> +	/* Restore transport header */
> +	skb_push(skbn, coal_meta->trans_len);
> +	memcpy(skbn->data, coal_meta->trans_header, coal_meta->trans_len);
> +	skb_reset_transport_header(skbn);
> +
> +	if (coal_meta->trans_proto == IPPROTO_TCP) {
> +		struct tcphdr *th = tcp_hdr(skbn);
> +
> +		th->seq = htonl(ntohl(th->seq) + coal_meta->data_offset);
> +		/* Strip dangerous flags from non-final segments */
> +		if ((th->fin || th->psh) &&
> +		    hlen + coal_meta->data_offset + dlen < coal_skb->len) {
> +			th->fin = 0;
> +			th->psh = 0;
> +		}

[Severity: Low]
This test finds the final segment by comparing byte offsets. Can it pick
the wrong segment when the frame ends with zero-payload packets?

rmnet_map_coal_validate_bounds() accepts zero-payload NLOs. When
plen == hlen, it only clears gro. In that case the last packet that
carries data already reaches data_offset + dlen == total payload. It is
treated as final and keeps FIN/PSH, even though more packets follow.

For example, take NLO0 with 2 x 100 bytes, NLO1 with 1 x 0 bytes, and
FIN set in the shared header. Packet 2 of NLO0 keeps FIN, and the
trailing zero-length packet carries FIN again at the same sequence
number.

Would comparing the packet index against the total packet count find the
last packet more reliably?

> +	} else if (coal_meta->trans_proto == IPPROTO_UDP) {
> +		struct udphdr *uh = udp_hdr(skbn);
> +
> +		uh->len = htons(skbn->len);
> +	}
> +
> +	/* Restore IP header */
> +	skb_push(skbn, coal_meta->ip_len);
> +	memcpy(skbn->data, coal_meta->ip_header, coal_meta->ip_len);
> +	skb_reset_network_header(skbn);
> +
> +	if (coal_meta->ip_proto == 4) {
> +		struct iphdr *iph = ip_hdr(skbn);
> +
> +		iph->id = htons(ntohs(iph->id) + pkt_id);
> +		iph->tot_len = htons(skbn->len);
> +		iph->check = 0;
> +		iph->check = ip_fast_csum(iph, iph->ihl);

[Severity: Low]
rmnet_map_coal_parse_ip_hdr() checks the version, ihl and fragment bits.
It never verifies the checksum of the original IPv4 header.

Here that header is copied into each new skb and its checksum is
recomputed. A corrupted IPv4 header would therefore arrive with a valid
checksum, and ip_rcv_core() could no longer drop it. Is that intended?

The fast path and the existing CSUM_OFFLOAD path pass the original header
to ip_rcv(). The MAPv4 path checks ip_fast_csum() explicitly in
rmnet_map_ipv4_dl_csum_trailer().

This segmentation path handles multi-NLO frames, any per-packet checksum
error, IPv4 options and IPv6 extension headers.

Should ip_fast_csum() be checked on the original header before it is
copied?

[ ... ]

> +static bool rmnet_map_coal_gro_fast_path(struct sk_buff *coal_skb,
> +					 struct rmnet_map_v5_coal_header *coal_hdr,
> +					 struct rmnet_map_coal_metadata *coal_meta,
> +					 struct sk_buff_head *list,
> +					 u8 num_nlos, bool gro)
> +{
> +	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
> +
> +	if (!gro || num_nlos != 1 ||
> +	    !(coal_hdr->coal_info & MAPV5_COALINFO_CSUM_VALID_FLAG))
> +		return false;

[Severity: Low]
The commit message says:

  A single-packet frame is passed with CHECKSUM_UNNECESSARY when both
  features are enabled and with CHECKSUM_NONE when either feature is
  disabled.

Is that accurate? CHECKSUM_UNNECESSARY is only set in this function. That
also requires gro, num_nlos == 1 and MAPV5_COALINFO_CSUM_VALID_FLAG.

gro is cleared for IPv4 options (ihl != 5), IPv6 extension headers and
zero-payload NLOs.

In all other cases, a single-packet frame goes through
rmnet_map_coal_segment_loop()->__rmnet_map_segment_coal_skb(). There it
is either copied into a new skb with CHECKSUM_PARTIAL by
rmnet_map_partial_csum(), or dropped if its bitmap bit is set.

A later patch in the series adds a CHECKSUM_NONE quirk. The final
rmnet.rst only says single-packet frames become "normal non-GSO skbs".

Could the commit message for this patch describe these cases?

> +
> +	coal_meta->data_len = ntohs(coal_hdr->nl_pairs[0].pkt_len) - hlen;
> +	coal_meta->pkt_count = coal_hdr->nl_pairs[0].num_packets;
> +
> +	coal_skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	if (coal_meta->pkt_count > 1) {
> +		rmnet_map_partial_csum(coal_skb, coal_meta);
> +		rmnet_map_gso_stamp(coal_skb, coal_meta);
> +	}
> +
> +	__skb_queue_tail(list, coal_skb);
> +	return true;
> +}

[Severity: Medium]
This hands the original coalesced skb to the stack. gso_size and
gso_segs come from the NLOs. The L4 checksum is seeded from the aggregate
length in rmnet_map_partial_csum():

	u16 pkt_len = skb->len - coal_meta->ip_len;

Nothing checks the retained header against coal_skb->len: not the IPv4
tot_len or header checksum, the IPv6 payload_len, or the UDP len.
rmnet_map_coal_validate_bounds() only checks the NLO totals against
skb->len.

Is the hardware guaranteed to write aggregate lengths, and a matching
IPv4 header checksum, into this header? What happens if those fields
hold per-segment values?

ip_rcv_core(), ipv6_rcv() and __udp4_lib_rcv() would trim the skb to the
header length. The remaining segments would be lost while gso_segs still
says N.

__udp_gso_segment() would compute wrong per-segment checksums, because
it subtracts uh->len from a seed built with the aggregate length:

	check = csum16_add(csum16_sub(uh->check, uh->len), htons(newlen));

A stale IPv4 header checksum would make ip_rcv() drop the frame.

inet_gro_complete() and udp_gro_complete() normalise these fields for
software GRO. Would it make sense to check them here and fall back to
segmentation when they don't match?

[ ... ]

> +/* Expand a coalesced SKB into individual IP packets placed on the list.
> + * NLOs with checksum errors are dropped. __rmnet_map_ingress_handler will
> + * free the SKB in the error case.
> + */

[Severity: Low]
This isn't a bug, but this comment says whole NLOs are dropped.
rmnet_map_coal_segment_loop() actually drops individual packets by their
position in the flat bitmap, as the comment above
rmnet_map_data_check_coal_header() describes.

A few other pieces of text look stale after this patch.

The MAP_NEXT_HEADER_FLAG comment in include/linux/if_rmnet.h still says
the following, although header type 1 is now the coalescing header:

 *  NEXT_HEADER: 1 = packet contains V5 CSUM header 0 = no V5 CSUM header

rmnet.rst still lists MAPv5 header type 1 as "Reserved" and says the next
header is "limited to checksum header". The later patch "docs:
networking: Add documentation for the coalescing support in rmnet" fixes
this one.

If RMNET_FLAGS_INGRESS_COALESCE is set without
RMNET_FLAGS_INGRESS_MAP_CKSUMV5, rmnet_newlink() and rmnet_changelink()
report "unsupported MAP checksum flag combination". That message doesn't
mention the coalescing dependency.

The comment here, the if_rmnet.h comment and the extack text are
unchanged at the end of the series.

> +static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
> +				      u64 nlo_err_mask,
> +				      struct sk_buff_head *list,
> +				      u16 len, u16 total_pkts)
> +{
> +	bool gro_hw = coal_skb->dev->features & NETIF_F_GRO_HW;
> +	bool rxcsum = coal_skb->dev->features & NETIF_F_RXCSUM;

[ ... ]

> +	/* Device capability gates coalesced delivery. Packet format can still
> +	 * disable GSO and use the per-packet fallback below.
> +	 */
> +	if (total_pkts > 1 && (!rxcsum || !gro_hw))
> +		return -EINVAL;

[Severity: Medium]
Clearing NETIF_F_GRO_HW or NETIF_F_RXCSUM on the rmnet device doesn't
stop the modem from coalescing. rmnet has no ndo_set_features, so the
change never reaches the hardware.

Every multi-packet frame then returns -EINVAL here. Can this make
__rmnet_map_ingress_handler() free frames that each carry up to 48 valid
packets?

Documentation/networking/netdev-features.rst describes rx-gro-hw as a
request for the NIC to enable hardware GRO, not as a filter on received
traffic.

The core also clears GRO_HW on its own:

generic_xdp_install()->dev_disable_gro_hw()

net/core/dev.c:netdev_fix_features() {
    ...
		if (features & NETIF_F_GRO_HW) {
			netdev_dbg(dev, "Dropping NETIF_F_GRO_HW since no RXCSUM feature.\n");
			features &= ~NETIF_F_GRO_HW;
		}
}

So attaching an xdpgeneric program, or running "ethtool -K <dev> rx off",
would silently drop all multi-packet coalesced traffic.

rmnet_vnd_newlink() adds NETIF_F_GRO_HW and NETIF_F_RXCSUM only to
hw_features, never to the device's enabled features, so both start
disabled. Won't a port created with RMNET_FLAGS_INGRESS_COALESCE drop
multi-packet frames until the user also enables both features with
ethtool?

The gro == false path in rmnet_map_coal_segment_loop() already delivers
packets one at a time. Could that be used here instead of dropping the
frame?

The documentation patch at the end of the series only records this
behaviour ("Otherwise, multi-packet coalesced frames are rejected"), and
the drop still has no counter.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com
