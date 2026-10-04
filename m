Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B19403B17;
	Sun,  4 Oct 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093959; cv=none; b=ZS74yVzSO8Wv3KUafuB4zE1k8+wACu2sAZ6o4Y3K9nvaEWKmU3mvWRWviSOWWQ1LMcymxGveUEJFNSXKP8UsHW9ImzhOMmWdPuKzfjnfVhobUWAB/fRmYJGkNy+yHfkVBM3Pfz6T3NevMBv2yExhSQTwv2+P2Fam024cqh/hAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093959; c=relaxed/simple;
	bh=2+b8clYiU2Xo2TzIiTqKytERB5d0JveF/ka/TWtHj3E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okoxpt9XhHuer2JiueNiWFcarMJTLTFkzwp6b3tq5zpcFoVHuM2/XezIjdgVM8GacN0Dmtzq9IqXDZh1oGoD4BVZGv95SYqY0z3oxNPCKT6WVEip89s+OPW/djA0VP5dMolIR8GRawaqMA5Jmdpgvsr7PiX7qfbAahEheaQzAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKNstmCD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKNstmCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8767D1F00893;
	Sun,  4 Oct 2026 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093956;
	bh=Lw4emgjocQvGX0eE/zUNfg4sIlwnOZWrYKcr793cxGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JKNstmCDp/7xjb9LV696PP4O/R4g3MljwD7z6u/9bTkF5IFEUg+Nd0GloEFNpfGmt
	 oOVJFT32Ozgmp0hC54JNqESF32R2rQykPUYdquKHXox264O70tDm4IkSuo7oICW4pT
	 AIyVhdwqQj8jptsAVYCQsESR3il7UvL43rrvIDsXCOxPa3cclUgXAKr/ntPebf7JVz
	 4JIOqY8591L+JDPDPkyVZ65ujH0blKdjRKnZ2uh6vW9nM1XNDS+32PRN8cyqr05PqU
	 HygwbK5wx9o4XJ7Cq2rEcU4AQneve1hx3C81p3nj/wZRvWT9HayS1/kZPIg/7fABy6
	 UGZJvyzFqm3fQ==
Subject: Re: [PATCH net-next 7/7] docs: networking: Add documentation for the
 coalescing support in rmnet
From: netdev-bot+sashiko@kernel.org
To: subash.a.kasiviswanathan@oss.qualcomm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net, horms@kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.tranchetti@oss.qualcomm.com
Date: Sun, 04 Oct 2026 06:05:55 +0000
Message-ID: <179109395510.434549.6510623300595758136@kernel.org>
In-Reply-To:
 <20260930051345.857443-8-subash.a.kasiviswanathan@oss.qualcomm.com>
References:
 <20260930051345.857443-8-subash.a.kasiviswanathan@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rmnet.rst gets the MAPv5 coalescing checksum error bitmap
  wrong.
- [Low] The opening sentence of the new "e.
- [Low] The patch adds a "data format flags" section under "3.
- [Low] The new doc treats Num NLOs and CSUM valid as reliable.
- [Low] The layout diagram in rmnet.rst ends with "... (up to 6 NLO
  entries total, same 32-bit format per entry)" and then gives Num NLOs…

--

docs: networking: Add documentation for the coalescing support in rmnet

This patch documents the MAPv5 coalescing header (header type 1) in
rmnet.rst. It covers the header layout, the close type and close value
encodings, and the per-NLO entry format. It also adds a section on the
IFLA_RMNET_FLAGS data format flags, including RMNET_FLAGS_INGRESS_COALESCE.

> diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> index 5aedbabb73827..ba8e947d54e68 100644
> --- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> +++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst

[ ... ]

> @@ -162,8 +162,78 @@ indicates that the calculated packet checksum is invalid.
>  
>  Reserved bits must be zero when sent and ignored when received.
>  
> -e. MAP packet v1/v5 (command specific)
> ---------------------------------------
> +e. Coalescing header v5
> +------------------------
> +
> +Hardware can coalesce multiple same-flow IP packets of the same length into
> +a single MAP frame to reduce per-packet overhead at high data rates.  The
> +coalescing header (header type 1) describes the coalesced content.

