Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604E4E4C2D;
	Mon, 19 Oct 2026 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410191; cv=none; b=rEuYz5CnAvqLO2viHGFb3xCr7omq2cZ3FGtlYGXJC4fBfLjyPyORuGPacJYENZRnGceed7PdAqf3Crn4i0eMX+0/VeYPswvOL6sZ88vlsSPkUpklHA3v/ha4vOFkPDcAfrhotYtiG6zwKRFMcZIjJ/hf6LpxF3/4IbQ6xLJLcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410191; c=relaxed/simple;
	bh=az2cLGDwAiG+4f1/l8NqWE1K6yVktSw7kgkOIa9eer8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPLBCsNR8XtYL98oIEfSCk06zc+sA7EtYT+HZPQA01s4baEDI2F5JjRo2rCnIpSsJDIJBf9PNy8zLDRtWFZps3rWdAMY8H4Wxs9U+ItoUIUvkqZ6Uow0MZDUdjq+9UB8sdwdGRaNtjBgq31qVrz/m4hcOc9/A4YuS734SX4wCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geUGuejb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geUGuejb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B301F000C5;
	Mon, 19 Oct 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410188;
	bh=gcIHXjxkQajXJE6xxpWQKTCJQsgdsZadRObBkEjqpSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=geUGuejbe1abMiLK9h0NekYVEww7yfYuPnoyiqbCQsGRCADgoRuf+bdQvuY8pl276
	 F0dbmiwz3fLg5zYRPpNOElqaDroE/XeVEvy87VqYQ7AvghBeNKvZ5ZnI1ZHKrGO71c
	 vzKuBUG0z7YrR+kbS0U5O1pc5hYYkF/NF7xUQrCQZ6XxcJAa5T90viroEsV3qK33Zv
	 mBobUNLdtwQ1sgKRtitZ4y7fZDndP5YZQCjXhX3oC8Ki+j4WE060rH1mH7ieMSAx76
	 qwCzJL1XaLfCDHrm84sKd69nzKfNCyYIpLVmbnvvm0cYd0f6GKAhMFXyaIGNon8f2e
	 oxExcx1KU6O1Q==
Subject: Re: [PATCH v4 net 4/8] net: enetc: do not rely on mEMAC hardware
 frame padding
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 11:43:06 +0000
Message-ID: <179241018666.3135.5747152008992392327@kernel.org>
In-Reply-To: <20261015105536.1692348-5-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-5-vladimir.oltean@nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: enetc: under-reserved TX ring capacity for VLAN TSO packets
- [High] net/enetc: TX BD hardware limit violation from pad BD
- [Medium] The hardware LSO path, enetc_lso_hw_offload() ->
  enetc_lso_start()/enetc_lso_map_hdr(), gets no minimum-frame-length…
- [Medium] In enetc_start_xmit(), the new software-TSO admission check is
  enetc_bd_unused(tx_ring) < tso_count_descs(skb) + gso_segs, i.e.…
- [Medium] The new early return in enetc_start_xmit(), 'if
  (eth_skb_pad(skb)) return NETDEV_TX_OK;', leaks the…
- [Low] XDP transmit paths are not padded in this patch.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the software-
  TSO ring reservation in enetc_start_xmit() still does not count the…
- [High] This problem wasn't introduced by this patch, but the
  priv->tx_onestep_tstamp work item is never cancelled or flushed.

--

net: enetc: do not rely on mEMAC hardware frame padding

This patch stops relying on the mEMAC TXP hardware padding. Non-GSO skbs
are now padded with eth_skb_pad(). Software TSO segments shorter than
ETH_ZLEN get an extra BD pointing to a shared zeroed coherent buffer
(tx_pad), and the TSO ring reservation in enetc_start_xmit() grows by
gso_segs.

> To be defensive and not leak any sensitive information from the SoC,
> let's pad all frames to ETH_ZLEN in software, so that the MAC doesn't
> have to do anything.

[Severity: Low]
Is "all frames" accurate for this patch?

The XDP transmit paths are XDP_TX from enetc_clean_rx_ring_xdp() and
ndo_xdp_xmit via enetc_xdp_xmit(). Both end up in enetc_xdp_tx(), which
still queues frames at their raw length:

    int i, k, frm_len = tmp_tx_swbd->len;

ENETC_PM0_CMD_TXP is also still set in enetc_configure_port_mac(), so
short XDP frames still depend on the MAC padding.

A later patch in this series, "net: enetc: pad short XDP frames in
software", appears to fix this by appending a tx_pad BD in enetc_xdp_tx().
So for this patch it may only be a matter of the commit message wording.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e464eca482f78..707c17fe4a4c5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c

[ ... ]

> @@ -980,6 +1005,13 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  
>  		enetc_tso_complete_csum(tx_ring, &tso, skb, hdr, pos, csum);
>  
> +		if (pad_len) {
> +			enetc_bdr_idx_inc(tx_ring, &i);
> +			enetc_map_tx_pad(tx_ring, i, pad_len);
> +			tx_swbd = &tx_ring->tx_swbd[i];
> +			count++;
> +		}

