Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1D23BF91;
	Sun, 11 Oct 2026 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702795; cv=none; b=a4PNFUe5oPGzFM9f64ahehUPzTdQd/S5eKX6GZnDsGjk4hWjp8cWCmyBSmESxw9px4DiKQgzdRUitSN+Hoq4RBfng6PutZoyVb9FGNTWUJDOn1c+Mvdtbfxr5sw6v1hrobSUR/eT72rtu7gSsR+u+5B96m86f7Pco7GsyuW85Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702795; c=relaxed/simple;
	bh=UNzFcPb9iLWtp+2/arO5644kd4QaDQJ80HY5ydr9uaU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdIZgGgzc9yVCv8PUCL5ntA/Ktkk0XozqmKRL7EJ38KOrmU7sW+U5qylA5eF1Y9pMStyBFWakf/IhtNPPHLr+WnYF8E5+iuWqHiecFJa7erH24Ja6YWRtZBpH411QS/O+2cGQ74nRSsY0o+oajvkv0f7d+70nwb7fgS90/Spbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNBvxFeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNBvxFeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41E81F0089B;
	Sun, 11 Oct 2026 07:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791702793;
	bh=lnGwD9fE2Mz8xFJXNMFKNTcck4mpALjdDYG863eHPdI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mNBvxFeFaQ4RhUJs3pOO9esgYpSRfnJA8rmK2arh9G/rUwy4ig//gn9maQac8bZ3N
	 kI4P1C6YUU/GKTPYharXt72o8oCbhfVrnPbdYvz4Nhgc0IXDe5uJTaAQGD0kgNU3JR
	 o+3Ow6fhxQSmE9TSIdes/QqpV3uCsvZqyXpY8QapuL8FfTpIxLAm6WilJlwMADOhwz
	 XvqDjdIKNQFrsr/kg/ajPKxMkJKmdmkqNvmUCKwpdL6U7tWS19PbWxQVXuoLk6JHr0
	 /y+SofWLS1I2UsQ77q2JprTYs7XayWd/CQTaYJdZ7TyCvIPsHqd0mIMeYMZJ0c9FnR
	 AUmmcyAu6V5aQ==
Subject: Re: [PATCH net] net: bgmac: clear TX slots when freeing the ring
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 nbd@openwrt.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 07:13:12 +0000
Message-ID: <179170279214.434549.15109616376617039657@kernel.org>
In-Reply-To: <20261010070418.84457-1-rosenp@gmail.com>
References: <20261010070418.84457-1-rosenp@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/bgmac: broken DMA mapping error cleanup in TX path
- [Medium] The patch says "Unmap before freeing", but
  bgmac_dma_tx_ring_free() only orders unmap before free within a single…

Pre-existing issues:
- [High] In bgmac_open()
  (drivers/net/ethernet/broadcom/bgmac.c:1177-1205), the hardware is…
- [Medium] The error paths of bgmac_dma_tx_add()
  (drivers/net/ethernet/broadcom/bgmac.c) leave slot->dma_addr non-zero,…
- [Medium] The err_dma unwind in bgmac_dma_tx_add()
  (drivers/net/ethernet/broadcom/bgmac.c:210-221) unmaps the wrong…

--

net: bgmac: clear TX slots when freeing the ring