[Severity: Low]
Is "of the same length" accurate for the whole frame? Each of the up to
six NLO slots has its own pkt_len in struct rmnet_map_v5_nl_pair, and
rmnet_map_coal_segment_loop() reads a separate length for each NLO:

    pkt_len = ntohs(coal_hdr->nl_pairs[nlo].pkt_len);

The DL coalescing commit in this series also says "hardware can coalesce
up to 6 different sizes within a single IP packet".

Only the packets inside one NLO share a length, and the Num NLOs paragraph
further down says exactly that. Could the intro be reworded so the two
paragraphs agree?

> +
> +Packet format::
> +
> +  Bit         0 - 6         7          8           9-11         12-15
> +  Function  Header Type  Next Header  CSUM valid  Num NLOs    (reserved)
> +
> +  Bit        16-19        20-23
> +  Function  Close value  Close type
> +
> +  Bit        24-27        28-31
> +  Function  (reserved)    VEID
> +
> +  Bit           32 - 47        48 - 55            56 - 63
> +  Function   Packet length  CSUM error bitmap  Num packets (NLO 0)
> +
> +  ... (up to 6 NLO entries total, same 32-bit format per entry)

[Severity: Low]
Could this wording suggest that the header length changes with Num NLOs?
The driver treats the coalescing header as a fixed 28-byte structure, with
all six slots always present:

include/linux/if_rmnet.h:
    struct rmnet_map_v5_coal_header {
        ...
        struct rmnet_map_v5_nl_pair nl_pairs[RMNET_MAP_V5_MAX_NLOS];
    } __aligned(1);

rmnet_map_segment_coal_skb() always pulls the full header, whatever Num
NLOs says:

    skb_pull(coal_skb, sizeof(*coal_hdr));

rmnet_map_data_check_coal_header() also reads all six slots. It requires
ntohs(maph->pkt_len) >= sizeof(*coal_hdr), because the coalescing header
is counted in the MAP pkt_len.

Suppose a decoder sizes the header as 4 + 4 * Num NLOs. It would start
parsing the IP packet at the wrong offset whenever fewer than six NLOs are
active.

Could the text say that all six slots are always present, that unused
slots are zero, and that the header is counted in the MAP header's
pkt_len?

> +
> +Header Type is set to 1 (coalescing).
> +
> +Num NLOs (Number-Length Objects) is the count of active NLO entries
> +(1 – 6).  Each NLO describes a group of consecutive coalesced packets
> +that all share the same IP packet length.
> +
> +CSUM valid (bit 8) indicates whether the hardware checksum is valid
> +for all packets in the frame.

[Severity: Low]
Should these two fields mention the hardware quirks that the driver in
this series works around? rmnet_map_v5_fixup_num_nlos() says:

    /* On some hardware, num_nlos in the coalescing header can be reported
     * incorrectly under certain conditions even though the per-NLO num_packets
     * fields it is meant to summarize are correct. ...

It then recomputes the count from the non-zero nl_pairs[].num_packets
slots. That only works if unused slots have num_packets == 0, and the doc
does not state that requirement. According to the "net: qualcomm: rmnet:
Work around coalescing hardware quirks" commit message, the num_nlos
misreporting was seen on simulation hardware.

rmnet_map_v5_csum_fixup() has a similar note:

    /* The checksum valid indication for a single NLO, single packet coalescing
     * frame cannot be trusted when the close reason is a TCP FIN/PSH, a packet
     * count limit, a byte count limit or a time limit.
     */

In those cases rmnet_map_segment_coal_skb() forces CHECKSUM_NONE. The doc
says CSUM valid applies to all packets in the frame and gives none of
these caveats. A receiver written from this text would trust checksums
that the driver deliberately refuses to trust.

[ ... ]

> +Each NLO entry::
> +
> +  Bit         0 - 15        16 - 23            24 - 31
> +  Function  Pkt length   CSUM error bitmap   Num packets
> +
> +Pkt length is the full IP packet length, including the IP header,
> +transport header, and payload, for every packet in this NLO group.
> +
> +CSUM error bitmap is a per-packet bitmask. Bit N is set when packet N
> +in this NLO has a bad checksum.

