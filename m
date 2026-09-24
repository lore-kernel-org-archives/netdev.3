Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0A4AE118;
	Thu, 24 Sep 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269666; cv=none; b=X50TI3rojIsj72whneXpqE4rZqdTnd1DRp2DiWmYzPFGhFCaFK6khRdq1k9BOzOSozMQ384KupxlAblfxUNcthT7+y5LRqGv3WtqVCjTl9FiV5NbOG+KvN1/N5LSs7qNJd0h1MryqvlYqxzY49c2xOzRNroykL9cjpAbm3Pj1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269666; c=relaxed/simple;
	bh=vOq3xe4MG1BKcoVZ3OcuQIYEvHWE0uiP8NMf4rtLrkk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAHEjfF0DoaHRW0lvQcOjj4fyVIxZRHu3yzfvvSb9O7hT1XkqhHqBppju02gopn/JxQ+DSmqFN8cJMinj4lr78GmY4p4LCEEADDQzqGUqWG+mximB8Py+SwqC1Hi0sBKOpST+m8/ErWlGrKCtOFN71sguOA7VMRD6+h1jHHmZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc3QNZor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc3QNZor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E6F1F00893;
	Thu, 24 Sep 2026 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269665;
	bh=IV6B/wUnI1gyMzArud/n/k1lcIgRff+c6noLd0k+RNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hc3QNZorh5eWjtRmKSpvtxiK0EnjYQvYLPXkjrAHai0L8o8reoZJQK34ppr1oB8ya
	 XTyA05wBtBJ0MuFH3FRy2IaIhl+rWQXeVt4UKUvr2g7zGBvppwtvNuQaB0h9oCcQNf
	 xM6aii7piHLzSxArBX/LAw1iAgJtbYq/u1281CUeeL71CdEUeFjN1fh3VwaJAmsxZw
	 GarQUzTFYelmV3BwKeMq4RASXg8wQnxj/GyAuEuyGeJg4uY0qZRdRGuTvPU9xYg3Ub
	 xs3wuMsDcUMeQfiqehoU4EB0KjAWhDYV/CBvbJJnqfuY58HBiZhGRw/gCEJMe5/MN0
	 CrCM0Co6X4qkQ==
Subject: Re: [PATCH net 12/12] net: systemport: Complete resource teardown
 even on DMA disable timeout
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:44 +0000
Message-ID: <179026966403.2160803.13897466632342473108@kernel.org>
In-Reply-To: <20260921231305.394773-13-florian.fainelli@broadcom.com>
References: <20260921231305.394773-13-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcm_sysport_stop() now unmaps and frees the RX/TX DMA buffers
  even when the DMA engines are known to be still running.
- [Medium] The unconditional teardown path now reaches
  clk_disable_unprepare(priv->clk)…

Pre-existing issues:
- [Medium] The same early-return-on-DMA-disable-timeout pattern remains
  in bcm_sysport_suspend(): 'ret = rdma_enable_set(priv, 0); if (ret) {…

--

net: systemport: Complete resource teardown even on DMA disable timeout

bcm_sysport_stop() used to return early when tdma_enable_set() or
rdma_enable_set() timed out, which left the rings, interrupts, PHY and
clock in place because ndo_stop() return values are ignored. The patch
turns both early returns into plain error prints so the rest of the
teardown always runs.

A few questions on the new flow.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index e5bb7fa84fda5..2b064da4eb7c0 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2088,19 +2088,15 @@ static int bcm_sysport_stop(struct net_device *dev)
>  	umac_enable_set(priv, CMD_RX_EN, 0);
>  
>  	ret = tdma_enable_set(priv, 0);
> -	if (ret) {
> +	if (ret)
>  		netdev_err(dev, "timeout disabling TDMA\n");
> -		return ret;
> -	}
>  
>  	/* Wait for a maximum packet size to be drained */
>  	usleep_range(2000, 3000);
>  
>  	ret = rdma_enable_set(priv, 0);
> -	if (ret) {
> +	if (ret)
>  		netdev_err(dev, "timeout disabling RDMA\n");
> -		return ret;
> -	}

[Severity: High]
Can the device still DMA into the freed RX buffers here?

rdma_enable_set() only returns -ETIMEDOUT after polling RDMA_STATUS for
roughly a second without ever seeing RDMA_DISABLED, so the error return is
evidence that the engine has not quiesced. With the return gone,
bcm_sysport_stop() continues into:

	/* Free RX/TX rings SW structures */
	for (i = 0; i < dev->num_tx_queues; i++)
		bcm_sysport_fini_tx_ring(priv, i);
	bcm_sysport_fini_rx_ring(priv);

