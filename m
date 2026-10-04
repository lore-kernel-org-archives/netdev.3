Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E93400DFC;
	Sun,  4 Oct 2026 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093957; cv=none; b=ER+yvR/82CBHyReb3BDtAs0v0Eqiozs97NnhKq2ZLSRgRlohsTOTftJEBvwqLQ+3GtED9buJlKaCKAQZ+rK38JLAj4khPh6rRgMZqGIQRwFjC+SD9fjWCOy8fPy6GCedA1sMYqH8GeJHBlTAVXQCVjykaT86g/op35nzALDkB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093957; c=relaxed/simple;
	bh=GwhyraQYPsP3SliW3oCVpN0OWPmgJOV0ZMoIcqcNOv0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MS8ExWFYyxrXmmPn9Dw4z7XeVF8LbaCOLz4/iphpHA8lDz6HbQGhIuil1vkphFI6ipc3pBddwdeDLqjoBW4zn1RP+LVZwvAmIVClBEzoYtAM3moiqPktr9xkLdYVXHuJ6QrBmVwgewKM+Pz7EWvZfyu0rrnuE2Gnt5SQ2G9TMoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+qchQDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+qchQDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58491F000FF;
	Sun,  4 Oct 2026 06:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093953;
	bh=7LcFOOS6vJ0VzJYywxk2IW1g8Calbb1D9OqPwa+qJHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J+qchQDGOP1eioDy6RLr7kRy7S2QiTXEsszJFKd/y4gOw6SUISgpIlu8UaNyJMSeH
	 KUZHYzqoCEuK3DV+XEJ+yMX02WTMPRfkvhth0DnIYeEgou+hpvgbcN6MDPzloUmFa1
	 Q5zPJVySN7vTbpAbDEjs48Okav3DWy+HgnzXJMiGSuVckQXOd37Ny9ewcS+DiBGEVO
	 mZJacfcZNNgfSK7ikSVPq14vF3CGYz2GDNwGSEah2cRSwxY7aZcW83m/DfSJiJxSfx
	 oow2PqjOHRqzNPi7kYFY/PpuhLTjL/UF1SxVJkgFLQGsLdJL5axgOXccpHTdcHHXrj
	 Kyd1rDEPym9VQ==
Subject: Re: [PATCH net-next 5/7] net: qualcomm: rmnet: Work around coalescing
 hardware quirks
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com
Date: Sun, 04 Oct 2026 06:05:52 +0000
Message-ID: <179109395246.434549.15222645066222018074@kernel.org>
In-Reply-To:
 <20260930051345.857443-6-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20260930051345.857443-6-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Out-of-bounds read while parsing IPv6 coalescing frames.
- [Medium] The recount does not meet the commit's claim that the
  determination is reliable 'regardless of whether num_nlos itself can…
- [Medium] rmnet_map_v5_fixup_num_nlos() (lines 603-615) sets num_nlos to
  the number of the six nl_pairs[] slots whose num_packets is non-zero,…
- [Medium] rmnet_map_v5_fixup_num_nlos() writes coal_hdr->coal_info (line
  613) directly into the data of the received skb.
- [Low] The commit message mixes up two different hardware checksum
  indications.

--

net: qualcomm: rmnet: Work around coalescing hardware quirks

This patch works around hardware that reports a bad checksum valid
indication for single-NLO, single-packet MAPv5 coalescing frames with
some close reasons. It hands those frames to the stack as CHECKSUM_NONE.
It also recomputes num_nlos from the per-slot num_packets fields, because
the declared value can be wrong on some simulation hardware.

> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index bb88e19e28d82..1f9e592e24b65 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -593,6 +593,61 @@ static void rmnet_map_partial_csum(struct sk_buff *skb,

[ ... ]

> +static void rmnet_map_v5_fixup_num_nlos(struct rmnet_map_v5_coal_header *coal_hdr)
> +{
> +	u8 nlos = 0;
> +	int i;
> +
> +	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
> +		if (coal_hdr->nl_pairs[i].num_packets)
> +			nlos++;
> +	}

[Severity: Medium]
This counts the slots with a non-zero num_packets anywhere in nl_pairs[].
The users of num_nlos, however, read it as the length of a prefix.

rmnet_map_coal_validate_bounds() and rmnet_map_coal_segment_loop() walk
nl_pairs[0..num_nlos-1]. rmnet_map_v5_csum_fixup() and
rmnet_map_coal_gro_fast_path() look at nl_pairs[0] when num_nlos == 1.

Do these two readings only agree when the used slots start at slot 0,
have no gaps, and unused slots read as zero?

For example, num_packets of [0, 1, 0, 0, 0, 0] gives a recount of 1.
rmnet_map_v5_csum_fixup() then hits:

	if (num_nlos != 1 || coal_hdr->nl_pairs[0].num_packets != 1)
		return false;

With GRO enabled and CSUM_VALID set, rmnet_map_coal_gro_fast_path() then
queues coal_skb as CHECKSUM_UNNECESSARY. That is the indication this patch
is trying to stop trusting. Without GRO, nothing is emitted and the frame
is consumed.

With [1, 0, 1, ...] the recount is 2. The packet in slot 2 is then lost
without any error, or the frame is rejected if slot 1's pkt_len is below
hlen.

A leftover non-zero num_packets in an unused trailing slot of a frame
declared with num_nlos = 1 would also raise the recount. That skips the
fixup and brings undeclared slots into validation and segmentation. Before
this patch, only the declared prefix was read.

The comment above rmnet_map_data_check_coal_header() already says that
hardware writes into the csum_error_bitmap bytes of unused slots. Is it
guaranteed that num_packets in unused slots is always zero?

Would it be more robust to use the index of the last non-zero slot plus
one, or to stop at the first empty slot and reject gaps? Another option is
for rmnet_map_v5_csum_fixup() to check directly that slot 0 holds one
packet and all other slots are empty.

> +
> +	coal_hdr->coal_info = u8_encode_bits(nlos, MAPV5_COALINFO_NUM_NLOS_FMASK) |
> +			      (coal_hdr->coal_info & MAPV5_COALINFO_CSUM_VALID_FLAG);

[Severity: Medium]
This writes coal_info in place, in the data of the received skb.

On a raw-IP real device without RMNET_FLAGS_INGRESS_DEAGGREGATION,
rmnet_map_ingress_handler() passes the original rx skb straight through:

	if (rmnet_map_validate_packet_len(skb, data_format))
		__rmnet_map_ingress_handler(skb, port, data_format);

rmnet_rx_handler() only calls skb_linearize(), which does nothing for a
linear skb. Nothing on this path calls skb_share_check(), skb_unshare() or
skb_cow().

Before the rx_handler runs, __netif_receive_skb_core() delivers the skb to
ptype_all taps. packet_rcv() then queues a clone on the AF_PACKET socket,
and that clone shares this data buffer.

Can this rewrite NUM_NLOS, and clear the reserved low bits of coal_info,
in a buffer that an AF_PACKET reader may be copying to user space at the
same time?

Only num_nlos is needed, so could the recount be kept in a local variable
instead of being written back into the header? The deaggregation path and
the ARPHRD_ETHER path do not seem to be affected, because they copy or
expand the head first.

Separately, the earlier patch in this series, "net: qualcomm: rmnet: Add
DL packet coalescing support", already writes tp->check in place through
rmnet_map_partial_csum() in the fast path. Would unsharing the skb before
changing it be the more complete fix?

> +}

[ ... ]

> @@ -913,6 +968,7 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
>  	skb_pull(coal_skb, sizeof(struct rmnet_map_header));
>  	skb_trim(coal_skb, len);
>  	coal_hdr = (struct rmnet_map_v5_coal_header *)coal_skb->data;
> +	rmnet_map_v5_fixup_num_nlos(coal_hdr);

[Severity: Medium]
The commit message says the determination is reliable "regardless of
whether num_nlos itself can be trusted". However,
rmnet_map_process_next_hdr_packet() calls
rmnet_map_data_check_coal_header() before this point, and that function
range-checks the raw hardware value:

	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);

	if (num_nlos == 0 || num_nlos > RMNET_MAP_V5_MAX_NLOS)
		return -EINVAL;

The field is 3 bits wide, so 7 is a possible value. If the hardware
reports num_nlos as 0 or 7, is the whole frame still dropped in
__rmnet_map_ingress_handler(), even when the per-slot num_packets are
valid?

The opposite case also seems uncovered. Suppose the raw value is in
[1, 6] but every num_packets is 0. The recount here is then 0, and nothing
range-checks it:

