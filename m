Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF75547048;
	Fri,  2 Oct 2026 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905288; cv=none; b=aMoow4Mo0yyI7DPk0x4Q6Yg1xL1Cb9yegctyFrlavyXVKIDV2aCgUQrIpDztUcUL3QjKayfxq1Qp8nQgVvimgI6C5yzjfJDeIxSZynXSWpSmMsdYrR8wAt6pfFVlzirn0KcncBqJtTmGmkaLcthrq47Hl5GLdyl2uoAMoJsoZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905288; c=relaxed/simple;
	bh=9VBvq1URo0DAUMcc5xt46N/x4KlHhiwkp0rN8K5XPwo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JPBim9b3uYxXTg6VZlfsBUKeKZOr21KuMbRgpujXy/3aivyFtcEKfR3vGQJP5SB0HJPGIRTqr3tBSBhyOe4Y2xj2Ok30/3WYUkkgrpCEndeNAvvkKUTmw5uxcTNs5WdGG2g4r2tLqVD+vVQmUW2tvChSByS4hrv05qMWc+AXgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb0ws6+V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb0ws6+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC0A1F000FF;
	Fri,  2 Oct 2026 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790905286;
	bh=Bud2eicX84qICDr4fItYKKKJxblLGgtG+EST6vW+/pY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sb0ws6+VXsCRbr2lxa2mKUvTPCZ2yjYRJlqJ82c/RmFex2CNmgPerTIHRA+L8mOo+
	 2+X2uirsGdC9I7Ql4+xjknOX4O4CiobdiRO7lp9luvtYqHbsRyLPzyLbg0kEC5NDsz
	 fwsPp2HGsO/6XVHk/rzHioqKqBHehf6DPzZjfno4XBaxHy1FK2/zJZvSfQeEvyqbQf
	 a8Q3roSP2B+nLIAFZgAD7JZ5TDe/oJjSOSFMrKRUDCSWCECeGOdVF/KYnXLcTkyWS/
	 caLpz6m67fwfC+IZ5Wax8uMsklSyLfb5MjMUgaTRBXJVEvEO564FWTG0vwgFVz0lAO
	 Iu50yJz6xs2fQ==
Subject: Re: [PATCH net v2] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net,
 jacob.e.keller@intel.com, joe@dama.to, suraj.gupta2@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 01:41:25 +0000
Message-ID: <179090528517.434549.11422262316039898353@kernel.org>
In-Reply-To: <20260930133851.663023-1-maimon.sagi@gmail.com>
References: <20260930133851.663023-1-maimon.sagi@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new TX walk in axienet_dma_bd_release()
  (drivers/net/ethernet/xilinx/xilinx_axienet_main.c:192) only checks…
