Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506937B3FD;
	Wed, 14 Oct 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956669; cv=none; b=AxMWuD5XcwApJe+D7p9wMZMBkxN4aSGQM04+Wv0BQQbpgJsw15dmHyC3Gua/pPiqzMHyXTDvvLLJPW4RSnEmGkb8d+qGSE+cTGniqwXin7kqV3sCcUMcgCtFnFUhaQ8rtcSv3jseHuD2DXsevWg1T5L7h/BUBOMWAEuF4pkHL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956669; c=relaxed/simple;
	bh=AOLN0C1lnGz3wq93VNwDotFT2hHNUCaYMDcnLHjRJyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh4PkALZmNZ6kQGbrehETppExJFmPVqpstRh2uxZfPjQcAn2sGj7eaV5FKavoIKKbPC+b5v2Q277qhBFIeIdGivXa9PTQ8x8dbU1isb+t9hIF5lHg2TxqgyNJRLgfbIPde+Fssq7zyBP768PQ/vKE1SDQSTpGyf62l+2Y6UVuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1791956570t469323e1
X-QQ-Originating-IP: m9biVWujPvIHl2V6lW7er95XtOlN4lU2/Fzi4PB8lJE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 Oct 2026 13:42:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10976670358034929060
EX-QQ-RecipientCnt: 11
Date: Wed, 14 Oct 2026 13:42:48 +0800
From: Yibo Dong <dong100@mucse.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v16 2/5] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <60B3E0AFB70A94BD+20261014054248.GA138773@nic-Precision-5820-Tower>
References: <70FB65125730E856+20261013023036.63653-1-dong100@mucse.com>
 <179194675382.434549.14371017120705089466@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179194675382.434549.14371017120705089466@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OQNQM5UP8StMB4ATRvE9kBJRtZx6/aloNyukL4c25ED+ChRc+u+j74sx
	ugCl0+cvwqW7HFabrOxi4ZH8JPcv6xPCPtUKun0lyvVieICZv/8OGlxRbSWwNekxoe2Ov1D
	YS043Lqis99fBQbac2No6o5oKBbLHSjq2+i0LTOBUOSPjFo62N4FUmcqm69ZWS52xVykxG6
	xOkdLNdLeWLSutbpjz3bH69T5AxYrhHIDRdewErIXMHnpsFan1JymNHS4g1I75hPHsZfxwV
	rDfibSlrGAefIbUYKqLSEwLn08anyOxbhQ8CUKqxgS0xaEhPMsQSJVzdV2CusLs/pBhWpWB
	0THgBSCt2O8kzds8Fj65UhgmkXxO3BdK5DZxQBsVNXT7mvoAEQEpRyTAKMYdg5JOzL0ZDXo
	vIVK09cqFfvfJAa2svcZA4iawv09uQGccvH1P8sK75hNJMdb4k0QnHG0BSiE+GRuf5zr42q
	oMV0KsfwWs5T7QKTAkCEycIK3uN94mSNg7NmWicYpoYUdX4+YJrvJzYMjx9w7Ghg9xWtFce
	++TUjmmeCCywnHuJDZ8Itn1OPK3yPx/JRta2KFfmDzVSH9WelzyPaClxMAtJgdHmOAjGVFj
	DPMaK4vWZkJUjasUA58916mpccLlDO7TFea70Av/qwPejK+naJNaGcE0zhnksO13xOB5c2B
	uyBTM+z/WBOFbAE5iJhe8iiGwLUth2IVe9GVCOLLS8yNCY5aCGK934ZHwF74R0o1NJ1srdB
	37HiZ2d+vzJjmOUyqSjaHPE1f0vTsLo8MQO8V6uIkZ4e2dh0WkSZbHw2cPLs1Bx+vAtDXzx
	toytJYRfkUHIrtJlq8fm3itW/KFVO3Uox5MgzchjD/2iTehUrF7jHySuQnmEK9eqfdXVqtT
	4jZbv07Hkd/NSRbLXLoSfaDXDqrMRngfwSlShKmkrqf2iSZyIJpgGmSJKPwe5CZ8WpvgULj
	3+fbN8ioSMCGYhuPxHPoreHQly5p77X8K39VFj9KFcmCgQDhEN5rHC4qtKlPI2YrttL3S4y
	4p/2Gy3wAPju3mXiuKtyxdEZSQsvTxU550IydLLFI26INXRsfhxM0ND8JpjeU=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Wed, Oct 14, 2026 at 02:59:13AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [ ... ]