[Severity: High]
Can a padded TSO segment exceed the hardware limit on chained BDs?

Per the comment in enetc.h, a frame can use at most 15 chained TX BDs,
including the head and extension BD. That is why ENETC_MAX_SKB_FRAGS
is 13. The data loop in enetc_map_tx_tso_buffs() enforces this with:

    if (unlikely(bd_data_num >= priv->max_frags && data_len))
        goto err_chained_bd;

So a segment whose data_len is used up by exactly max_frags data BDs
leaves the loop normally. If that segment is also shorter than
ETH_ZLEN, the pad BD is appended unconditionally.

With a VLAN tag, that gives one frame:

  - 1 header BD
  - 1 extension BD
  - 13 data BDs
  - 1 pad BD

That is 16 BDs, one over the limit.

Such a segment only needs a few payload bytes spread over many tiny
frags, plus a very small gso_size. A vnet_hdr packet socket or a VM
guest can construct that.

What does the LS1028A MAC do with a 16 BD chain? If it stalls or
raises a DMA error, should the bd_data_num limit leave room for the pad
BD when pad_len is non-zero? Segments that do not fit could then take
the err_chained_bd path.

[Severity: High]
This is a pre-existing issue, but can the ring overrun here for
VLAN-tagged TSO skbs?

When skb_vlan_tag_present() is true, enetc_map_tx_tso_hdr() emits an
extension BD for every segment:

    if (skb_vlan_tag_present(skb))
        flags |= ENETC_TXBD_FLAGS_EX;

Each segment can then use a header BD, an extension BD, its data BDs, and
now a pad BD. The worst case is 3 * gso_segs + nr_frags + P, where P is
the number of padded segments.

The reservation in enetc_start_xmit() is tso_count_descs(skb) + gso_segs,
which is 3 * gso_segs + nr_frags. Before this patch the extension BDs were
not counted at all. Now the extra gso_segs absorbs them, and the pad BDs
are left uncovered. So the "+gso_segs to cover one pad BD per segment"
comment does not hold for VLAN-tagged skbs.

For local TCP over an 8021q device, P is at most 1. That uses up the
one-slot gap and makes next_to_use equal to next_to_clean, so the ring
looks empty to software.

For DODGY TSO skbs with a tiny gso_size, P can approach gso_segs. These
can come from a bridged VM guest or a vnet_hdr packet socket, with the tag
kept as hwaccel.

Could enetc_map_tx_tso_buffs() then write past next_to_clean? That would
overwrite tx_swbd entries and BDs that are still in flight, and lose
their skb and DMA references.

> +
>  		if (total_len == 0)
>  			tx_swbd->skb = skb;
>  
> @@ -1032,7 +1064,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  
>  			count = enetc_lso_hw_offload(tx_ring, skb);

[Severity: Medium]
Does the hardware LSO path need the same minimum frame length handling?

The commit message says "user space may set gso_size to a very small
value", but only enetc_map_tx_tso_buffs() is changed. When ENETC_F_LSO is
active (ENETC v4), GSO skbs go to enetc_lso_hw_offload(), and
enetc_lso_start() takes the segment size straight from gso_size:

    lso->lso_seg_size = skb_shinfo(skb)->gso_size;

Two cases can produce short segments:

  - an unprivileged UDP_SEGMENT socket with a small gso_size
  - the last segment of a TCP TSO skb without timestamps (54 bytes of
    headers plus a few bytes of payload)

These segments would still reach the MAC below 60 bytes. On the same v4
device, non-GSO skbs are now padded with eth_skb_pad().

The code does not show whether the v4 MAC or LSO engine pads with the
same suspect bytes. enetc4_pf.c does not appear to set TXP explicitly.
If it does pad that way, is this fix incomplete for LSO?

If hardware-padded LSO segments are fine, could the commit message say
why?

>  		} else {
> -			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
> +			/* +gso_segs to cover one pad BD per segment */
> +			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb) +
> +			    skb_shinfo(skb)->gso_segs) {
>  				netif_stop_subqueue(ndev, tx_ring->index);
>  				return NETDEV_TX_BUSY;
>  			}

[Severity: High]
Does the new reservation still fall short for VLAN-tagged software TSO
skbs?

tso_count_descs() returns 2 * gso_segs + nr_frags. That covers one
header BD and one data BD per segment, plus one extra data BD per frag
boundary.

When skb_vlan_tag_present() is true, enetc_map_tx_tso_hdr() also emits
an extension BD for every segment:

    if (skb_vlan_tag_present(skb))
        flags |= ENETC_TXBD_FLAGS_EX;

enetc_map_tx_tso_buffs() can now add a pad BD per segment on top of
that. The worst case is then 4 * gso_segs + nr_frags (header,
extension, data and pad). enetc_start_xmit() only checks for
3 * gso_segs + nr_frags.

The extension BDs were already unaccounted for before this patch.
Still, the "+gso_segs to cover one pad BD per segment" comment only
holds when there is no VLAN tag.