- rmnet_map_coal_validate_bounds() loops zero times.
- rmnet_map_v5_csum_fixup() and the fast path both return false.
- rmnet_map_coal_segment_loop() emits nothing.

rmnet_map_segment_coal_skb() returns 0, and the caller does:

	if (skb_peek(list) != skb)
		consume_skb(skb);

The frame is consumed with no error counted.

Should the recount run before or inside
rmnet_map_data_check_coal_header(), and should a result of 0 be rejected?

>  	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
>  	skb_pull(coal_skb, sizeof(*coal_hdr));

[Severity: High]
This problem is not in this patch. It comes from the earlier patch in
this series, "net: qualcomm: rmnet: Add DL packet coalescing support". It
is still present here, though, and the new CHECKSUM_NONE branch below only
runs after it.

Right after this point, rmnet_map_coal_parse_ip_hdr() handles IPv6 like
this:

		ret = ipv6_skip_exthdr(coal_skb, sizeof(*ip6h), &protocol,
				       &frag_off);
		if (ret < 0 || frag_off)
			return false;

		meta->ip_len = (u16)ret;

ipv6_skip_exthdr() is documented as possibly returning an offset past the
end of the packet if the last recognized header is truncated. It reads
only the 2-byte ipv6_opt_hdr and adds ipv6_optlen(hp), which can be up to
2048.

For example, take a 42-byte IPv6 payload with nexthdr HOP or DEST and an
option header of {nexthdr = TCP, hdrlen = 255}. The call returns 2088.

rmnet_map_coal_parse_trans_hdr() then does:

	avail = coal_skb->len - meta->ip_len;

	if (meta->trans_proto == IPPROTO_TCP) {
		if (avail < sizeof(*th))
			return false;

		th = (struct tcphdr *)base;
		meta->trans_len = th->doff * 4;

Can avail wrap to a huge u32 value here? If so, th->doff is read from
ip_header + 2088, past the end of the packet.

If the pkt_len reported by the hardware is also at least hlen, the check
in rmnet_map_coal_validate_bounds() fails too, because
coal_skb->len - hlen also wraps. The segmentation path would then
memcpy() the IP header, TCP header and payload bytes from out-of-bounds
memory into new skbs that go to the stack.

Would it fix this to reject ret > coal_skb->len before storing ip_len, and
ideally also reject ret plus the minimum transport header length > len?

>  
> @@ -927,6 +983,12 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
>  	if (!rmnet_map_coal_validate_bounds(coal_skb, coal_hdr, num_nlos, hlen))
>  		return -EINVAL;
>  
> +	if (rmnet_map_v5_csum_fixup(coal_hdr) && !coal_meta.zero_csum) {
> +		coal_skb->ip_summed = CHECKSUM_NONE;
> +		__skb_queue_tail(list, coal_skb);
> +		return 0;
> +	}

[Severity: Low]
The commit message says:

  On certain hardware, the checksum valid indication from the bitmap
  inside a MAPv5 coalescing frame cannot be trusted ...

  The hardware sets CSUM_VALID incorrectly in these cases, causing
  the driver to mark packets CHECKSUM_UNNECESSARY ...

Does this mix up two different indications?

In the driver, the frame-level MAPV5_COALINFO_CSUM_VALID_FLAG is used only
by rmnet_map_coal_gro_fast_path(), which sets CHECKSUM_UNNECESSARY.

The per-slot csum_error_bitmap feeds nlo_err_mask in
rmnet_map_coal_segment_loop(). There, flagged packets are dropped in
__rmnet_map_segment_coal_skb(), and the rest become CHECKSUM_PARTIAL
through rmnet_map_partial_csum().

This early return skips both paths for qualifying frames. Packets that the
bitmap marks bad are no longer dropped in the driver. They go to the stack
as CHECKSUM_NONE and are dropped there after verification. They are also
not counted in coal_csum_err or coal_csum_drop, including after the stats
patch later in the series.

Could the commit message say which indication is actually wrong? Could it
also mention that the non-GRO, bitmap-based path changes as well?

> +
>  	if (rmnet_map_coal_gro_fast_path(coal_skb, coal_hdr, &coal_meta, list,
>  					 num_nlos, gro))
>  		return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930051345.857443-1-subash.a.kasiviswanathan%40oss.qualcomm.com
