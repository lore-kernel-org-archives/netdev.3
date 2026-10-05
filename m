Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CE4BFE96;
	Mon,  5 Oct 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212690; cv=none; b=rpEeTe4oS4B3869AaSbrGIQiV076y8mwkoEu94JyoizcPxVjulN9V/4TPcsjEF8fitxFrTSeqynhSAtrNRy+OMrE8qlDbTBPd7Gfjqk6IQLiXrPM4sqKcf2BBPF+X8cD3/dhbqfVWw44lP2/xIO8IO9985yORKrH6EBN/4oOfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212690; c=relaxed/simple;
	bh=bB1FCwxSyQ2svC837xOt7t0MX53GmhZTv2P0WMLoGIE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmVwMzjc0ZMgiUCWc+m+TKThjcg1NRlmr9ujFFpc0B6NtC0YoX7ydUS90L/i2/HQx2vb/t7AvL6INRhZ/IqZLv40fXYyIrm1VW/+xqYtB27YqGMHk0TkwmowGuCq9E8Eqof26xqDc2/FufaKBRNdUrf6JcaVaHT9fYSH0dQxYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5sB8Oof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5sB8Oof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD85B1F000FF;
	Mon,  5 Oct 2026 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212688;
	bh=iTM2d/jcUXJ/OfzHUTGhHAj9OdYm72IOCLZds75CGdI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S5sB8OofpkqV79Qt8Cm2MFadCy3taUlAgfJLYx40++VW4X68UFoYjUAdSmUXI3A4E
	 7kkSDUtayeqSjTyO1pv48VZD4BG9lQPZ9ghE78R6jkPagIsJsbspyjux6g9Wt0/AjK
	 WcuzMu6u1iinN0JfsztjSmai+voDY4/UgYwq1ar6Ad/FBcUQs3Am0ZIPK/xQJ5RWYx
	 9u8wCArdzDk8EwTD3X9X437a1eaW6pv8IMahUxc78gQyv2ei0Kq+PZ1AX8jVkaPnk+
	 c+vImTyilrt86m+0rJHqi36Yp7mAx1sWOt7hrLx4HRAcrmI4iGRvLkIy+TnJW+GxTH
	 IkO68dbGmio7Q==
Subject: Re: [PATCH net-next 7/7] net: bcmgenet: reassemble jumbo frames from
 status block fragments
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Mon, 05 Oct 2026 15:04:47 +0000
Message-ID: <179121268743.434549.11864751276782263505@kernel.org>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-7-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-7-96dc6d54cbee@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcmgenet: skb_trim() panics on non-linear jumbo frame SKBs
- [Medium] This patch adds a TX checksum fallback in bcmgenet_xmit().
- [Medium] The patch raises dev->max_mtu from the old ENET_MAX_MTU (3564
  on 4K pages, 3820 otherwise) to ENET_MAX_JUMBO_MTU = GENMASK(13,0) -…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  bcmgenet_timeout() updates ring->stats64 without holding ring->lock.

--

net: bcmgenet: reassemble jumbo frames from status block fragments

This commit strips the per-descriptor status blocks from RX frames longer
than the packet ready threshold and reassembles them into one skb. It also
adds a software checksum fallback in bcmgenet_xmit() for CHECKSUM_PARTIAL
frames longer than tx_thld_len, and raises max_mtu to ENET_MAX_JUMBO_MTU
(16347).

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 0cd56ec1c5ccf..62edbe51fe076 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2176,6 +2173,19 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto out;
>  	}
>  
> +	/* The MAC holds a frame to insert its checksum, but only as much as
> +	 * its FIFO takes. Longer frames are dropped silently.
> +	 */
> +	if (unlikely(skb->len > priv->tx_thld_len) &&
> +	    skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (skb_checksum_help(skb)) {
> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			dev_kfree_skb_any(skb);
> +			ret = NETDEV_TX_OK;
> +			goto out;
> +		}
> +	}
> +

[Severity: Medium]
The new comment says the MAC silently drops CHECKSUM_PARTIAL frames longer
than tx_thld_len. Can that already happen before this patch?

An earlier patch in this series, "net: bcmgenet: pad transmit frames out
of the packet ready window", added bcmgenet_tx_pkt_rdy_thld():

	while (thld > ENET_THLD_DEFAULT &&
	       ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN > thld * ENET_THLD_UNIT &&
	       thld * ENET_THLD_UNIT + ENET_TX_SAFE_MARGIN > mtu + ETH_HLEN)
		thld -= ENET_THLD_BURST / ENET_THLD_UNIT;

On 16K and 64K page kernels ENET_THLD_MAX_LEN is 3840, which makes the old
ENET_MAX_MTU 3820. For MTUs from 3809 to 3820:

    mtu + 32 > 3840
    3840 + 64 > mtu + 14

So the loop lowers the threshold to 0xe0 and tx_thld_len becomes 3584.
Untagged frames can still be up to mtu + 14 bytes long.

In that earlier commit, CHECKSUM_PARTIAL frames longer than 3584 bytes go
out with DMA_TX_DO_CSUM and have no software fallback. Going by the comment
above, the MAC loses them.

Could this fallback move into, or ahead of, the patch that first lets
tx_thld_len drop below the largest frame? Bisects and backports that stop
at that patch would then not see silent TX loss on large-page kernels.