This patch changes bgmac_dma_tx_ring_free() to unmap each TX slot before
freeing its skb. It picks dma_unmap_single() or dma_unmap_page() based on
the SOF flag in the descriptor, and then clears slot->skb and
slot->dma_addr. The aim is to stop stale slot->skb pointers from surviving
a down/up cycle and being freed a second time by bgmac_dma_tx_free().

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 3e9c57196a397..769d5d8e40bae 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -535,17 +535,19 @@ static void bgmac_dma_tx_ring_free(struct bgmac *bgmac,
>  		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
>  
>  		slot = &ring->slots[i];
> -		dev_kfree_skb(slot->skb);
>  
> -		if (!slot->dma_addr)
> -			continue;
> +		if (slot->dma_addr) {
> +			if (le32_to_cpu(dma_desc[i].ctl0) & BGMAC_DESC_CTL0_SOF)
> +				dma_unmap_single(dma_dev, slot->dma_addr,
> +						 len, DMA_TO_DEVICE);
> +			else
> +				dma_unmap_page(dma_dev, slot->dma_addr,
> +					       len, DMA_TO_DEVICE);
> +			slot->dma_addr = 0;
> +		}

[Severity: High]
This is a pre-existing issue, but the new teardown code depends on
slot->dma_addr being accurate, so it is worth raising here. What
happens to the ring when skb_frag_dma_map() fails in
bgmac_dma_tx_add()?

At that point slot points at the failing fragment's slot, and its
dma_addr is DMA_MAPPING_ERROR. The err_dma label then calls
dma_unmap_single() on that value with skb_headlen(skb) as the length.
The real head mapping is not released there.

The unwind loop computes its index as (ring->end + i), but fragment k
was placed at ring->end + 1 + k. When i > 0, the loop reaches the head
slot at i == 0 and releases it with dma_unmap_page(), although it was
mapped with dma_map_single(). Fragment i - 1 is never unmapped. When
fragment 0 fails, only the bogus dma_unmap_single() runs and the head
mapping leaks.

None of these slots get their dma_addr reset to 0. ring->end is not
advanced either, so bgmac_dma_tx_free() never looks at them. Suppose
bgmac_stop() or bgmac_enet_suspend() runs before the ring wraps over
these slots. Then bgmac_dma_cleanup() calls bgmac_dma_tx_ring_free(),
which finds a non-zero dma_addr in every one of them.

bgmac_dma_tx_add_buf() already wrote the head descriptor with SOF
set. The new check therefore calls dma_unmap_single() on a head that
err_dma already released as a page. The fragments that err_dma did
unmap are unmapped a second time with dma_unmap_page(). The failing
slot still holds DMA_MAPPING_ERROR, and its ctl0 and ctl1 belong to
whichever packet last used it. So that value goes to the DMA API with
a stale length and a stale single/page choice.

With swiotlb or an IOMMU, couldn't a double unmap release a bounce
buffer or IOVA that has since been given to another mapping? That
would corrupt memory or crash, not just trip CONFIG_DMA_API_DEBUG.

Should err_dma unmap ring->slots[ring->end % BGMAC_TX_RING_SLOTS] for
the head and walk the fragments at ring->end + 1 + i? Should it also
set dma_addr to 0 on every slot it touches, including the failing
one? Would you prefer to fold that into this fix or send it as a
separate patch?

[Severity: Medium]
This is a pre-existing issue and not something this patch introduced.
Can this check see stale handles left behind by the error paths in
bgmac_dma_tx_add()?

If the head mapping fails, the head slot keeps DMA_MAPPING_ERROR:

drivers/net/ethernet/broadcom/bgmac.c:bgmac_dma_tx_add() {
    ...
	slot->dma_addr = dma_map_single(dma_dev, skb->data, skb_headlen(skb),
					DMA_TO_DEVICE);
	if (unlikely(dma_mapping_error(dma_dev, slot->dma_addr)))
		goto err_dma_head;
    ...
}

If a fragment mapping fails, the failing slot also keeps
DMA_MAPPING_ERROR. Its descriptor still holds the ctl0/ctl1 of the packet
that last used that slot. The err_dma unwind unmaps the head and the
earlier fragments, but it never resets their slot->dma_addr to 0.

ring->end is not advanced in either case, so bgmac_dma_tx_free() never
visits these slots. Suppose bgmac_stop() or bgmac_enet_suspend() runs
before the ring wraps over them. Then the call chain
bgmac_dma_cleanup()->bgmac_dma_tx_ring_free() finds a non-zero dma_addr
and unmaps it again. The single/page choice comes from a stale SOF bit,
and the length comes from a stale ctl1.

Doesn't that mean addresses err_dma already released get unmapped twice,
or DMA_MAPPING_ERROR itself gets unmapped? With swiotlb or an IOMMU,
could that free a bounce slot or IOVA that now belongs to another
mapping? CONFIG_DMA_API_DEBUG should at least report it.

Would it make sense for the error paths in bgmac_dma_tx_add() to clear
slot->dma_addr?

The old code had the same if (!slot->dma_addr) check, so this patch does
not change the behaviour here.

>  
> -		if (slot->skb)
> -			dma_unmap_single(dma_dev, slot->dma_addr,
> -					 len, DMA_TO_DEVICE);
> -		else
> -			dma_unmap_page(dma_dev, slot->dma_addr,
> -				       len, DMA_TO_DEVICE);
> +		dev_kfree_skb(slot->skb);
> +		slot->skb = NULL;

[Severity: Medium]
The commit message says "Unmap before freeing". Does that still hold for
a scatter/gather packet that wraps past the end of the ring?

bgmac_dma_tx_add() places a packet's slots at consecutive indices modulo
BGMAC_TX_RING_SLOTS. It sets slot->skb only on the last of them:

	slot->skb = skb;

So one packet can have its head in slot 126, a fragment in slot 127 and
its last fragment in slot 0.

This loop runs i from 0 to 127. At i == 0 it unmaps the last fragment.
dev_kfree_skb() then frees skb->data and drops the fragment page
references through skb_release_data().

The head in slot 126 and the fragment in slot 127 are unmapped only
later, when the skb has already been freed.

Would two passes give the ordering the commit message describes? The
first pass would unmap every slot and the second would free the skbs.

>  	}
>  }

