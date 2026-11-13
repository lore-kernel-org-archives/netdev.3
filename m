Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602530;
	b=oHjlqaBR4Ib1qs9scRf/vI1QuSsCTS7ZWUiAlSJRfYX24jf95zYATABWTbDe/1j2003+
	 EFRZfQye8o6MUW9brt7bM7TNINckV838RBkIWj21bAxcUjEhbAwkXFY5pmI7VB5zu0Och
	 S2ike3D91xPhS+MJBf0+mhQAB29UA6vvOTvsxMRFKurWvpvUER1SzIZJT5JBp9ur0PhIr
	 Ij2T0yuchq2NOeMnpVVKPp60zA0b2E+7WpKICShSaXdE6giZ9J7c1kUcOUD77/S4FCthA
	 RH9QHw+eOIqZuwdbyt2hjbNYNu3GPSKqrOHHVKqokQycKCClti/Ds/cZjimcfH3N7/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602530;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8G3hnlHk6VC2wTViDZLxE+VNr7eD89vT49GcW2PzJA0=;
	b=q6so/HNoi6nAEvhEVN9QzOt1EJG3iMpSzRC7hgncK1ubR8Me50Uk6foTV/l6V9ANGKV7
	 v1SarxWihn8xjGjwcmC7CNw/V3M6v5Tx4XMzpUo9DhZ+MVRijfI/hdvnUz5Ns+9zzxae6
	 dify4nAhaXdZglBdnCsdAnGhTwKH+a1sednRaSG9VInpxS+Dx2bYVz/fOhBtWgSbX7em+
	 kCnCcO3kYCmIEXoRj2GEtPKdckXgcuL+WGPiWutlTXdQzHmSbkfJ6tfQx7BqD1oqu2s4L
	 VNrlGVdX3ZjpHSSLy3+OSJUqLsh6Uz0IF3p+rlxqRxE+aShgxMcbgyaJVG9JMzdr+3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PRTf/NKc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C53606A330;
	Fri, 13 Nov 2026 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRTf/NKc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BF01F000C6;
	Fri, 13 Nov 2026 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602530;
	bh=8G3hnlHk6VC2wTViDZLxE+VNr7eD89vT49GcW2PzJA0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PRTf/NKce2rgcBSIBz7ZMMu4UK8VEOkk7nSfrZc0AK4vmYwGDu0GrLbbYlwZPIIoy
	 vvvFYf5plttYdqOpVQk1iS3CxdMud+xJY3snZB+HzHHwOgC/PyvOawrExZObCpxCFk
	 D/EBzoHtZT9Hq+puXzaYUZRce1UEwP1p02QAVJMppS/MQXml7J6XfYIaks06k+Ck5U
	 JUWtN+Ash2xXQ7uA/R9uaOoaZL33XXldFaPpKU4k4SxVyuA747G2kUUuBpwJ3hIExE
	 tOBSCEaak+dmCrr84zHK7yLH0HJ4VTU6gk2U03YztgSj1ja/ZKfmFMvCbesvesvi+D
	 SsiaP0DfHiNpw==
Subject: Re: [PATCH net v2 3/6] net: bcm4908_enet: release the TX ring on stop
From: netdev-bot+sashiko@kernel.org
To: kudzo51@gmail.com
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com,
 florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 20:42:08 +0000
Message-ID: <179460252891.2199510.811569497068459485@kernel.org>
In-Reply-To: <20261112195051.597102-4-kudzo51@gmail.com>
References: <20261112195051.597102-4-kudzo51@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Double free and double DMA unmap of TX skbs, introduced by the
  new bcm4908_enet_tx_ring_clean().
- [Medium] bcm4908_enet_stop() now frees in-flight TX buffers even when
  the TX DMA channel was never confirmed stopped.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is High
  severity and it stops the patch's new cleanup from ever running in…

--

net: bcm4908_enet: release the TX ring on stop

This patch makes bcm4908_enet_stop() wait for the TX DMA channel to stop,
then unmap and free the skbs still left between read_idx and write_idx. It
also clears the TX descriptors when the ring is initialised, and drops the
OWN check in bcm4908_enet_start_xmit().

> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index b1738d954b91a..a28adef03e0e3 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c

[ ... ]

