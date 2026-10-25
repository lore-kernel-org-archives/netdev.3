Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941685;
	b=0tKcdcihHQYn9xoK09NzyqSfk6hpNskIWxNFpflh6E1WtV9I3cm9Cotjl5wPPTLIBwC5
	 JZVBXYYZEV0Rfo+KLdjSGNhQr8AXY7fvre+WMf0agjDxWgHsOyyhw58hhlwNv5xmAkVx4
	 RFbdeKX2aiUMssh8HkqDg2fddc2ktjCRdox8BI/LP+mAoT9N3KZtf/uMIkN5yGRZvvGz7
	 j4YWdFv5sBm0nmkUvZ+Xlli75K8FKRW4NDR3pGpwFpAjfTSH+GSeRhgkq2AdzKvoxB3zY
	 SyJ5V7WKeiHEe/W1KDs8YAEht40lrH37vfKQDcjZOi9jFKUkKMRUeJqdFp+H88Lh9gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941685;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QEJtrLOFg8lyk1USRkn9G7yenfXglsncYatbCQ2AUc4=;
	b=svOzGgV/9Wc/bZQnz41BII8oy+XIUZBE58BtAFtvWHf8y9kIZjUun5B5pFjzBWDNH8T+
	 N2uDwVp26QNYeS6ifqjIyzViWWym9cUuCbQdpNJFnxImNEDbLhWAuCxMPT6l1xeQXmTDr
	 eWfztEN6yR7F7/jFYMg5GQvu7uaVfFnF7kW2fDPlk0Wam6ncAQ0pC2FmKyQUELiBAu6Lu
	 x4sX10QG14VTkmVu4g1cHW2VRfeTMerwLyvSh4+OiU5rPL4zis+a5VfiB1MUaaPkkgzBO
	 PC+HhtXxf43SIPnD49x4bd+HQwCw4plhUdR0kWizKg3slLaA9vLMGTIdDh/BUcbgMWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilmH4SQC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDD606A31D;
	Sun, 25 Oct 2026 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilmH4SQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4581F031E4;
	Sun, 25 Oct 2026 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792941671;
	bh=QEJtrLOFg8lyk1USRkn9G7yenfXglsncYatbCQ2AUc4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ilmH4SQCF0Jqln6cyztBSvodpIBv72F5GI81+Z0TcANxQWb75v6pluXJZp2i9G0dH
	 LKn7sGj2XgXOexCEnI06hclDBRH9zYtkZkwmxEM+llGoSaaWb9eJ0iBh/PLM/i7CHo
	 rVVUbkzPx3cEkzLowv0FLmWbkBHFMFrrHF/nqH2qM7l8Z2xRB6+IG2vt2C+Hb0XqIo
	 i81bkiq2bll8ONDEgkpPtymbO3t9DHtwANzjZZDry1LmyNW7InSgjNH7OhwOGGmMZw
	 pIe7fjutgheo7y6BFVC9p+SaW3KyEcZdCzdgAwvUaOOHFsMomp0tC0fTRbYqf+yX/9
	 tLq1DV/ejesKw==
Subject: Re: [PATCH v5 net 4/4] net: enetc: pad short XDP frames in software
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, claudiu.manoil@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, ioana.ciornei@nxp.com, zefir.kurtisi@westermo.com,
 zefir.kurtisi@gmail.com, david.laight.linux@gmail.com, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 15:21:09 +0000
Message-ID: <179294166967.3134.4009428939172084398@kernel.org>
In-Reply-To: <20261021145314.1435049-5-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-5-vladimir.oltean@nxp.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new XDP pad BD in enetc_xdp_tx() is only partly initialized,
  so after a failed XDP reconfiguration it can inherit a stale…
- [Low] The commit message understates what the new 16-byte head-buffer
  check in enetc_xdp_tx() fixes.

Pre-existing issues:
- [High] Concurrent, unsynchronized producers on the same XDP TX ring.

--

net: enetc: pad short XDP frames in software

This patch makes enetc_xdp_tx() drop XDP frames whose head buffer is
shorter than 16 bytes. When a frame is shorter than ETH_ZLEN, it appends
a BD pointing to the shared tx_pad zero buffer. The pad BD then takes
over the F flag, the is_eof marker and the xdp_frame pointer from the
last data BD.

> Similar to the skb path, the XDP transmit path may put frames shorter
> than ETH_ZLEN in the TX ring, and may put frames whose first buffer is
> shorter than 16 bytes. The former relies on mEMAC hardware padding,
> which we no longer want to rely upon, and the latter is not supported
> by ENETC at all.

[Severity: Low]
Could the commit message say what happens without the 16-byte check?

Before this patch, enetc_xdp_tx() only checked enetc_bd_unused(). A head
BD shorter than 16 bytes went straight into the TX ring.

The earlier patch in this series, "net: enetc: ensure head buffer has at
least 16 octets", describes the result. TBaCIR does not advance,
TBaSR[BUSY] stays set, and the NAPI/TBaIER re-enable sequence turns this
into an MSI-X IRQ storm that soft-locks the host.

That looks reachable today through ndo_xdp_xmit(). For example, a veth
XDP program redirecting through a devmap can forward a 14 or 15 byte
frame. The frame can come from bpf_xdp_adjust_tail(), or the peer can
simply send one.

The Fixes tags are already there. What seems to be missing is a
description of the impact, a soft lockup on the XDP redirect path.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index f5a47d53d2bea..e3a08a82dc3c9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c

