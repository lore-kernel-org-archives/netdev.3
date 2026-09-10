Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB874A3F25;
	Thu, 10 Sep 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054407; cv=none; b=Qm8wRtX72xShIPaLUQhPk4Vq3ErGLhVQ7F2ZxqyAIYt2OQPAOOV9C0w5cJ4oySNHrgIQA2GpNYl/F2w7NH6O92PejVajEBfs5Xxv22fq/zLGBsqzzRKaJpFACHyZeGrg1mFwcY+Yeo0wYQfkaOMHBGFWLcAP/Gv0OKlYmH8VIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054407; c=relaxed/simple;
	bh=GWoXxwQbee4E47VmS4XZkoBt30EvqPBdskvJm5wsh18=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hp1rTuTpOUw5FS5FBsljoGbz5UsKK7zvwC2ZEtrh0DDGos+CHEegiVI3s1odjiR5o4iN3zeIyGWeezATWsp6qcX4wdPEPe1aTZpHcKpXYK471eRLy/wSg1ifdsXEfzfDGwfoIbLlptV42plQYqXU+nQ+U5/5Q35BsJ60YjzL81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiD6n5R1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiD6n5R1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC1B1F000FF;
	Thu, 10 Sep 2026 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054405;
	bh=BVdmkaSk3ZG55nEhsYcH95ArBxXEWXCCMZcHoDFV5Og=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CiD6n5R1z57QgmIKQnJ5Ajzku3sxKwqHMfxaB3mDlbzMea9AtA1NwcKXXtJx0LpgT
	 2C+FRSyKXwy3L6xS/pdLkxg7fFmUG8YIgu0U4DxW9Ah845f2plLu/j8LPQsPNYXos0
	 27A0xWLpZrJFMnd/tPxNxM8Iey3y6yUtrPqGeYE2lSIjOZygpZWGaI2VWxy6lqJ8bc
	 /s+S7zOYwylvbRn1vZJ58Zvd7pHkLBSyzT71ntpSfTB+cvVXada0/uO+nLcijHwzx+
	 oCOpmFKllmeDjeZ0kaLIVQbH5FXZxx1b8iheGr4oYEvOwYZC/345xMbF1K7YURGP3v
	 oPq7odcg1/+1A==
Subject: Re: [PATCH net-next V3] net: axienet: Clear stale AXI DMA TX/RX
 status before re-enabling interrupts
From: netdev-bot+sashiko@kernel.org
To: kusuma.vasana@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 git@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 10 Sep 2026 15:33:24 +0000
Message-ID: <178905440414.219967.6111426130109067474@kernel.org>
In-Reply-To: <20260906153243.1903501-1-kusuma.vasana@amd.com>
References: <20260906153243.1903501-1-kusuma.vasana@amd.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 2

- [High] Unordered write-1-to-clear of the AXI DMA status register
  followed by a descriptor read can silently swallow a DMA completion.
- [Low] Both new blocks can `return budget` while `packets` is less than
  budget (possibly zero), which contradicts the unchanged kernel-doc of…
- [Low] The new RX comment at
  drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1314-1318 states…

--

net: axienet: Clear stale AXI DMA TX/RX status before re-enabling interrupts

This adds a write-1-to-clear of the IOC/DELAY bits in the AXI DMA TX/RX
status registers at the end of axienet_tx_poll() and axienet_rx_poll(),
followed by a re-check of the next buffer descriptor, in order to avoid
one redundant NAPI poll caused by status latched while interrupts were
masked.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..ae43b9744cb90 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1018,6 +1018,16 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
>  			netif_wake_queue(ndev);
>  	}
>  
> +	/* Clear stale IOC/DELAY bits and re-check for race-window completions.
> +	 * Skipped on budget exhaustion.
> +	 */
> +	if (packets < budget) {
> +		axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET,
> +				  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> +		if (lp->tx_bd_v[lp->tx_bd_ci].status & XAXIDMA_BD_STS_COMPLETE_MASK)
> +			return budget;
> +	}

[Severity: High]
Can this sequence lose a DMA completion?  The status-register clear is a
posted write with nothing after it to flush or order it:

drivers/net/ethernet/xilinx/xilinx_axienet.h:
static inline void axienet_dma_out32(struct axienet_local *lp,
				     off_t reg, u32 value)
{
	iowrite32(value, lp->dma_regs + reg);
}

The descriptor status that follows is a plain load from
dma_alloc_coherent() memory, so on arm/arm64 the Device-nGnRE store is not
ordered against the subsequent Normal-memory load (iowrite32() only emits
__iowmb() before the store).