> @@ -365,7 +370,22 @@ static void bcm4908_enet_dma_tx_ring_enable(struct bcm4908_enet *enet,
>  static void bcm4908_enet_dma_tx_ring_disable(struct bcm4908_enet *enet,
>  					     struct bcm4908_enet_dma_ring *ring)
>  {
> +	unsigned long deadline;
> +	u32 tmp;
> +
>  	enet_write(enet, ring->cfg_block + ENET_DMA_CH_CFG, 0);
> +
> +	/* Wait for the channel to stop, as for RX, before freeing buffers */
> +	deadline = jiffies + usecs_to_jiffies(2000);
> +	do {
> +		tmp = enet_read(enet, ring->cfg_block + ENET_DMA_CH_CFG);
> +		if (!(tmp & ENET_DMA_CH_CFG_ENABLE))
> +			return;
> +		enet_write(enet, ring->cfg_block + ENET_DMA_CH_CFG, 0);
> +		usleep_range(10, 30);
> +	} while (!time_after_eq(jiffies, deadline));
> +
> +	dev_warn(enet->dev, "Timeout waiting for DMA TX stop\n");
>  }

[Severity: Medium]
When this poll times out, the helper only warns and returns void.
bcm4908_enet_stop() then calls bcm4908_enet_tx_ring_clean() anyway, which
unmaps and frees the skbs behind descriptors that may still have
DMA_CTL_STATUS_OWN set.

After stop, ENET_DMA_CTRL_CFG_MASTER_EN and the UMAC CMD_TX_EN bit also stay
set. The channel reset and the descriptor clear only happen in the next
open().

If the TX engine has not really stopped, can it keep fetching those buffers
and send the contents of freed, possibly reused, pages onto the wire? Before
this patch those skbs were leaked, so they were never freed while the DMA
could still reach them. I could not confirm from the code whether this
engine keeps fetching after ENABLE is cleared.

The commit message says the wait is there so the skbs are freed only after
the channel has stopped, but on the timeout path they are freed anyway.

Also, at HZ=100 or HZ=250, usecs_to_jiffies(2000) rounds up to one jiffy. If
a tick lands during the first usleep_range(10, 30), the loop gives up after
roughly 10-30us. Is the 2ms timeout actually honoured here?

Could the helper report the timeout, so that stop() can force a channel
reset through ENET_DMA_CTRL_CHANNEL_RESET (or clear MASTER_EN and confirm
the stop), or else leak the buffers deliberately instead of freeing them?

[ ... ]

> @@ -496,6 +516,21 @@ static int bcm4908_enet_open(struct net_device *netdev)
>  	return 0;
>  }
>  
> +static void bcm4908_enet_tx_ring_clean(struct bcm4908_enet *enet)
> +{
> +	struct bcm4908_enet_dma_ring *tx_ring = &enet->tx_ring;
> +	struct device *dev = enet->dev;
> +	int i;
> +
> +	for (i = tx_ring->read_idx; i != tx_ring->write_idx;
> +	     i = i == tx_ring->length - 1 ? 0 : i + 1) {
> +		struct bcm4908_enet_dma_ring_slot *slot = &tx_ring->slots[i];
> +
> +		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
> +		dev_kfree_skb_any(slot->skb);
> +	}
> +}

[Severity: High]
This frees every skb in slots[read_idx..write_idx) but leaves read_idx,
write_idx and slot->skb as they were. Emptying the ring is left to
bcm4908_enet_dma_ring_init() in the next open. Is that call always reached?

bcm4908_enet_dma_init() fills the RX ring first and returns early if that
fails:

	for (i = 0; i < rx_ring->length; i++) {
		err = bcm4908_enet_dma_alloc_rx_buf(enet, i);
		if (err) {
			dev_err(dev, "Failed to alloc RX buffer: %d\n", err);
			bcm4908_enet_dma_uninit(enet);
			return err;
		}
	}

	bcm4908_enet_dma_ring_init(enet, &enet->tx_ring);

bcm4908_enet_open() ignores that return value and returns 0:

	bcm4908_enet_dma_reset(enet);
	bcm4908_enet_dma_init(enet);

Suppose napi_alloc_frag() or dma_map_single() fails in
bcm4908_enet_dma_alloc_rx_buf() during ifup. The interface then comes up
with the old TX read_idx/write_idx range. Those slots still point at skbs
that were already freed, and the new TX descriptor memset did not run
either.

On the next ifdown, won't bcm4908_enet_tx_ring_clean() walk the same range
and call dma_unmap_single() and dev_kfree_skb_any() on the same skbs a
second time?

bcm4908_enet_poll_tx() can also free them again before that, for any stale
descriptor in the range with OWN clear:

		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
		dev_kfree_skb(slot->skb);

The ignored return value in open() predates this patch. However, before this
patch those skbs were leaked rather than freed, so the stale pointers were
still valid.

Would it be safer to make the ring empty inside
bcm4908_enet_tx_ring_clean() itself, for example by resetting read_idx and
write_idx and/or setting slot->skb to NULL?

>  static int bcm4908_enet_stop(struct net_device *netdev)
>  {
>  	struct bcm4908_enet *enet = netdev_priv(netdev);
> @@ -511,6 +546,7 @@ static int bcm4908_enet_stop(struct net_device *netdev)
>  	bcm4908_enet_dma_rx_ring_disable(enet, &enet->rx_ring);
>  	bcm4908_enet_dma_tx_ring_disable(enet, &enet->tx_ring);
>  
> +	bcm4908_enet_tx_ring_clean(enet);
>  	bcm4908_enet_dma_uninit(enet);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It does
mean the new cleanup is never reached when the device tree has no "tx"
interrupt.

The brcm,bcm4908-enet binding allows a single interrupt (interrupt-names has
minItems: 1). Probe accepts a negative value from
platform_get_irq_byname(pdev, "tx"). In that case bcm4908_enet_open() only
enables the TX NAPI conditionally:

	if (enet->irq_tx > 0) {
		napi_enable(&tx_ring->napi);

but bcm4908_enet_stop() disables it unconditionally, before the
bcm4908_enet_tx_ring_clean() call above:

	napi_disable(&rx_ring->napi);
	napi_disable(&tx_ring->napi);

A TX NAPI that was never enabled still has NAPI_STATE_SCHED and
NAPI_STATE_NPSVC set from netif_napi_add, and only napi_enable() clears
them. So napi_disable_locked() sits in:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

Does ndo_stop then hang forever with rtnl and the netdev lock held?

The same mode has a second problem. In bcm4908_enet_start_xmit(),
napi_schedule(&enet->tx_ring.napi) does nothing, because napi_schedule_prep()
sees SCHED already set, so bcm4908_enet_poll_tx() never runs. Doesn't the
TX ring then fill until netif_txq_maybe_stop() stops the queue, with nothing
left to wake it?

The conditional napi_enable() and the unconditional napi_disable() appear
to come from commit 12bb508bfe5a ("net: broadcom: bcm4908_enet: support TX
interrupt").

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112195051.597102-1-kudzo51%40gmail.com