> 
> > @@ -556,12 +680,173 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
> >  		napi_disable(&mucse->q_vector[i]->napi);
> >  }
> >  
> 
> [ ... ]
> 
> > +static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
> > +{
> > +	struct mucse_hw *hw = &mucse->hw;
> > +	u32 dma_status;
> > +	int err;
> > +
> > +	/* A timeout indicates a terminal AXI fault. Hardware stops all PCIe
> > +	 * DMA requests in this state, including requests accepted before the
> > +	 * fault. Teardown may therefore release mappings and descriptor memory.
> > +	 * Recovery requires a chip-level reset.
> > +	 */
> > +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> > +				 dma_status,
> > +				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
> > +				 RNPGBE_DMA_TX_STATUS,
> > +				 10, 100000);
> > +	if (err) {
> > +		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
> > +		dev_err(&mucse->pdev->dev,
> > +			"TX DMA failed to quiesce, status %#x\n", dma_status);
> > +	}
> > +
> > +	return err;
> > +}
> 
> [ ... ]
> 
> > +	if (mucse->num_tx_queues &&
> > +	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> > +		err = rnpgbe_wait_tx_dma_idle(mucse);
> > +
> > +	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> > +	dma_axi_ctl &= ~TX_AXI_RW_EN;
> > +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
> > +	/* Flush the posted write before continuing. */
> > +	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> 
> [ ... ]
> 
> > +void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
> > +{
> > +	/* rnpgbe_stop_all_tx_rings() logs and latches any AXI fault. Hardware
> > +	 * stops DMA requests in this state, so cleanup intentionally ignores
> > +	 * an error and releases the mappings and descriptor memory.
> > +	 */
> > +	rnpgbe_stop_all_tx_rings(mucse);
> > +
> > +	for (int i = 0; i < mucse->num_tx_queues; i++)
> > +		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
> > +}
> 
> [Severity: Medium]
> After rnpgbe_wait_tx_dma_idle() times out, what guarantees that the
> device has actually stopped DMA?
> 
> On a timeout the driver only sets __MUCSE_AXI_FAULT and clears the
> internal TX_AXI_RW_EN gate in rnpgbe_stop_all_tx_rings().
> rnpgbe_clean_all_tx_rings() then ignores the error. It unmaps the TX
> buffers, frees the skbs and memsets the descriptor ring.
> 
> After that, rnpgbe_close() or the err_free_tx path in rnpgbe_open()
> continues with:
> 
> rnpgbe_free_all_tx_resources()
>   rnpgbe_free_tx_resources()
>     dma_free_coherent(tx_ring->dev, tx_ring->size, tx_ring->desc,
>                       tx_ring->dma);
> 
> The only reason this would be safe is the hardware claim in the comment
> and the commit message, that the hardware "stops all PCIe DMA requests in
> this state". Nothing on the host side enforces that:
> 
> - rnpgbe_probe() calls pci_set_master(), but the driver never calls
>   pci_clear_master() and never resets the function.
> - TX_BASE_ADDR_HI/LO keep pointing at the freed ring. Once the bit is
>   set, rnpgbe_open() returns -EIO, so nothing reprograms them.
> - Bus Master Enable is only cleared by pci_disable_device() in
>   rnpgbe_remove() or rnpgbe_dev_shutdown(), long after the memory was
>   freed.
> 
> The timeout also only means the done bits weren't seen within 100ms. A
> slow drain looks the same as a real fault.
> 
> If the device does write DD status back late, or reads a buffer after
> the unmap, wouldn't that land in freed and possibly reused memory?
> 
> Would it be safer to call pci_clear_master() (or reset the function) on
> the fault path before releasing DMA memory, or to leak the ring and
> buffers in this case instead of freeing them?
> 
> The later patch "net: rnpgbe: Add basic RX data path support" in this
> series uses the same approach for RX.
This is illegitimate.
Once START=0 has taken effect, hardware does not initiate any new
PCIe memory read or write requests, including for prefetched descriptors.
The 100 ms wait only covers transactions already in flight.
For this chip, failure to reach the done state within that window
indicates a terminal AXI fault, not a recoverable slow drain. As
documented in the code comments, this fault prevents further host-memory
accesses, including from previously accepted requests, and requires a
chip-level reset. Cleanup therefore relies on this hardware guarantee.
The same to RX.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/3B42BE25B3696EAE%2B20261013022920.63529-1-dong100%40mucse.com
> 
