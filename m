Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E444A72C;
	Sat, 10 Oct 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624555; cv=none; b=bEEruscwIoDME9qUl49iIE0ySi8LusBKEIVOx8Lcd5U8EAGOt5DjTELEzOusCusNcyNiyhqd8SPy9u2xVdiBCWdjR2LDOiiV9e5wQULKb4Tjjq3TkPsnTROXL8bvY9KGQvrnxsjZji6kV1EiQIFlGyf2OiBxAk7uhoJ5MAOv1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624555; c=relaxed/simple;
	bh=IoKbd3Cj9/XqlRQ0qbxAPyFZpvebMhplNjTK9hDfJyM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUXKXjlKi1ddwd5TKpWKqQnoD88WQvaJy2Vr6mtoP9sZv2XDP4l3LvLc0uqrRB9iGFHb4beY6H0fvM4X0qy9EsrwS+CkhXwfR3mQEzDP6f8ry2SToE7Tx3LPszaYHA8D6wc1WTRaSCN+TFWSZY0oxyUQizt0wLim3IBDI3nc1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBOh2A/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBOh2A/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E2B1F000FF;
	Sat, 10 Oct 2026 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791624553;
	bh=JJCD+BM8OQRbbhmPIh55knqUKVnl+PPt4F6+rgNpE5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aBOh2A/upk6xLoWHrEzvdjT8jqyG/nXy6ZE6VLzCIamKi0oRNE2lUTou9+6w2rIHD
	 SyT+Fk1MLp5NbMfrzlOknM+TYnKU3tkqzHGBu16+Ecj0uis2+Aus6uZuiqY5IwHzSR
	 n0pjdGfd/HovfuCC+UrtuNXT6oCHwWEZ6nWyOyKnC4FdXvga04gQLGEeMmdgiDF3fV
	 308l77hCpsRM+epAfcozSQFn6WxKno5sCjIw4lO/57Oc5De6ARbNOT8nT/PtxI+lkp
	 9wdKiYs3iskTLOu0fEzo6qo8vz0w9u5XtVhr/TDRMH+RRXy8qfqvl+JOtEMVZrWpkc
	 ryAl6I2CkOVlQ==
Subject: Re: [PATCH net-next v3 8/8] docs: networking: Add documentation for
 the coalescing support in rmnet
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 sean.tranchetti@oss.qualcomm.com
Date: Sat, 10 Oct 2026 09:29:12 +0000
Message-ID: <179162455218.434549.13807583931507621107@kernel.org>
In-Reply-To:
 <20261009084351.317632-9-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20261009084351.317632-9-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new rmnet.rst text never says that rmnet itself drops packets
  that the CSUM error bitmap flags, and it states the single-packet…
- [Low] The MAPv4/MAPv5 checksum mutual-exclusion rule is documented only
  under RMNET_FLAGS_INGRESS_COALESCE, and its wording is ambiguous:…
- [Low] The comment for the rmnet_map_header flags field in
  include/linux/if_rmnet.h still says 'NEXT_HEADER: 1 = packet contains…
- [Low] The comment above rmnet_map_segment_coal_skb()
  (rmnet_map_data.c:1116) says 'NLOs with checksum errors are dropped.'…
- [Low] The new section 'e.

--

docs: networking: Add documentation for the coalescing support in rmnet

This commit documents the MAPv5 coalescing header layout and field
semantics in rmnet.rst. It also documents the IFLA_RMNET_FLAGS ingress and
egress flags, the rules for combining coalescing with checksum offload,
and when coalesced frames are delivered as GSO skbs.

> diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> index 5aedbabb73827..52f92d2fba311 100644
> --- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> +++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> @@ -125,8 +125,8 @@ Command (1)/ Data (0) bit value is to indicate if the packet is a MAP command
>  or data packet. Command packet is used for transport level flow control. Data
>  packets are standard IP packets.
>  
> -Next header is used to indicate the presence of another header, currently is
> -limited to checksum header.
> +Next header is used to indicate the presence of another header, currently
> +limited to the checksum and coalescing headers.

[Severity: Low]
This text now disagrees with the flags comment in include/linux/if_rmnet.h.
The series did not update that comment:

/* rmnet_map_header flags field:
 ...
 *  NEXT_HEADER: 1 = packet contains V5 CSUM header 0 = no V5 CSUM header
 */
#define MAP_NEXT_HEADER_FLAG		BIT(6)