That allows this interleaving:

  CPU				DMA engine
  ----				----------
  write IOC|DELAY to SR		(write still in flight)
  read tx_bd_v[tx_bd_ci].status
    -> not COMPLETE
				descriptor writeback, latch IOC/DELAY
  (queued W1C lands, wipes IOC/DELAY)
  napi_complete_done()
  write lp->tx_dma_cr

after which IOC/DELAY are enabled in the control register but the status
register is clean, so the level-sensitive line stays de-asserted while a
COMPLETE descriptor sits in the ring.

Before this patch there was no such window: the status word was acked only
in axienet_tx_irq()/axienet_rx_irq() before NAPI ran:

	axienet_dma_out32(lp, XAXIDMA_TX_SR_OFFSET, status);

so anything the hardware latched during the poll window kept the line
asserted and produced exactly the extra poll this patch removes.

The RX hunk below has the same ack-then-scan shape, and it is issued right
after the XAXIDMA_RX_TDESC_OFFSET doorbell, i.e. when the engine is most
likely to complete a descriptor concurrently.  On TX the skb is not freed
and netdev_completed_queue()/BQL accounting stays skewed until some later
completion; note that axienet_netdev_ops has no .ndo_tx_timeout, and
netdev_watchdog_up() returns early without one, so there is no software
watchdog fallback.  On RX the frame is delivered late, or on an idle link
not until the peer retransmits.

Would reading back XAXIDMA_TX_SR_OFFSET / XAXIDMA_RX_SR_OFFSET (or
otherwise ordering the clear ahead of the descriptor scan) close this?

[Severity: Low]
This return can hand back budget while packets is smaller than budget, and
possibly zero.  The kernel-doc above axienet_tx_poll() still says:

 * Return: Number of TX packets processed.

and the one above axienet_rx_poll() says:

 * Return: Number of RX packets processed.

The commit message describes the change only as

    "recheck the next BD to catch race-window completions"

without mentioning that the poll now returns a sentinel work value.
__napi_poll() treats work == weight specially:

net/core/dev.c:__napi_poll() {
	...
	if (likely(work < weight))
		return work;
	...
	gro_flush_normal(&n->gro, HZ >= 1000);
	...
	*repoll = true;
}

and net_rx_action() charges the returned value against netdev_budget with
budget -= napi_poll(n, &repoll), so a poll that reclaimed nothing consumes
a full weight of the softirq budget.  On RX the same path also skips the
net_dim() sample in the napi_complete_done() branch.

Returning budget does look like the required idiom here, since returning a
smaller value without calling napi_complete_done() would leave the instance
scheduled but off the poll list.  Could the kernel-doc and changelog be
updated to describe the sentinel return instead?

>  	if (packets < budget && napi_complete_done(napi, packets)) {
>  		/* Re-enable TX completion interrupts. This should
>  		 * cause an immediate interrupt if any TX packets are
> @@ -1301,6 +1311,18 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
>  	if (tail_p)
>  		axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);
>  
> +	/* Clear stale IOC/DELAY bits and re-check for race-window completions.
> +	 * Skipped on budget exhaustion and on refill failure (cur_p->skb ==
> +	 * NULL) to leave the level-sensitive IRQ armed so the poll is
> +	 * rescheduled on the next hardware completion.
> +	 */

[Severity: Low]
Is the "leave the level-sensitive IRQ armed so the poll is rescheduled on
the next hardware completion" part of this comment accurate?

axienet_rx_irq() already writes back the whole status word before NAPI is
scheduled:

	axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET, status);

so unless the hardware latched a new IOC/DELAY during the poll window there
is no bit left to keep the line asserted, and the skip is a no-op rather
than something that arms the interrupt.

When a bit was latched during the window, the following block is not gated
on cur_p->skb:

	if (packets < budget && napi_complete_done(napi, packets)) {
		...
		axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);

so the line asserts an interrupt immediately, not "on the next hardware
completion".

The RX tail was also only advanced to the last successfully refilled
descriptor:

	if (tail_p)
		axienet_dma_out_addr(lp, XAXIDMA_RX_TDESC_OFFSET, tail_p);

so a further completion past the stalled slot is not guaranteed either.
Could the comment (and the matching sentence in the commit message) be
reworded to match what the code does?

> +	if (packets < budget && cur_p->skb) {
> +		axienet_dma_out32(lp, XAXIDMA_RX_SR_OFFSET,
> +				  XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_DELAY_MASK);
> +		if (cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK)
> +			return budget;
> +	}
>  
>  	if (packets < budget && napi_complete_done(napi, packets)) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153243.1903501-1-kusuma.vasana%40amd.com
