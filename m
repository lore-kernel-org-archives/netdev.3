Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B342FCD6;
	Wed, 19 Aug 2026 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137761; cv=none; b=oQFrpbcl495TXkMa5u7jyF0v4WetF41+dn9PDATmiuK521NMiK3I+2kZ0XQMYn4GMSH/CvxBxq05pI8bqYykXr5vzGLXTkUyUEZq8Uvpy5zxdZeFxebe9irst/onl0mQCv7tp4Sjqe1f2FXd0ZP3VQgWELTaOgjWv/fdfbvjJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137761; c=relaxed/simple;
	bh=hPBH3W3KoBEnMgTFKAYo1qLw0t5qIJBH6DviNDWaL3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVyAP08jowawXmhFOyU2q8NvaER0kGKIR8znQMpsq2wpEuO5WMYqkpRtFEn4T99Z/m0Hehumrc7Zc2AzrmeYCt0qpRx/LIIEbc8V0kzJwUcDvrbJynQP4JdwYoyjeRNy+ic2eluItgnwP65IqpdubcfDdYxujN4HpqaEjPiwa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuojYXPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuojYXPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9D51F000E9;
	Wed, 19 Aug 2026 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787137760;
	bh=pmE8GPCqNsnjhk+At/f3E7+hmVHddwGxaecN7UUeU0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TuojYXPi4VpLoDohE5ThJMxFMY/NCKVxM8L/SOKp7kDgxeFEB9K0e1NrsnrQsUj1D
	 hOPlGejEfpmvqiP7GvyNCqJawwFGCW6LRtPT+fD/eypUK6TKJQlZ2z6ssdAKitEsOc
	 Riu51KJbXml5+GObopIonwuIet84fzUQkuwvOKBsYCRgxgvb2WQtqg4Y0CDVYeyjwR
	 gneT49QvatGy2JVWvReCRQ2gjU7QLVcDoJI/iUQlZpKV39XwtOxG9ZBNJmacjWi7EJ
	 4VRu8QakaKL2ADbFBPI/NrgyuqS2yOhmYMuqhoGxqQ/bkmCwI8QHFxZJ6sQWiluPXt
	 um9+uUdgvVH2Q==
Date: Wed, 19 Aug 2026 12:09:16 +0100
From: Simon Horman <horms@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v9 2/4] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <20260819110916.GQ265046@horms.kernel.org>
References: <20260814111317.1741087-1-dong100@mucse.com>
 <20260814111317.1741087-3-dong100@mucse.com>
 <20260818110320.GB265046@horms.kernel.org>
 <5DC7ADB456BE9777+20260819084904.GB2730731@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DC7ADB456BE9777+20260819084904.GB2730731@nic-Precision-5820-Tower>

On Wed, Aug 19, 2026 at 04:49:04PM +0800, Yibo Dong wrote:

...

> > > @@ -633,13 +758,144 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
> > > +static void rnpgbe_stop_tx_ring(struct mucse_ring *tx_ring)
> > > +{
> > > +	if (!tx_ring->tx_buffer_info)
> > > +		return;
> > > +
> > > +	/* Stop hw. No new descriptors are fetched after TX_START=0.
> > > +	 * DMA for descriptors fetched before the stop may still be in flight.
> > > +	 */
> > > +	mucse_ring_wr32(tx_ring, RNPGBE_TX_START, 0);
> > > +	/* Flush posted write to ensure hardware sees TX_START=0 */
> > > +	(void)mucse_ring_rd32(tx_ring, RNPGBE_TX_START);
> > > +}
> > > +
> > > +static void rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
> > > +{
> > > +	struct mucse_hw *hw = &mucse->hw;
> > > +	u32 dma_status;
> > > +	int err;
> > > +
> > > +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> > > +				 dma_status,
> > > +				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
> > > +				 RNPGBE_DMA_TX_STATUS,
> > > +				 10, 100000);
> > > +	if (err)
> > > +		dev_warn(&mucse->pdev->dev,
> > > +			 "Timed out waiting for TX DMA to quiesce, status %#x\n",
> > > +			 dma_status);
> > > +}
> > 
> > [Severity: Medium]
> > [Finding: gpt-5-6-sol-4-6]
> > [Sources: gpt-5-6-sol, opus-5]
> > Should the timeout here be propagated to the callers?
> > 
> > rnpgbe_wait_tx_dma_idle() returns void, so a timeout is only logged and
> > both callers continue as if the engine had confirmed idle. On the ifdown
> > side that means rnpgbe_clean_all_tx_rings() clears TX_AXI_RW_EN and then
> > rnpgbe_clean_tx_ring() calls dma_unmap_single()/dma_unmap_page() on every
> > in-flight TX buffer, and rnpgbe_close() -> rnpgbe_free_all_tx_resources()
> > -> rnpgbe_free_tx_resources() then dma_free_coherent()s the descriptor
> > ring.
> > 
> > The comment in rnpgbe_stop_tx_ring() states that DMA for descriptors
> > fetched before the stop may still be in flight, which is what this poll
> > is guarding. If the poll times out, can the device still be reading the
> > mapped buffers or writing back into the descriptor ring after they are
> > released?
> > 
> > The same unchecked wait sits at the head of rnpgbe_configure_tx(), where
> > RNPGBE_TX_BASE_ADDR_LO/HI, RNPGBE_TX_LEN and TAIL are reprogrammed and
> > TX_START is set to 1 again. Is a device reset or an error return needed
> > when the engine never reports idle?
> > 
> After TX_START has been cleared for all TX rings, normal outstanding
> DMA transactions reach idle well within 100 ms. If DMA_STATUS still does
> not report idle after that timeout, the hardware has entered an
> unrecoverable AXI fault state. In this state, the EP will not issue any
> further DMA accesses to RC memory, so teardown can safely release the DMA
> mappings. Recovery requires a chip-level reset.
> I will make the helper return an error. On this error, the driver will
> report it with dev_err() and will not enable or reprogram TX DMA again;
> the configuration/open path will fail instead. Does this approach sound
> reasonable?

Yes, sounds good.
Thanks.