[ ... ]

> @@ -1771,15 +1774,24 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
>  		frm_len += tmp_tx_swbd->len;
>  	}
>  
> +	/* Pad frames below ETH_ZLEN so the mEMAC does not pad them. */
> +	pad_len = max_t(int, ETH_ZLEN - frm_len, 0);
> +
> +	if (unlikely(enetc_bd_unused(tx_ring) <
> +		     ENETC_TXBDS_NEEDED(num_tx_swbd + !!pad_len)))
> +		return false;
> +
>  	i = tx_ring->next_to_use;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can
two producers write to the same XDP TX ring at the same time?

enetc_xdp_xmit() picks the ring by the executing CPU:

	tx_ring = priv->xdp_tx_ring[smp_processor_id()];

The XDP_TX path in enetc_clean_rx_ring_xdp() picks it by RX ring index:

	tx_ring = priv->xdp_tx_ring[rx_ring->index];

The only thing tying a vector to a CPU is irq_set_affinity_hint() in
enetc_setup_irqs(). irqbalance, /proc/irq/*/smp_affinity or threaded
NAPI can run RX vector i's NAPI on CPU j. Meanwhile CPU i can call
ndo_xdp_xmit() into this device, for example from a devmap redirect.

enetc_lock_mdio() takes read_lock(&enetc_mdio_lock), and only when the
ERR050089 workaround is active. That does not serialize the two paths.

Both producers can then:

- pass the enetc_bd_unused() check;
- read the same next_to_use;
- overwrite the same swbds and BDs, now including the pad BD and the
  xdp_frame handoff;
- write next_to_use and the tail.

Could that lose frames or leak DMA mappings and xdp_frames? It could
also leave xdp_tx_in_flight undecremented for overwritten XDP_TX
buffers, which throttles RX refill, or hand torn BDs to the hardware.

Would per-ring producer serialization be needed here? That could be a
spinlock taken by both paths, or __netif_tx_lock() as other drivers use
for shared XDP queues.

>  
>  	for (k = 0; k < num_tx_swbd; k++) {
>  		struct enetc_tx_swbd *xdp_tx_swbd = &xdp_tx_arr[k];

[ ... ]

> @@ -1788,6 +1800,22 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
>  		enetc_bdr_idx_inc(tx_ring, &i);
>  	}
>  
> +	/* The pad BD becomes the last one, so it takes over the xdp_frame
> +	 * (if any) from the last data BD. The pad BD has no DMA mapping of
> +	 * its own, and it is not an XDP_TX buffer to be recycled.
> +	 */
> +	if (unlikely(pad_len)) {
> +		struct enetc_tx_swbd *pad_swbd = &tx_ring->tx_swbd[i];
> +
> +		enetc_append_tx_pad(tx_ring, i, pad_len);
> +		pad_swbd->is_xdp_redirect = last_swbd->is_xdp_redirect;
> +		pad_swbd->xdp_frame = last_swbd->xdp_frame;

[Severity: High]
Can pad_swbd keep a stale is_xdp_tx and page from an earlier use of
this slot?

enetc_append_tx_pad() sets only len, is_eof, do_twostep_tstamp and
check_wb. The code here adds is_xdp_redirect and xdp_frame. Nothing
writes is_xdp_tx, page, page_offset, dir, dma or is_dma_page.

The data BDs are fine, because enetc_xdp_map_tx_buff() memcpy()s the
whole swbd. That makes the pad BD the first XDP ring slot that depends
on already being zero.

The slot is not always zero. On an XDP program change,
enetc_reconfigure() calls enetc_stop() and then enetc_free_rxtx_rings().
For XDP_TX slots that were not cleaned,
enetc_free_tx_ring()->enetc_free_tx_frame() only does this:

	if (tx_swbd->dma)
		enetc_unmap_tx_buff(tx_ring, tx_swbd);

That clears dma but leaves is_xdp_tx = 1 and page set.

netif_set_real_num_tx_queues() can then fail in
enetc_reconfigure_xdp_cb(), for example with -ENOMEM when an XDP program
is removed. In that case the out_restart path restarts the old rings
with the same tx_swbd arrays:

out_restart:
	enetc_setup_bdrs(priv, extended);
	enetc_start(priv->ndev);

The old XDP program is restored, so XDP_TX keeps running. Every 56 byte
VLAN-stripped XDP_TX frame now gets a pad BD. If a pad BD lands on a
stale slot, enetc_clean_tx_ring() checks is_xdp_tx before dma:

		if (tx_swbd->is_xdp_tx)
			enetc_recycle_xdp_tx_buff(tx_ring, tx_swbd);

Would that put {dma = 0, stale page, stale page_offset} into the RX
ring? It would also call dma_sync_single_range_for_device() on address 0
and wrongly decrement xdp_tx_in_flight.

enetc_refill_rx_ring() would then program rxbd->w.addr with
0 + page_offset, so RX DMA would go to a bus address near 0. If the RX
ring is full, dma_unmap_page() would run on address 0 instead.

The incomplete scrubbing on the out_restart path is older than this
patch. The new pad BD is what exposes it on XDP rings.

Would a memset of the swbd in enetc_append_tx_pad() be enough? A more
robust option would be for enetc_free_tx_frame()/enetc_free_tx_ring() to
scrub the whole swbd, so slots are zero after teardown as well.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021145314.1435049-1-vladimir.oltean%40nxp.com
