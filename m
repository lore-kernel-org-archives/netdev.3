Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A735CB7B;
	Tue, 22 Sep 2026 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038735; cv=none; b=oegdew4n5jCE/a4XyD1cdZtWCyBCfIo0jnexD0/OPqYkcXJLy7CiBpP4Ql0q/X1fbtMRRuF1E2GSW8U0KxpQwWuvn+e+NO7hPBxYYw3LBzQnY8u7rCZcUisAZv0mxWtXvbdbAGOjlvQoWMDeSab1krcXeORHFV02Zg/wCtfN1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038735; c=relaxed/simple;
	bh=uWfaWMqN1VkUmAWIn3LDZmBypajhfb0dsrB8AaxsYI0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi6kooMO/PG4TULlcMZ4IlCxVYHdpfZ58pWEIh1NmoHZstRU05cUVJ8HvaRPS+l3kfT3JIXS8bZTWmqSAi40rkwCFMHHt6G5zjBujbO2pr9+IrO1Ww9wRAmbu7YQ+pXh3+SvKVmKXbLOzIbT1TCq42zAASaZUlW2P6F3wA5+aVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzr0uNIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzr0uNIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C00F1F000FF;
	Tue, 22 Sep 2026 00:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038731;
	bh=s/D+XUHsZNAJA1Pwb/08xGti8CHBf5baS0DNv2LgSBc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bzr0uNIN0Y0ihE0ReyRS31UlT46CKw0C5BzKw8grBIO9M+dOK1jOfT1v3kRHka2+e
	 1GO6hO3vyGpwN+I5AVeNxVozED8a/XUCVXmbemDKt98IOx2ftBoO9+VZZStVKT6FJ7
	 IgQORpUSXb+mgKgAdOtK2pEnkPMupMioT1GxPs47TP/yfRtUMznG6UDZy6bu5ECj3Q
	 tMLNsrMm2YjYG4RrXYtJQkLyiF7vT6AcsvC13AhbeG036bOEZIdx64Be5AALM+YUVl
	 X8x+BNlmg7z+0XsQF0moO4E2PBO9CDNlDRXD/LA8Bq4CODJ3MYjPWiP4LDIA4ii1tR
	 9fxZt+7NqJvaw==
Subject: Re: [PATCH net 5/8] net: bcmgenet: acquire ring lock with BH disabled
 in bcmgenet_dump_tx_queue
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:50 +0000
Message-ID: <179003873076.2160803.5036239570797496188@kernel.org>
In-Reply-To: <20260918000732.276506-6-florian.fainelli@broadcom.com>
References: <20260918000732.276506-6-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's justification for converting
  spin_lock()/spin_unlock() to spin_lock_bh()/spin_unlock_bh() in…

Pre-existing issues:
- [Low] bcmgenet_dump_tx_queue()
  (drivers/net/ethernet/broadcom/genet/bcmgenet.c:3500-3535) snapshots…

--

net: bcmgenet: acquire ring lock with BH disabled in bcmgenet_dump_tx_queue

This converts the ring->lock acquisition in bcmgenet_dump_tx_queue() from
spin_lock()/spin_unlock() to spin_lock_bh()/spin_unlock_bh(), with the
stated goal of avoiding a self-deadlock against TX NAPI on the same CPU.
It carries a Fixes tag pointing at 13ea657806cf ("net: bcmgenet: improve
TX timeout").

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index ef155a170fa62..799da63e3a4e4 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

> bcmgenet_dump_tx_queue() is called from bcmgenet_timeout() in process or
> timer context and acquires ring->lock using spin_lock(). If a softirq
> such as TX NAPI (bcmgenet_tx_poll()) fires on the same CPU while the lock
> is held, it will deadlock trying to acquire ring->lock.

[Severity: Medium]
Can bcmgenet_dump_tx_queue() actually run in process context?

The only caller is bcmgenet_timeout(), which is only installed as
.ndo_tx_timeout in the driver's netdev_ops.  The only generic caller of
ndo_tx_timeout is dev_watchdog() in net/sched/sch_generic.c:

static void dev_watchdog(struct timer_list *t)
{
	...
			netif_freeze_queues(dev);
			dev->netdev_ops->ndo_tx_timeout(dev, i);
			netif_unfreeze_queues(dev);

dev_watchdog() is a timer_list callback, so it already runs in
TIMER_SOFTIRQ context with BH disabled.  Since softirq handlers do not
nest on the same CPU, can bcmgenet_tx_poll() (NET_RX softirq) ever
preempt the lock holder here and deadlock as described?

If not, the call chain is:

dev_watchdog()			/* timer softirq, BH already disabled */
  ndo_tx_timeout()
    bcmgenet_timeout()
      bcmgenet_dump_tx_queue()	/* spin_lock_bh() nests local_bh_disable() */

which would make this change a functional no-op rather than a deadlock
fix.  No hardirq handler takes ring->lock either (bcmgenet_isr1 only
touches priv->lock and the interrupt status), so a stronger variant does
not look necessary either.

Would it make sense to either drop the patch, or respin it as a
consistency-only change without the Fixes tag, so that the no-op is not
backported to stable under a deadlock rationale?

> @@ -3508,14 +3508,14 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
>  
>  	txq = netdev_get_tx_queue(priv->dev, ring->index);
>  
> -	spin_lock(&ring->lock);
> +	spin_lock_bh(&ring->lock);
>  	intsts = ~bcmgenet_intrl2_1_readl(priv, INTRL2_CPU_MASK_STATUS);
>  	intmsk = 1 << ring->index;
>  	c_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_CONS_INDEX);
>  	p_index = bcmgenet_tdma_ring_readl(priv, ring->index, TDMA_PROD_INDEX);
>  	txq_stopped = netif_tx_queue_stopped(txq);
>  	free_bds = ring->free_bds;
> -	spin_unlock(&ring->lock);
> +	spin_unlock_bh(&ring->lock);
>  
>  	netif_err(priv, tx_err, priv->dev, "Ring %d queue %d status summary\n"
>  		  "TX queue status: %s, interrupts: %s\n"

[Severity: Low]
This isn't a bug introduced by this patch, but while the critical section
is being touched: only free_bds and the two hardware indices are captured
under ring->lock, while the remaining software state is read after the
unlock in the netif_err() argument list:

	free_bds = ring->free_bds;
	spin_unlock_bh(&ring->lock);
	...
		  ring->prod_index, p_index & DMA_P_INDEX_MASK,
		  ring->c_index, c_index & DMA_C_INDEX_MASK,
		  ring->clean_ptr, ring->write_ptr,

__bcmgenet_tx_reclaim() updates those same fields under ring->lock:

	ring->clean_ptr = ...
	...
	ring->free_bds += txbds_processed;
	ring->c_index = c_index;

and it is reachable from bcmgenet_tx_poll() on another CPU, since
netif_freeze_queues() in dev_watchdog() only blocks the xmit path and does
not quiesce TX NAPI.  Can the printed summary then mix free_bds from one
instant with c_index/clean_ptr from a later one, giving an inconsistent
picture of the stall being debugged?  Would moving the remaining reads
inside the critical section into locals be preferable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
