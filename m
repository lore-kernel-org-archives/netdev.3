Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941667;
	b=aVQCo7R6hvHep3+kB8FHDlRcnmy1yqPKATVlMPmJxH7cYQrUwTt9IRxzgIjxHZ1s4wLD
	 MMasjDbgmz00ap1U4U+7zqcPpXLT1x4ER3cBI/qdXp5xUugL5c82/OusStcNOT63dK8ub
	 lT1xPUfXmp8cxvYZMUimuvDbf0/t9ZQ0xayaGMXnd57r9Tcg0wmTxqSs1qyhSxXEpIxvR
	 q8a1PNMJtOJvN4tBWM9+V9tSU6rWHe74ylJimkYB3DWG3LtBBm1IDH12n4Q6IU9VYEDP4
	 gsq88LoHuk/Lz/oREvArgZK6GINcMrkRPNto8nWMTXtbq9RHRqSytwMqVYyYSsTLSBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941667;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6y15YznhDxcZTrtrKKtB+LdYBgrQlEuNtSxEVoQpc9E=;
	b=hmUeJImS8mA3VVgrAkIcZSitr4mRAfWLikDBoKJoqiTO2X3+v+qAzy75iUffKidcGG8N
	 ewjyC4uJXr/4xJWZe7L/1C5SArwpCHhuJhiwIrq6cfmZW6lOR5ohNNEniHY9SEERBZToa
	 +rxiqUGka0qXq0Bfnfkmq3Gn2dHGUqhSF2S4OKcutee8/F/P33HCFVkiJcuXmSZWmcDEH
	 YgnrFSLPX3tYyr4zkv6752zMLawgVxOFChPlbZQ2JqjXntjEtqOAhkNex9Ig8/eCM/ZAK
	 fqVf/DxElIE64tONvWMeSqAu9LeF3MLWnQ019bjqapO7rkxluPQvqcM7JMwvqg+ZosA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFuFvAd1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D331F606A31A;
	Sun, 25 Oct 2026 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFuFvAd1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DB81F031E3;
	Sun, 25 Oct 2026 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792941666;
	bh=6y15YznhDxcZTrtrKKtB+LdYBgrQlEuNtSxEVoQpc9E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jFuFvAd1evS69wCmC85jrvFRPXmKAhl3Gz/smDC8tkOXdbSWz+eL6iDDSAuUguD5l
	 SIrgxpGfqCfk8kvPNyYG5CWEHzI/c39A22Y6EQZVfQGDKQDD669JRNnkd004f0TiL/
	 4XO8IheatwqZRTnEonYDJIREdDpL2YY7jryZsS2y8FZqKhdfez/APS+AzTBOBON747
	 D463TMQVmSaxH97sztHYfwcnVv7g7ASx+wdOnpHMKuuyg4udhAVxroyaQjjtFwaxuH
	 7QPsOmbx8Wuczkce3CVilJ9CTc3dQsSk0rAZsb1AmSaSAs/gnRo+TEj471KdT8gKjP
	 Ukk99Cpy1I9lg==
Subject: Re: [PATCH v5 net 1/4] net: enetc: reserve VLAN extension BDs for
 software TSO
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 15:21:05 +0000
Message-ID: <179294166520.3134.18097439321876673016@kernel.org>
In-Reply-To: <20261021145314.1435049-2-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-2-vladimir.oltean@nxp.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix stops the ring overrun, but VLAN-tagged TSO skbs that
  can never fit now stall the TX queue for good.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the BUSY path
  the patch changes can lose a wakeup.
- [High] This problem wasn't introduced by this patch, but
  enetc_map_tx_tso_buffs() copies the whole L2+L3+L4 header into a fixed…

--

net: enetc: reserve VLAN extension BDs for software TSO

