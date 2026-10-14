Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325373AFCFD;
	Wed, 14 Oct 2026 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946756; cv=none; b=cZEW33NdMpmusHrleV2vNV7YrU95gj1BcMgc6dm8uWlLgvW0PJABN5tLjCW97uTdboHvxKN9LAdLo+vqR/QfqtGOh4hF7CG123WxuUEHmo7fHq+W02szNhQXzd4xW+7KcmuOHbxM1VnIMeo2lC6cOsUZu8tXRK7IY1YZ2qIqYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946756; c=relaxed/simple;
	bh=+wFd+Ll5DPSmJXgV7PdtifAWOs9HRuyjV3N+zuHHUdU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nkih1b49KisYimbQAGYw1dcSc1cV9+HMrERon7XilUTYNnSk+1UNzLEKi2UGR7uylSN58U5wJQtoT4sCRhkNjk5QBwQbcNCR+ireRTZS88xD4rrqZTiTeWxmq76S7+w1He0TO1CXL4JxWlyu0y66FNGqMLwMG4sCr0QnpCOBUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6P8ridb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6P8ridb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437621F00898;
	Wed, 14 Oct 2026 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791946754;
	bh=9VEWDYkMZJLhr/TizH/Ylk9Am0WmD+er6tJDyuILS4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z6P8ridb/OqDHWvxDlBrZOaK0uXO/VFbSNbyOZendlxcjzgQWgV6XRdSOChB2rk4c
	 bDbXLrrykeHx8EODYFPLG2uFRBReuqGfp1YhlEC+QwDs9Azighe+uDb6kg6uZs9RxN
	 T/H0YaVrCN1e1p/41GHuy8Iw8G2Fkcpp9rPd6fUhHNuZhTLgr0ZRMQNcZi4Ty117Ce
	 mG8XR0z9VTSXZ8xOhyPKrQWonOaMd/6cymuzP/VSuzHQGWpiz6zH26hXjH2Q+I2907
	 mGdAgYuA09LFWwQ3/J3HCUI7ayO2knx+SM/bB4umo6bhVcTFtY5g52mtyI4msMEOIT
	 eyzKIRWFGBVYQ==
Subject: Re: [PATCH net-next v16 2/5] net: rnpgbe: Add basic TX packet
 transmission support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Wed, 14 Oct 2026 02:59:13 +0000
Message-ID: <179194675382.434549.14371017120705089466@kernel.org>
In-Reply-To: <70FB65125730E856+20261013023036.63653-1-dong100@mucse.com>
References: <70FB65125730E856+20261013023036.63653-1-dong100@mucse.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When rnpgbe_wait_tx_dma_idle() times out, the driver only
  latches __MUCSE_AXI_FAULT and logs an error.
- [Low] The commit message does not cover everything the patch changes.
- [Low] In rnpgbe_clean_tx_irq() the comment says it clears next_to_watch
  "to prevent false hangs", but the driver has no TX hang detection.

--

net: rnpgbe: Add basic TX packet transmission support

This commit adds the basic TX path for the rnpgbe driver. It covers TX
descriptor and buffer management, rnpgbe_xmit_frame_ring(), TX ring
setup and teardown, and NAPI TX completion in rnpgbe_clean_tx_irq(). It
also sets a 56-bit DMA mask, reports TX statistics through
ndo_get_stats64(), and treats a TX DMA idle timeout as a terminal fault.

> Introduce the TX descriptor structure and buffer management, the
> rnpgbe_xmit_frame_ring() transmit function, TX ring allocation and
> teardown, and TX completion handling in rnpgbe_clean_tx_irq(). Track TX
> packet and byte statistics, and report dropped and tx_dropped counts
> through ndo_get_stats64().

[ ... ]

> Configure streaming and coherent DMA masks for the hardware's 56-bit
> DMA addressing capability. Add cycles_per_us to struct mucse_hw to scale
> the TX interrupt timer, and enable NETIF_F_HIGHDMA when the DMA mask
> allows it.

[Severity: Low]
Is "report dropped and tx_dropped counts" accurate?

rnpgbe_get_stats64() fills only stats->tx_packets, stats->tx_bytes and
stats->tx_dropped. The per-queue dropped counter is added into tx_dropped
and is not reported on its own.

The message mentions NETIF_F_HIGHDMA, but not the NETIF_F_SG change right
next to it. rnpgbe_add_adapter() now sets NETIF_F_SG in both
netdev->features and netdev->hw_features, so non-linear skbs will go
through the frag-mapping loop in rnpgbe_tx_map().