and bcm_sysport_fini_rx_ring() only warns about exactly this state before
releasing everything:

	/* Caller should ensure RDMA is disabled */
	reg = rdma_readl(priv, RDMA_STATUS);
	if (!(reg & RDMA_DISABLED))
		netdev_warn(priv->netdev, "RDMA not stopped!\n");

	if (!priv->rx_cbs)
		return;

	for (i = 0; i < priv->num_rx_bds; i++) {
		cb = &priv->rx_cbs[i];
		if (dma_unmap_addr(cb, dma_addr))
			dma_unmap_single(&priv->pdev->dev,
					 dma_unmap_addr(cb, dma_addr),
					 RX_BUF_LENGTH, DMA_FROM_DEVICE);
		bcm_sysport_free_cb(cb);
	}

	kfree(priv->rx_cbs);

bcm_sysport_fini_tx_ring() has the same "TDMA not stopped!" warning followed
by bcm_sysport_tx_clean() and kfree(ring->cbs).

umac_enable_set(priv, CMD_RX_EN, 0) stops the UniMAC, not the RDMA/TDMA
descriptor engines, and bcm_sysport_stop() does no TOPCTRL flush and no
block reset, unlike bcm_sysport_suspend() which writes RX_FLUSH/TX_FLUSH.
Would it be better to force the block quiescent on the timeout path first,
for example via topctrl_flush() and/or a block reset, before unmapping and
freeing the buffers? Alternatively, release the IRQs, PHY and clock while
keeping the DMA-mapped buffers owned by the driver, so the engine cannot
write into memory that has been returned to the allocator.

>  
>  	/* Disable UniMAC TX */
>  	umac_enable_set(priv, CMD_TX_EN, 0);

[Severity: Medium]
The commit message says "If the interface was subsequently brought up again,
request_irq() and PHY connection would fail or leak", which suggests the
interface is usable again after the fix. Does the re-open path actually
resynchronize the engines?

bcm_sysport_stop() now reaches clk_disable_unprepare(priv->clk) with
RDMA_EN/TDMA_EN never acknowledged as cleared, and no state is recorded to
say the DMA was stuck. On the next open, umac_reset() returns immediately
for priv->is_lite and otherwise only pulses CMD_SW_RESET, and
topctrl_flush() only pulses RX_FLUSH/TX_FLUSH; neither clears RDMA_EN or
TDMA_EN. bcm_sysport_init_rx_ring() then does:

	/* Initialize HW, ensure RDMA is disabled */
	reg = rdma_readl(priv, RDMA_STATUS);
	if (!(reg & RDMA_DISABLED))
		rdma_enable_set(priv, 0);

	rdma_writel(priv, 0, RDMA_WRITE_PTR_LO);
	rdma_writel(priv, 0, RDMA_WRITE_PTR_HI);
	rdma_writel(priv, 0, RDMA_PROD_INDEX);
	rdma_writel(priv, 0, RDMA_CONS_INDEX);

The rdma_enable_set() result is ignored and the pointer registers are zeroed
along with priv->rx_c_index and priv->rx_read_ptr, so if the engine is still
live its write pointer keeps advancing from the old position and the
software bookkeeping diverges from the hardware ring.
bcm_sysport_init_tx_ring() never samples TDMA_STATUS before rewriting
TDMA_DESC_RING_HEAD_TAIL_PTR/COUNT/PROD_CONS_INDEX, and bcm_sysport_open()
follows with:

	/* Initialize linked-list */
	tdma_writel(priv, TDMA_LL_RAM_INIT_BUSY, TDMA_STATUS);

Also, the later rdma_enable_set(priv, 1)/tdma_enable_set(priv, 1) in open()
return 0 immediately when the engine is already enabled, so open() reports
success on stale hardware state. Would recording a "DMA stuck" condition in
stop() and forcing a block reset on the next open make the re-open claim in
the commit message hold?

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but should
bcm_sysport_suspend() be converted the same way for consistency? It still
has both early returns:

	ret = rdma_enable_set(priv, 0);
	if (ret) {
		netdev_err(dev, "RDMA timeout!\n");
		return ret;
	}
	...
	ret = tdma_enable_set(priv, 0);
	if (ret) {
		netdev_err(dev, "TDMA timeout!\n");
		return ret;
	}

Both return before bcm_sysport_fini_tx_ring()/bcm_sysport_fini_rx_ring() and
before clk_disable_unprepare(priv->clk), while netif_device_detach(),
bcm_sysport_netif_stop() and phy_suspend() have already run and are not
undone. On a DMA timeout the suspend is aborted with the interface detached
(so netif_device_present() is false and a later open returns -ENODEV), the
PHY suspended, the ring cb arrays and their mapped SKBs still allocated, and
a clk prepare/enable reference still held.

After this patch the driver handles the same hardware failure in two
different ways, and the suspend path additionally flushes RX via
topctrl_writel(RX_FLUSH, RX_FLUSH_CNTL) and disables RDMA before TDMA,
which stop() does not. Is the divergence intentional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