The commit message only mentions the fallback in passing:

    The MAC only checksums a frame it holds in full, so anything longer than
    the threshold falls back to software.

Could it also say that this fixes TX for the earlier patch?

>  	/* Keep the frame out of the window just past the threshold */
>  	if (unlikely(skb->len > priv->tx_thld_len &&
>  		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {

[ ... ]

> @@ -4272,7 +4358,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  	/* v1 cannot program the thresholds, so it stays at the default MTU */
>  	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
>  	if (!GENET_IS_V1(priv))
> -		dev->max_mtu = ENET_MAX_MTU;
> +		dev->max_mtu = ENET_MAX_JUMBO_MTU;

[Severity: Medium]
Now that max_mtu is 16347, can the TX side describe frames this large?
This patch leaves bcmgenet_xmit() unchanged. It still puts each skb head or
frag in one descriptor and shifts the size in without a mask:

	len_stat = (size << DMA_BUFLENGTH_SHIFT) |
		   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);

The header defines that field as 12 bits:

/* Tx/Rx Dma Descriptor common bits*/
#define DMA_BUFLENGTH_MASK		0x0fff
#define DMA_BUFLENGTH_SHIFT		16

Buffers over 4095 bytes are common at jumbo MTUs. Near MTU 9000, a UDP or
ICMP datagram gets a single linear head from __ip_append_data(). A frag
from an order-3 page_frag page in TCP or soft-GSO can be almost as large as
the MSS.

For a 9014 byte head the field would hold 822, and the upper bits would
spill above the field.

If the hardware field really is 12 bits, would these frames go out
truncated or corrupt while BQL and bytes_sent count the full length?

I couldn't confirm the real field width from the tree. The RX path reads
the length as dma_length_status >> DMA_BUFLENGTH_SHIFT without a mask. The
Tested-by may also have covered jumbo TX.

If the field is 12 bits, should max_mtu be capped at the TX descriptor
limit, or should large TX buffers be split across descriptors?

>  	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
bcmgenet_timeout() updates the TX ring stats without holding ring->lock:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_timeout() {
    ...
	bcmgenet_tx_reclaim(dev, ring, true);

	/* Re-enable the TX interrupt for this ring */
	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);

	txq_trans_cond_update(txq);

	BCMGENET_STATS64_INC((&ring->stats64), errors);
    ...
}

bcmgenet_tx_reclaim() takes ring->lock and releases it again, so the
increment runs without the lock. Meanwhile, on another CPU,
bcmgenet_tx_poll()->__bcmgenet_tx_reclaim() holds ring->lock and writes the
same syncp:

	u64_stats_update_begin(&stats->syncp);
	u64_stats_add(&stats->packets, pkts_compl);
	u64_stats_add(&stats->bytes, bytes_compl);
	u64_stats_update_end(&stats->syncp);

dev_watchdog() holds the TX queue locks. Those only exclude ndo_start_xmit,
not TX NAPI. Also, the interrupt is unmasked just before the increment, so
a pending TX-done interrupt can schedule TX NAPI at that moment.

On 32-bit SMP, can the two writers overlap and lose a seqcount increment?
That would leave the sequence odd. Readers in bcmgenet_get_stats64() and
bcmgenet_get_ethtool_stats() would then spin forever in
u64_stats_fetch_begin(). A shorter overlap could give them torn counters.

Should the increment in bcmgenet_timeout() be done while holding
ring->lock?

[ ... ]

> @@ -2475,6 +2552,13 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  		skb_reserve(skb, GENET_RSB_PAD);
>  		__skb_put(skb, len - GENET_RSB_PAD);
>  
> +		if (unlikely(!(dma_flag & DMA_EOP))) {
> +			ring->frag_head = skb;
> +			goto next;
> +		}
> +
> +deliver:
> +
>  		if (priv->crc_fwd_en) {
>  			skb_trim(skb, skb->len - ETH_FCS_LEN);
>  		}

[Severity: High]
When priv->crc_fwd_en is set, a reassembled jumbo frame now reaches the
skb_trim() just below the new deliver label. Can skb_trim() handle that
skb?

Before this patch only linear skbs from napi_build_skb() got here, so
skb_trim() was fine. bcmgenet_add_frag() now attaches every non-SOP
descriptor with skb_add_rx_frag(). That makes the skb returned on EOP
non-linear. skb_trim() calls __skb_trim(), which starts with:

	if (WARN_ON(skb_is_nonlinear(skb)))
		return;

With CRC forwarding on, every jumbo frame would then:

  - trigger a WARN, once per received frame, which a remote sender can
    drive as fast as it likes. With panic_on_warn that is a remote
    crash.
  - keep its 4 FCS bytes in the payload handed to napi_gro_receive().
  - have those 4 bytes counted in stats->bytes.

The FCS may also span two frags. min_len for a non-SOP descriptor is
only sizeof(struct status_64), so the last descriptor can carry fewer
than ETH_FCS_LEN bytes past its status block. Any trim therefore has to
be able to reach back into the previous frag.

Should this use pskb_trim(), which walks the frags, with its return
value checked? Since ip_summed is still CHECKSUM_NONE at that point,
there is no csum to adjust.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee%40tipi-net.de
