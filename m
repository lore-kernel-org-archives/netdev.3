Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8E544D7F;
	Tue, 22 Sep 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081223; cv=none; b=U/1NZQgr0UZYs2zUkSWh13NzS7P/IbEAmUwx1tQ3hJtYwnOo7eUR/C0jYXlsp2eNTgSO6W6UzWrN4U1hOdXxFZNltRriFgm8U8k7djTuSUuiByFzh5y2X0Kugeoe/9k5cRXA9ohQbpQ5wgu5QjDa7b+0pOsNxH1BasTUrnvLmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081223; c=relaxed/simple;
	bh=BudmzbRUBh/nsImbCyxQlRL9pd09aKsZBoGF2/iX0/c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=At+P3EdUql2+ze6B+xVtLJgSj6Ai32h9QsMdtzs2awrmYRT3h379pzFeYUmF8inhGHMHVhxKQdEC2VewzALxTpONvD5aM4E6ErNzgEh+zKbcZDcGGMuLNSblxq0/NH4LMs0rzea4Y21/F106w4hijsCr53rxMoXABYNFJrGzEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsHlo2Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsHlo2Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681821F000FF;
	Tue, 22 Sep 2026 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081222;
	bh=D3Jdj3+bSP+YSlJtW/E4z6RFHVsPDAGtj1j45y1Vlsk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gsHlo2VcQ1iYlQl6UUoLuBDmF/gfgXTAI9xoO++swjzvv4qobB3ohoLU/BSaSXdV1
	 JHGFJ0TqRWbkt0nKOGhhimXHpU+yFgU1y+9tbTxzfKOLfmKz4oxDSP6KxRqCMbr3+q
	 7ph38+3JdzPkeXmliA3zfhD8Af6kg9GNcQpAhbmudwK8mz1TOrwwWyYCmRchBa2HaZ
	 SIc1B/7RwyNSFEkwsyWkZFqlYBuebrZmbsxhJvndXIG7lTrH3Pd8cm2OKyWwmRZvRk
	 dVl/sLj4/CAHbl5OvvWmTBdMgPVR5GspNPSY+P/q1KxVHeV1n54rzdAp6kOsIGtTP6
	 i7X7ZXqruBk0A==
Subject:
 Re: [PATCH net] net: bcmgenet: stop Tx NAPI before disabling the queues
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 12:47:00 +0000
Message-ID: <179008122084.2160803.1051800375963129894@kernel.org>
In-Reply-To: <20260921124435.974581-1-nb@tipi-net.de>
References: <20260921124435.974581-1-nb@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the Wake-on-LAN branch of bcmgenet_suspend()
  keeps the exact queue-stop-before-Tx-NAPI-stop ordering that this…

--

net: bcmgenet: stop Tx NAPI before disabling the queues

This moves bcmgenet_disable_tx_napi() ahead of netif_tx_disable() in
bcmgenet_netif_stop(), so an in-flight Tx completion can no longer call
netif_tx_wake_queue() after the queues have been stopped and before
bcmgenet_fini_dma() frees the rings.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index b916080f4ff17..0789b60e664ad 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3441,6 +3441,8 @@ static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
>  {
>  	struct bcmgenet_priv *priv = netdev_priv(dev);
>  
> +	/* Stop completion polling before it can wake a stopped queue */
> +	bcmgenet_disable_tx_napi(priv);
>  	netif_tx_disable(dev);

[Severity: High]

The commit message says:

  Close is safe because dev_deactivate_many() stops the qdisc first.
  bcmgenet_suspend() does not, so stop Tx NAPI before the queues.

bcmgenet_suspend() only reaches bcmgenet_netif_stop() in the non-WoL else
branch. Does the Wake-on-LAN branch still have the ordering this patch
declares unsafe?

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_suspend() {
	if (device_may_wakeup(d) && priv->wolopts) {
		netif_tx_disable(dev);
		...
		/* HFB programming, interrupt clearing */
		...
		if (-ETIMEDOUT == bcmgenet_tdma_disable(priv))
			netdev_warn(priv->dev,
				    "Timed out while disabling TX DMA\n");

		bcmgenet_disable_tx_napi(priv);
		bcmgenet_disable_rx_napi(priv);
		disable_irq(priv->irq1);
		bcmgenet_tx_reclaim_all(dev);
		bcmgenet_fini_tx_napi(priv);
	} else {
		/* Teardown the interface */
		bcmgenet_netif_stop(dev, true);
	}
}

Between netif_tx_disable() and bcmgenet_disable_tx_napi() here, priv->irq1
is still enabled and the Tx NAPI is still live, and bcmgenet_tdma_disable()
spins in udelay, so the window is not short. Can bcmgenet_tx_poll() run in
that window and undo the stop?

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_tx_poll() {
	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
		netif_tx_wake_queue(txq);
	}
}

Nothing later in the WoL branch re-stops the queue, and suspend does not
call dev_deactivate(), so the qdisc stays attached. sch_direct_xmit() gates
only on the per-txq stop bit, not on netif_device_present(), so the
netif_device_detach() done earlier in bcmgenet_suspend() does not block a
transmit:

net/sched/sch_generic.c:sch_direct_xmit() {
	HARD_TX_LOCK(dev, txq, smp_processor_id());
	if (!netif_xmit_frozen_or_stopped(txq))
		skb = dev_hard_start_xmit(skb, dev, txq, &ret);
}

A kernel-generated transmit is enough to hit this (ARP/ND reply, TCP
retransmit, forwarding), so freezing user space does not close it.

Two follow-on questions about that path:

Can this leak the skb and its DMA mapping? A transmit arriving after
bcmgenet_tx_reclaim_all() dma_map_single()s the skb into ring->cbs while
TDMA is already disabled, so no completion reclaims it. On the WoL-success
resume path, bcmgenet_resume() -> bcmgenet_init_tx_queues() ->
bcmgenet_init_tx_ring() resets the software and hardware indices without
walking cbs:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_init_tx_ring() {
	ring->cbs = priv->tx_cbs + start_ptr;
	ring->size = size;
	ring->clean_ptr = start_ptr;
	ring->c_index = 0;
	ring->free_bds = size;
	ring->write_ptr = start_ptr;
	ring->cb_ptr = start_ptr;
	ring->prod_index = 0;
}

Neither that function nor the resume path calls netdev_tx_reset_queue(), so
does the netdev_tx_sent_queue() accounting from the stray xmit leave BQL
skewed as well?

And on the WoL-failure resume path, can this reproduce the same
use-after-free quoted in the commit message?

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_resume() {
		/* MAC was reset so complete bcmgenet_netif_stop() */
		umac_enable_set(priv, CMD_RX_EN | CMD_TX_EN, false);
		bcmgenet_rdma_disable(priv);
		bcmgenet_intr_disable(priv);
		bcmgenet_fini_dma(priv);
}

bcmgenet_fini_dma() kfree()s priv->tx_cbs while the Tx queue is still
runnable, and bcmgenet_init_dma() only reallocates it after init_umac(),
phy_init_hw() and genphy_config_aneg(), so bcmgenet_xmit() ->
bcmgenet_get_txcb() would write through ring->cbs into freed memory.

Would it make sense to reorder the WoL branch as well, moving
bcmgenet_disable_tx_napi() ahead of netif_tx_disable() there?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921124435.974581-1-nb%40tipi-net.de