- [Low] The new walk in axienet_dma_bd_release() frees every leftover TX
  skb with dev_kfree_skb_any() (a drop with…
- [Low] The new TX walk relies on axienet_stop() having stopped the DMA
  engine, and the commit message says so.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the same
  kind of leak exists in dmaengine mode.

--

net: axienet: free outstanding TX buffers in axienet_dma_bd_release()

axienet_dma_bd_release() now walks the TX descriptor ring before freeing
it. For each descriptor whose cntrl is still set it unmaps the buffer, and
it frees any attached skb as a drop. The walk is skipped when tx_bd_v is
NULL.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..8bf27e20e103d 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -186,7 +186,28 @@ static void axienet_dma_bd_release(struct net_device *ndev)
>  	int i;
>  	struct axienet_local *lp = netdev_priv(ndev);
>
> -	/* If we end up here, tx_bd_v must have been DMA allocated. */
> +	/* tx_bd_v is NULL if axienet_dma_bd_init() did not get as far as
> +	 * allocating it; dma_free_coherent() below accepts that.
> +	 */
> +	for (i = 0; lp->tx_bd_v && i < lp->tx_bd_num; i++) {

[Severity: High]

Is lp->tx_bd_v ever set back to NULL? The only assignment seems to be the
dma_alloc_coherent() in axienet_dma_bd_init(). The dma_free_coherent()
below leaves the pointer in place, so the NULL check only holds on the
first open, while the private area is still zeroed.

Consider this sequence:

ifup (succeeds)
ifdown
  axienet_stop()
    axienet_dma_bd_release()
      dev_kfree_skb_any(cur_p->skb)      /* cur_p->skb not cleared */
      dma_free_coherent(..., lp->tx_bd_v, ...)  /* tx_bd_v left as is */
ifup
  axienet_open()
    axienet_device_reset()
      __axienet_device_reset() fails, returns before axienet_dma_bd_init()
    ret = phylink_of_phy_connect(...)    /* reset result overwritten */
ifdown
  axienet_stop()
    axienet_dma_bd_release()
      walks the already freed tx_bd_v ring

Can this call dev_kfree_skb_any() a second time on the skbs freed at the
previous close? It would also call dma_unmap_single() on addresses that
were already unmapped. If the coherent memory has been reused, arbitrary
values would go to kfree and the DMA unmap.

The out: label in axienet_dma_bd_init() looks like a second way in. If the
rx_bd_v allocation, netdev_alloc_skb_ip_align() or dma_map_single() fails,
the TX ring is freed there and tx_bd_v is not cleared. axienet_open() then
ignores the error, and the next axienet_stop() walks the freed ring.

Before this patch these paths already did a second dma_free_coherent() on
the stale pointer. With this patch, the freed descriptors are also read,
and the skb and DMA addresses stored in them are freed and unmapped.

The commit message says:

  tx_bd_v is NULL when axienet_dma_bd_init() did not get as far as
  allocating it: axienet_open() does not check the result of the reset
  that runs it.

Could lp->tx_bd_v (and lp->rx_bd_v) be set to NULL after each
dma_free_coherent()? Clearing cur_p->skb and cur_p->cntrl in the walk, or
having axienet_open() propagate the axienet_device_reset() error, would
also close this.

> +		struct axidma_bd *cur_p = &lp->tx_bd_v[i];
> +
> +		/* axienet_free_tx_chain() clears cntrl when it reclaims a
> +		 * descriptor, so a non-zero value means the mapping is live.
> +		 */
> +		if (cur_p->cntrl) {
> +			dma_addr_t addr = desc_get_phys_addr(lp, cur_p);
> +
> +			dma_unmap_single(lp->dev, addr,
> +					 (cur_p->cntrl &
> +					  XAXIDMA_BD_CTRL_LENGTH_MASK),
> +					 DMA_TO_DEVICE);

[Severity: Low]

This unmap assumes the MM2S engine has stopped. axienet_dma_stop() polls
the halt bit for at most 5 x 20 ms and does not act on a timeout. It also
discards the return value of __axienet_device_reset():

  sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
  for (count = 0; !(sr & XAXIDMA_SR_HALT_MASK) && count < 5; ++count) {
          msleep(20);
          sr = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
  }

  /* Do a reset to ensure DMA is really stopped */
  axienet_lock_mii(lp);
  __axienet_device_reset(lp);
  axienet_unlock_mii(lp);

If the channel neither halts nor resets, could the engine still be reading
TX payloads after they are unmapped here?

The RX walk and the ring dma_free_coherent() in this function already
carry the same risk, and the commit message documents the dependency. The
new exposure is small and limited to faulty hardware.

> +		}
> +		/* never transmitted, so account it as a drop */
> +		if (cur_p->skb)
> +			dev_kfree_skb_any(cur_p->skb);

[Severity: Low]

Is "never transmitted" true for every descriptor that reaches this point?
axienet_stop() calls napi_disable(&lp->napi_tx) before phylink_stop(), the
TXEN clear and axienet_dma_stop(). The MM2S engine can keep completing
frames in that window, and nothing reclaims them.

axienet_free_tx_chain() treats descriptors with the COMPLETE bit set as
transmitted:

  if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
          ...
          napi_consume_skb(cur_p->skb, budget);
          packets++;
  }

Should this check cur_p->status for XAXIDMA_BD_STS_COMPLETE_MASK and use
dev_consume_skb_any() for those skbs? As written, frames that were
actually sent are reported as drops and are left out of tx_packets and
tx_bytes.

> +	}
> +
>  	dma_free_coherent(lp->dev,
>  			  sizeof(*lp->tx_bd_v) * lp->tx_bd_num,
>  			  lp->tx_bd_v,

[Severity: Medium]

This isn't a bug introduced by this patch, but the dmaengine branch of
axienet_stop() seems to leak in the same way. When lp->use_dmaengine is
set, axienet_dma_bd_release() is never called. The branch does this:

  dmaengine_terminate_sync(lp->tx_chan);
  ...
  for (i = 0; i < TX_BD_NUM_MAX; i++)
          kfree(lp->tx_skb_ring[i]);

In-flight TX entries still hold an skb and the dma_map_sg() mapping set up
in axienet_start_xmit_dmaengine(). Only axienet_dma_tx_cb() releases
those.

xilinx_dma_terminate_all()->xilinx_dma_free_descriptors() frees the
descriptor lists without invoking client callbacks, so that callback never
runs for terminated transfers.

Does this leak the TX skbs and their scatterlist mappings on every ifdown
with traffic in flight? The RX buffers submitted by
axienet_rx_submit_desc() look like they are lost the same way.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930133851.663023-1-maimon.sagi%40gmail.com