With a tiny gso_size, nearly every segment needs both an extension BD
and a pad BD. Examples are a DODGY skb from a VM guest, or one from a
vnet_hdr packet socket, with the tag carried as hwaccel.

Suppose the ring is close to full when such a skb is admitted. Can
enetc_map_tx_tso_buffs() then advance past next_to_clean and overwrite
BDs and tx_swbd entries that hardware still owns? That would lose their
skb and DMA references, and could corrupt or hang TX.

Should the check add another gso_segs when skb_vlan_tag_present(skb)?
Or would it be better to count only the segments that actually need
padding?

[Severity: Medium]
Can this check still succeed for software TSO skbs with a large
gso_segs?

The reservation is now 3 * gso_segs + nr_frags. But
enetc_map_tx_tso_buffs() only emits a pad BD when hdr_len + data_len <
ETH_ZLEN, and with a normal TCP MSS that is at most the last segment.

ENETC_TX_RING_DEFAULT_SIZE is 2048, so enetc_bd_unused() is at most 2047.
The driver does not call netif_set_tso_max_segs() and has no
ndo_features_check. So a skb with gso_segs between roughly 677 and 1015
used to be admitted and now never is.

The queue is stopped and NETDEV_TX_BUSY is returned. enetc_clean_tx_ring()
only wakes the queue after frames complete:

    if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
                 __netif_subqueue_stopped(ndev, tx_ring->index) &&

Once the ring drains, the requeued skb fails the check again and nothing
restarts the queue. Would that TX queue stay stalled until the interface
is restarted?

Possible triggers:

  - a local socket with a small TCP_MAXSEG (e.g. 88)
  - a peer advertising a small MSS
  - DODGY TSO skbs from a VM guest with gso_size around 64-96

The same stall already existed for gso_segs above about 1015; this patch
lowers the threshold. Could the pad BDs be reserved only for segments
that need them, or could gso_max_segs be capped?

> @@ -1042,6 +1076,9 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  			enetc_unlock_mdio();
>  		}
>  	} else {
> +		if (eth_skb_pad(skb))
> +			return NETDEV_TX_OK;

[Severity: Medium]
Does this early return leak the ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS bit?

For skbs flagged ENETC_F_TX_ONESTEP_SYNC_TSTAMP, the bit is taken at the
top of enetc_start_xmit():

    if (test_and_set_bit_lock(ENETC_TX_ONESTEP_TSTAMP_IN_PROGRESS,
                              &priv->flags)) {
        skb_queue_tail(&priv->tx_skbs, skb);

The only release is in enetc_tx_onestep_tstamp(). That work is scheduled
from enetc_clean_tx_ring() only when a one-step skb completes TX.

An L2 one-step PTP Sync frame is 58 bytes, so it now always goes through
eth_skb_pad() -> skb_put_padto() -> skb_pad(). If the skb is cloned or
has no tailroom, pskb_expand_head(GFP_ATOMIC) can fail. The skb is then
freed and NETDEV_TX_OK is returned with no BD queued.

No completion will ever schedule the work. Wouldn't the bit stay set for
good, leaving every later one-step Sync skb on priv->tx_skbs?

The existing drop_packet_err and NETDEV_TX_BUSY exits seem to have the
same problem. The later pskb_may_pull() drop in this series adds another
instance.

> +
>  		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
>  			if (unlikely(skb_linearize(skb)))
>  				goto drop_packet_err;

[ ... ]

> @@ -2437,6 +2485,8 @@ static void enetc_assign_tx_resource(struct enetc_bdr *tx_ring,
>  	tx_ring->tx_swbd = res ? res->tx_swbd : NULL;
>  	tx_ring->tso_headers = res ? res->tso_headers : NULL;
>  	tx_ring->tso_headers_dma = res ? res->tso_headers_dma : 0;
> +	tx_ring->tx_pad = res ? res->tx_pad : NULL;
> +	tx_ring->tx_pad_dma = res ? res->tx_pad_dma : 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is the tx_onestep_tstamp
work cancelled before these resources go away?

enetc_clean_tx_ring() calls schedule_work(&priv->tx_onestep_tstamp) when
a one-step Sync skb completes. The driver has no cancel_work_sync() or
flush_work() for that work, and never purges priv->tx_skbs.

enetc_close() runs enetc_stop(), enetc_free_rxtx_rings() and
enetc_assign_tx_resources(priv, NULL). That NULLs tx_ring->bd_base and
tx_ring->tx_swbd and frees the resources. The work may run after that
with a skb queued on priv->tx_skbs:

enetc_tx_onestep_tstamp()
    skb = skb_dequeue(&priv->tx_skbs);
    if (skb)
        enetc_start_xmit(skb, priv->ndev);

enetc_start_xmit() has no ENETC_TX_DOWN check. Can enetc_map_tx_buffs()
then dereference a NULL or freed bd_base/tx_swbd?

On device removal, a work item that is still pending would also use priv
after free_netdev(), in container_of() and netif_tx_lock_bh(priv->ndev).
That happens even when tx_skbs is empty.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015105536.1692348-1-vladimir.oltean%40nxp.com