This commit adds enetc_tso_count_descs(). It extends tso_count_descs()
with one extension BD per segment when the skb carries a VLAN tag.
enetc_start_xmit() now uses it for the free BD check on the software TSO
path.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 80f0082f6c633..ab4bfefda6c8f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -688,6 +688,17 @@ static int enetc_lso_count_descs(const struct sk_buff *skb)
>  	return skb_shinfo(skb)->nr_frags + 4;
>  }
>  
> +static int enetc_tso_count_descs(const struct sk_buff *skb)
> +{
> +	int count = tso_count_descs(skb);
> +
> +	/* Each segment also needs an extension BD for VLAN insertion */
> +	if (skb_vlan_tag_present(skb))
> +		count += skb_shinfo(skb)->gso_segs;

[Severity: High]

Can this estimate exceed what the TX ring can ever provide? If so, the
queue would stop permanently instead of overrunning.

For a VLAN skb this returns 3 * gso_segs + nr_frags. The TX ring is
fixed at ENETC_TX_RING_DEFAULT_SIZE (2048) and there is no
set_ringparam. So enetc_bd_unused() returns at most 2047, even on an
empty ring.

The driver does not limit the segment count anywhere. There is no
netif_set_tso_max_segs(), no gso_max_segs and no ndo_features_check.

Take a 64KB TSO skb with an MSS of about 96 or less (gso_segs of roughly
683 or more). enetc_start_xmit() takes this path on every attempt:

	if (enetc_bd_unused(tx_ring) < enetc_tso_count_descs(skb)) {
		netif_stop_subqueue(ndev, tx_ring->index);
		return NETDEV_TX_BUSY;
	}

The qdisc requeues the same skb. The only runtime wake is in
enetc_clean_tx_ring():

	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
		     ...
		netif_wake_subqueue(ndev, tx_ring->index);

Once the ring drains, tx_frm_cnt stays 0. There is also no
ndo_tx_timeout, so nothing restarts the queue.

This can be triggered by a TCP sender on a VLAN on top of enetc using
the software TSO path. A remote peer can force a small MSS through its
SYN (down to tcp_min_snd_mss), and a local user can use TCP_MAXSEG.

Before this patch, most of these skbs overran the ring. Now they hang
the queue instead.

The same stall already existed for non-VLAN skbs above about 1016
segments. This change moves VLAN skbs with about 683 to 1015 segments
into it.

The estimate is a worst case, so some VLAN skbs that really fit are also
rejected forever. For example, gso_segs=680 with 17 segment-aligned
frags needs 2040 BDs, but the estimate is 2057.

The padding patch in this series ("net: enetc: do not rely on mEMAC
hardware frame padding") adds another gso_segs to the estimate. That
lowers the threshold to about 508 segments with VLAN and about 677
without.

Would it make sense to cap the segment count to what the ring can hold?
For example:

	netif_set_tso_max_segs(ndev, (bd_count - 1 - MAX_SKB_FRAGS) /
			       per_seg_bds);

Another option is an ndo_features_check that clears GSO when the count
exceeds bd_count - 1, so the core falls back to software GSO.

> +
> +	return count;
> +}
> +

[ ... ]

> @@ -1032,7 +1043,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  
>  			count = enetc_lso_hw_offload(tx_ring, skb);
>  		} else {
> -			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
> +			if (enetc_bd_unused(tx_ring) < enetc_tso_count_descs(skb)) {
>  				netif_stop_subqueue(ndev, tx_ring->index);
>  				return NETDEV_TX_BUSY;
>  			}

[Severity: High]

This is a pre-existing issue, not one introduced by this patch. Can
this stop path lose a wakeup?

enetc_bd_unused() reads tx_ring->next_to_clean without a lock. The
queue is then stopped with no smp_mb() and no re-check of free space.

On another CPU, enetc_clean_tx_ring() updates next_to_clean. It wakes
the queue only if it already sees the queue stopped and tx_frm_cnt is
non-zero:

CPU0 (enetc_start_xmit)              CPU1 (enetc_clean_tx_ring)
enetc_bd_unused() reads stale
next_to_clean, not enough room
                                     cleans the last in-flight frames
                                     tx_ring->next_to_clean = i;
                                     __netif_subqueue_stopped() is false,
                                     no wake
netif_stop_subqueue()
return NETDEV_TX_BUSY

At that point the ring has plenty of room, but no BDs are in flight. No
completion will call netif_wake_subqueue().

The only other wake is netif_tx_start_all_queues() on open, and there
is no ndo_tx_timeout.

The same pattern is present at the LSO, non-GSO and post-xmit stop
sites. This patch raises the BD requirement for VLAN TSO skbs, so this
path now runs more often, including when only a few short frames are in
flight.

Would netif_txq_maybe_stop() / netif_txq_completed_wake() fit here?
Alternatively, an smp_mb() plus a re-check after stopping could be
paired with an smp_mb() in the cleaner before it tests the stopped bit.

[Severity: High]

This isn't a bug introduced by this patch, but it is in the same
software TSO path. Can enetc_map_tx_tso_buffs() write past its
tx_ring->tso_headers slot when the headers are longer than
TSO_HEADER_SIZE?

	hdr = tx_ring->tso_headers + i * TSO_HEADER_SIZE;
	tso_build_hdr(skb, hdr, &tso, data_len, total_len == 0);

tso_build_hdr() copies hdr_len bytes, where hdr_len comes from
tso_start() and covers the full L2+L3+L4 header. Nothing compares it
against TSO_HEADER_SIZE (256).

enetc_lso_map_hdr() does the same:

	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
	memcpy(hdr, skb->data, lso->hdr_len);

enetc_alloc_tx_resource() allocates exactly bd_count * TSO_HEADER_SIZE
bytes for this buffer. An oversized header therefore spills into the
next slot. For the last ring index, it writes past the end of the
dma_alloc_coherent() allocation.

One possible trigger is an IPv6 TCP socket with a sticky IPV6_RTHDR
type-4 SRH, which doesn't need CAP_NET_RAW. With 11 or more segments,
the header is 14 + 40 + 184 + 32 = 270 bytes.

The IPv6 setsockopt and net/core/tso.c side hasn't been fully traced in
this tree, so the trigger may still need confirming.

Should skbs with hdr_len > TSO_HEADER_SIZE fall back to software
segmentation or be dropped? Clearing GSO for them in ndo_features_check
would be another option.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021145314.1435049-1-vladimir.oltean%40nxp.com