After this series, MAP_NEXT_HEADER_FLAG can also indicate a coalescing
header. rmnet_map_validate_packet_len() handles the length of that type
differently:

		if (hdr_type == RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
			packet_len += sizeof(*next_hdr);
		else if (hdr_type != RMNET_MAP_HEADER_TYPE_COALESCING)
			return 0;

Should the comment in if_rmnet.h also mention the coalescing header?

[ ... ]

> @@ -162,8 +162,109 @@ indicates that the calculated packet checksum is invalid.
>  
>  Reserved bits must be zero when sent and ignored when received.
>  
> -e. MAP packet v1/v5 (command specific)
> ---------------------------------------
> +e. Coalescing header v5
> +------------------------
> +
> +Hardware can coalesce multiple same-flow IP packets into a single MAP frame
> +to reduce per-packet overhead at high data rates.  Packets are grouped into
> +NLOs, with all packets in each NLO having the same length.  The coalescing
> +header (header type 1) describes the coalesced content.

[Severity: Low]
Sections a through d each say their fields are in big endian format. This
new section gives no byte order.

The NLO Pkt length field is big endian on the wire:

include/linux/if_rmnet.h:
struct rmnet_map_v5_nl_pair {
	__be16 pkt_len;
	u8  csum_error_bitmap;
	u8  num_packets;
} __aligned(1);

Could this section add a sentence such as "Coalescing header fields are in
big endian format."?

[ ... ]

> +CSUM error bitmap is one 48-bit stream formed by concatenating the
> +``csum_error_bitmap`` bytes from all six NLO slots in slot order. Packet 0
> +corresponds to bit 0 of slot 0's bitmap byte, and bits are consumed from
> +least significant bit to most significant bit. The bit stream is indexed by
> +the packet's absolute position in the frame and does not restart at an NLO
> +boundary. If an NLO contains more than eight packets, its error bits
> +continue into the bitmap byte of the following slot. Bitmap bytes in slots
> +after the active NLO prefix may therefore contain continuation bits and must
> +not be ignored.

[Severity: Low]
This description matches rmnet_map_coal_segment_loop(). The comment above
rmnet_map_segment_coal_skb() in rmnet_map_data.c says something different:

/* Expand a coalesced SKB into individual IP packets placed on the list.
 * NLOs with checksum errors are dropped. __rmnet_map_ingress_handler will
 * free the SKB in the error case.
 */

rmnet_map_coal_segment_loop() checks the flat bitmap once per packet:

			csum_err = nlo_err_mask & 1;

It flushes the good packets collected so far, drops only the errored
packet, and carries on within the same NLO.

Should that comment say that individual packets are dropped, not whole
NLOs?

[Severity: Low]
This section explains how the bitmap is encoded, but not what rmnet does
with the packets it flags. __rmnet_map_segment_coal_skb() drops a flagged
packet and counts it:

	if (!csum_valid && coal_meta->zero_csum)
		csum_valid = true;

	if (!csum_valid) {
		...
		u64_stats_add(&pcpu_ptr->priv_stats.rx_dropped, coal_meta->pkt_count);
		u64_stats_inc(&pcpu_ptr->priv_stats.coal_csum_drop);
		...
		goto next_pkt;
	}

Could the doc say that these packets are dropped and counted in
rx_dropped?

The zero checksum exemption appears only in the single-packet quirk
paragraph ("IPv4 UDP packets with a zero checksum remain valid ..."). In
the code, zero_csum overrides the bitmap for every rebuilt segment, not
only in that case.

The RMNET_FLAGS_INGRESS_COALESCE entry further down says "A coalesced
frame containing one packet is delivered as a normal non-GSO skb." Does
that still hold when RX checksum offload and rx-gro-hw are both enabled?

Take a single-NLO, single-packet frame where:

  - CSUM valid is clear
  - the close reason is not on the quirk list (for example close type 0,
    1 or 2)
  - bit 0 of the bitmap is set
  - the packet is not zero-checksum IPv4 UDP

The path looks like this:

rmnet_map_segment_coal_skb()
  rmnet_map_v5_csum_fixup() returns false
  rmnet_map_coal_gro_fast_path() returns false
  rmnet_map_coal_segment_loop()
    __rmnet_map_segment_coal_skb(..., false)   <- packet dropped

The list stays empty, rmnet_map_process_next_hdr_packet() frees the skb,
and nothing is delivered.

[ ... ]

> @@ -208,3 +309,39 @@ rmnet userspace configuration is done through netlink using iproute2
>  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/
>  
>  The driver uses rtnl_link_ops for communication.
> +
> +The data format flags controlling the ingress and egress processing
> +pipeline are set via the ``IFLA_RMNET_FLAGS`` attribute
> +(``struct ifla_rmnet_flags``).
> +
> +Relevant ingress flags:
> +
> +``RMNET_FLAGS_INGRESS_DEAGGREGATION``
> +  Enable MAP frame de-aggregation.
> +
> +``RMNET_FLAGS_INGRESS_MAP_CKSUMV4``
> +  Enable MAPv4 downlink checksum offload.
> +
> +``RMNET_FLAGS_INGRESS_MAP_CKSUMV5``
> +  Enable MAPv5 downlink checksum offload (header type 2).
> +
> +``RMNET_FLAGS_INGRESS_COALESCE``
> +  Enable MAPv5 downlink hardware coalescing (header type 1).
> +  This flag requires ``RMNET_FLAGS_INGRESS_MAP_CKSUMV5``. MAPv4 and
> +  MAPv5 checksum flags cannot be enabled together in either direction.
> +  A direction may leave checksum offload disabled. Invalid combinations
> +  are rejected.

[Severity: Low]
"cannot be enabled together in either direction" reads like a rule
applied to each direction separately. rmnet_config_data_format_valid()
applies it to the whole device, whether or not
RMNET_FLAGS_INGRESS_COALESCE is set:

	u32 v4_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV4 |
		      RMNET_FLAGS_EGRESS_MAP_CKSUMV4;
	u32 v5_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
		      RMNET_FLAGS_EGRESS_MAP_CKSUMV5;

	if ((data_format & v4_mask) && (data_format & v5_mask))
		return false;

This means rmnet_newlink() and rmnet_changelink() reject
RMNET_FLAGS_INGRESS_MAP_CKSUMV5 plus RMNET_FLAGS_EGRESS_MAP_CKSUMV4 with
-EINVAL, even with no coalescing.

The rule applies to the checksum flags by themselves. Could it go in the
RMNET_FLAGS_INGRESS/EGRESS_MAP_CKSUMV4/V5 entries, worded to say that only
one checksum version may be enabled across both directions?

The comment above rmnet_config_data_format_valid() ("selected
independently for ingress and egress, but only one version may be enabled
across the device") is also ambiguous on this point.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009084351.317632-1-subash.a.kasiviswanathan%40oss.qualcomm.com