While looking at this, I noticed two more issues in the same file that
this patch does not touch.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Does
the err_dma unwind in bgmac_dma_tx_add() unmap the wrong addresses?

drivers/net/ethernet/broadcom/bgmac.c:bgmac_dma_tx_add() {
	int index = ring->end % BGMAC_TX_RING_SLOTS;
	struct bgmac_slot_info *slot = &ring->slots[index];
    ...
	for (i = 0; i < nr_frags; i++) {
		...
		index = (index + 1) % BGMAC_TX_RING_SLOTS;
		slot = &ring->slots[index];
		slot->dma_addr = skb_frag_dma_map(dma_dev, frag, 0,
						  len, DMA_TO_DEVICE);
		if (unlikely(dma_mapping_error(dma_dev, slot->dma_addr)))
			goto err_dma;
		...
	}
    ...
err_dma:
	dma_unmap_single(dma_dev, slot->dma_addr, skb_headlen(skb),
			 DMA_TO_DEVICE);

	while (i-- > 0) {
		int index = (ring->end + i) % BGMAC_TX_RING_SLOTS;
		...
		dma_unmap_page(dma_dev, slot->dma_addr, len, DMA_TO_DEVICE);
	}
    ...
}

By the time err_dma runs, slot points at the failing fragment's slot. The
dma_unmap_single() call therefore gets DMA_MAPPING_ERROR with the head's
length, not the head mapping.

Fragment k lives at index ring->end + 1 + k, but the loop uses
ring->end + i:

- If fragment 0 fails, the loop does not run and the head mapping leaks.
- If fragment i > 0 fails, the loop unmaps the head slot with
  dma_unmap_page(), although it was mapped with dma_map_single().
  Fragment i - 1 is never unmapped.

Should the head unmap use ring->slots[ring->end % BGMAC_TX_RING_SLOTS],
and should the loop index be ring->end + 1 + i?

[Severity: High]
This is a pre-existing issue and not something this patch introduced. Is
the request_irq() failure path in bgmac_open() safe while the hardware is
still running?

drivers/net/ethernet/broadcom/bgmac.c:bgmac_open() {
    ...
	err = bgmac_dma_init(bgmac);
	if (err)
		return err;

	/* Specs say about reclaiming rings here, but we do that in DMA init */
	bgmac_chip_init(bgmac);

	err = request_irq(bgmac->irq, bgmac_interrupt, IRQF_SHARED,
			  net_dev->name, net_dev);
	if (err < 0) {
		dev_err(bgmac->dev, "IRQ request error: %d!\n", err);
		bgmac_dma_cleanup(bgmac);
		return err;
	}
    ...
}

When request_irq() is called, the hardware is already armed:

- bgmac_dma_init() has enabled RX DMA and given every RX slot to the
  hardware through bgmac_dma_rx_update_index().
- bgmac_chip_init() has unmasked interrupts with bgmac_chip_intrs_on()
  and enabled the MAC with bgmac_enable().

If request_irq() fails, only bgmac_dma_cleanup() runs. Inside it,
bgmac_dma_rx_ring_free() unmaps each RX buffer and calls put_page() on
it. Nothing calls bgmac_chip_intrs_off() or bgmac_chip_reset() first.

Could the RX DMA engine, still enabled, then write incoming frames into
pages that have already gone back to the allocator? On ports attached to
a switch, where the link is always up, frames can arrive at any time.

The device would also keep raising interrupts on a shared line with no
handler registered. Could that make the kernel disable the IRQ?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010070418.84457-1-rosenp%40gmail.com