The patch also adds BQL accounting, which the message doesn't mention:
netdev_tx_sent_queue() in rnpgbe_tx_map(), __netif_txq_completed_wake()
in rnpgbe_clean_tx_irq(), and netdev_tx_reset_queue() in
rnpgbe_clean_tx_ring().

Could the commit message describe the SG and BQL changes too?

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index 81c3ec63a9a0c..21cd578f75323 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -65,26 +67,143 @@ static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
>  	}
>  }
>  
> +/**
> + * rnpgbe_clean_tx_irq - Reclaim resources after transmit completes

[ ... ]

> +		/* if eop DD is not set pending work has not been completed */
> +		if (!(eop_desc->vlan_cmd & cpu_to_le32(M_TXD_STAT_DD)))
> +			break;
> +		/* clear next_to_watch to prevent false hangs */
> +		tx_buffer->next_to_watch = NULL;

[Severity: Low]
This isn't a bug, but is the "prevent false hangs" comment accurate for
this driver?

rnpgbe_netdev_ops has no ndo_tx_timeout, and nothing in the driver checks
next_to_watch for hangs. Here next_to_watch only marks a pending packet
for rnpgbe_clean_tx_irq() and rnpgbe_clean_tx_ring(). The comment seems
to have been carried over from ixgbe.

[ ... ]

> @@ -556,12 +680,173 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
>  		napi_disable(&mucse->q_vector[i]->napi);
>  }
>  

[ ... ]

> +static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_status;
> +	int err;
> +
> +	/* A timeout indicates a terminal AXI fault. Hardware stops all PCIe
> +	 * DMA requests in this state, including requests accepted before the
> +	 * fault. Teardown may therefore release mappings and descriptor memory.
> +	 * Recovery requires a chip-level reset.
> +	 */
> +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> +				 dma_status,
> +				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
> +				 RNPGBE_DMA_TX_STATUS,
> +				 10, 100000);
> +	if (err) {
> +		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
> +		dev_err(&mucse->pdev->dev,
> +			"TX DMA failed to quiesce, status %#x\n", dma_status);
> +	}
> +
> +	return err;
> +}

[ ... ]

> +	if (mucse->num_tx_queues &&
> +	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> +		err = rnpgbe_wait_tx_dma_idle(mucse);
> +
> +	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +	dma_axi_ctl &= ~TX_AXI_RW_EN;
> +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
> +	/* Flush the posted write before continuing. */
> +	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);

[ ... ]

> +void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
> +{
> +	/* rnpgbe_stop_all_tx_rings() logs and latches any AXI fault. Hardware
> +	 * stops DMA requests in this state, so cleanup intentionally ignores
> +	 * an error and releases the mappings and descriptor memory.
> +	 */
> +	rnpgbe_stop_all_tx_rings(mucse);
> +
> +	for (int i = 0; i < mucse->num_tx_queues; i++)
> +		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
> +}

[Severity: Medium]
After rnpgbe_wait_tx_dma_idle() times out, what guarantees that the
device has actually stopped DMA?

On a timeout the driver only sets __MUCSE_AXI_FAULT and clears the
internal TX_AXI_RW_EN gate in rnpgbe_stop_all_tx_rings().
rnpgbe_clean_all_tx_rings() then ignores the error. It unmaps the TX
buffers, frees the skbs and memsets the descriptor ring.

After that, rnpgbe_close() or the err_free_tx path in rnpgbe_open()
continues with:

rnpgbe_free_all_tx_resources()
  rnpgbe_free_tx_resources()
    dma_free_coherent(tx_ring->dev, tx_ring->size, tx_ring->desc,
                      tx_ring->dma);

The only reason this would be safe is the hardware claim in the comment
and the commit message, that the hardware "stops all PCIe DMA requests in
this state". Nothing on the host side enforces that:

- rnpgbe_probe() calls pci_set_master(), but the driver never calls
  pci_clear_master() and never resets the function.
- TX_BASE_ADDR_HI/LO keep pointing at the freed ring. Once the bit is
  set, rnpgbe_open() returns -EIO, so nothing reprograms them.
- Bus Master Enable is only cleared by pci_disable_device() in
  rnpgbe_remove() or rnpgbe_dev_shutdown(), long after the memory was
  freed.

The timeout also only means the done bits weren't seen within 100ms. A
slow drain looks the same as a real fault.

If the device does write DD status back late, or reads a buffer after
the unmap, wouldn't that land in freed and possibly reused memory?

Would it be safer to call pci_clear_master() (or reset the function) on
the fault path before releasing DMA memory, or to leak the ring and
buffers in this case instead of freeing them?

The later patch "net: rnpgbe: Add basic RX data path support" in this
series uses the same approach for RX.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/3B42BE25B3696EAE%2B20261013022920.63529-1-dong100%40mucse.com