[Severity: Medium]
Does this match how the driver decodes the bitmap? The comment above
rmnet_map_data_check_coal_header() describes the opposite layout:

 * nlo_err_mask is NOT six independent per-NLO bitmaps. Each nl_pairs
 * slot only has room for an 8 bit csum_error_bitmap, but a single NLO
 * can carry more than 8 packets (up to RMNET_MAP_V5_MAX_PACKETS), so
 * hardware spills a wide NLO's error bits into the csum_error_bitmap
 * bytes of the following slots rather than truncating them. The
 * six bitmap bytes are therefore always concatenated in slot order
 * into one flat RMNET_MAP_V5_MAX_NLOS * 8 = RMNET_MAP_V5_MAX_PACKETS
 * bit value, addressed by a packet's absolute position in the frame,
 * regardless of how many NLOs are actually in use. ...

The code joins all six bytes in slot order, whatever num_nlos is:

    mask |= ((u64)err) << (8 * i);

rmnet_map_coal_segment_loop() then consumes one bit per packet, starting
from the LSB, in absolute frame order. It never re-aligns at an NLO
boundary:

    pkt++, total_pkt++, nlo_err_mask >>= 1) {
        csum_err = nlo_err_mask & 1;

The two readings disagree for most multi-NLO frames. Take a frame where
NLO 0 has 3 packets. The driver maps the first packet of NLO 1 to bit 3 of
slot 0's byte, but the doc maps it to bit 0 of slot 1's byte. An 8-bit
per-NLO field also cannot describe an NLO with more than 8 packets.

The bit order is not stated either. The other diagrams in this section
number bits MSB-first: Header Type is bits 0-6 and Next Header is bit 7,
which matches MAPV5_HDRINFO_HDR_TYPE_FMASK being GENMASK(7, 1) and the
next header flag being BIT(0). A reader would probably take "Bit N" as
MSB-first, but the driver maps packet 0 to the LSB.

Could this paragraph describe the bitmap as a single 48-bit stream across
all six slots? It would be indexed by the packet's position in the frame,
with packet 0 in the LSB of slot 0's byte.

[ ... ]

> @@ -208,3 +278,32 @@ rmnet userspace configuration is done through netlink using iproute2
>  https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/
>  
>  The driver uses rtnl_link_ops for communication.
> +
> +The data format flags controlling the ingress and egress processing
> +pipeline are set via the ``IFLA_RMNET_FLAGS`` attribute
> +(``struct ifla_rmnet_flags``).

[ ... ]

> +``RMNET_FLAGS_INGRESS_COALESCE``
> +  Enable MAPv5 downlink hardware coalescing (header type 1).
> +  When set the driver will decode coalescing headers, reconstruct
> +  individual IP packets and will deliver batched GSO SKBs to the
> +  stack for efficient processing.

[Severity: Low]
Can this flag be used on its own, as described here?
rmnet_config_data_format_valid() rejects it unless the v5 ingress checksum
flag is also set. It also rejects any mix of v4 and v5 checksum flags:

    if ((data_format & v4_mask) && (data_format & v5_mask))
        return false;

    if ((data_format & RMNET_FLAGS_INGRESS_COALESCE) &&
        !(data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5))
        return false;

When this check fails, rmnet_newlink() and rmnet_changelink() return
-EINVAL with the extack "unsupported MAP checksum flag combination".
rmnet_newlink() starts with only RMNET_FLAGS_INGRESS_DEAGGREGATION set, so
a link that asks for just RMNET_FLAGS_INGRESS_COALESCE is rejected.

Would it help to document both of these rules?

The "batched GSO SKBs" part also seems to depend on a feature bit that is
off by default. rmnet_map_segment_coal_skb() checks dev->features:

    bool gro = coal_skb->dev->features & NETIF_F_GRO_HW;

However, rmnet_vnd_newlink() only adds the bit to hw_features:

    rmnet_dev->hw_features |= NETIF_F_GRO_HW;

Nothing in rmnet sets NETIF_F_GRO_HW in dev->features. Unless rx-gro-hw
is enabled by hand, rmnet_map_coal_segment_loop() passes each packet up
as its own non-GSO skb.

Separately, the commit message only covers the coalescing header layout
and its fields. Could it also mention this new IFLA_RMNET_FLAGS section?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930051345.857443-1-subash.a.kasiviswanathan%40oss.qualcomm.com
