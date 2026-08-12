Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B573372B45
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499678; cv=none; b=YGJZqpO92oi95KaB+35Yy5GNYJoySpLxp5dt6p9Pay9Fy+hAchCCICZxpnJsroYBrZR3w1c9LgWZGuBoW5hxqTBTzyndsnHWPMGebkV3WYTGC18v/STPh9iK6ilsJ6B65dYgL4T3K1vK4gHl4OfjzFn8rFASFNhlC2UNUPwcgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499678; c=relaxed/simple;
	bh=oOcO6FvKxaR6rdOxRjq8azH3qdONSVz+4x1uZKIyxLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5dQD8sl8cwchqIew5oZsp5YtoOnP1oYmgTNp/bfX5b1ozHt/vB58Dpg0AwN6vW5q+jN39yCZWcDF/X5Q3IcQ8ajfddP8ec9bQgkzlEPx2S5LUHc00JMWUdT8DdEm+vrLukcYaPHF99ooq6JY+qsabFyRHE+oAN7gWaD6YCUxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpPS3A3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpPS3A3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D217C1F00A3D;
	Wed, 12 Aug 2026 01:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786499674;
	bh=VTznsO+RCACgQG/5YW7d0y93rYbdA/g1AdjOUmFlfa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dpPS3A3+XKq5qwKDoJFVLi8YCtYzAgOBhiXjtrrYv/vVzaEBs1WsWvXJCUyBSmavs
	 F9Nyq+oFHLNtMhjg8L9njsr4lqq3Ivlv0iiAwm0aEZp+TdAzKyVhkItg8f9bM9+iGR
	 RluJ5KjZSqw9Vt5lNumuSXouHe+OEDjsixrYUg7U3RQeu3G6GkUc2IntfR79aiaYfD
	 X6Jno81zzHuY6kh8FSujh1Q7q5A0cUsUnwwR+Dkk+QYO8/QLUr4S2jKWBsQCX4ngLd
	 4TuFMJkTPppLwDXhT48thu5pCuIuDh0KOX5h/sUD8mUcdJ4Hp4k+MD3nPq6y3O4DNP
	 X6pQgIHUXDW1A==
From: Jakub Kicinski <kuba@kernel.org>
To: nwhitehorn@pa.msu.edu
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch
Subject: Re: [PATCH net-next v4 1/2] net: macb: Poll for link state changes when using the internal PCS.
Date: Tue, 11 Aug 2026 18:54:33 -0700
Message-ID: <20260812015433.1687252-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807201741.3275-2-nwhitehorn@pa.msu.edu>
References: <20260807201741.3275-2-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: macb: Poll for link state changes when using the internal PCS.

This sets phylink_pcs.poll on the macb SGMII PCS so that phylink polls the
PCS for link state instead of relying on an onboard PHY, which is needed
for offboard transceivers such as SFPs.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d394f1f43b68..c15a9c7e69d3 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1025,6 +1025,7 @@ static int macb_mii_probe(struct net_device *dev)
>  	struct macb *bp = netdev_priv(dev);
>  
>  	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
> +	bp->phylink_sgmii_pcs.poll = true;

[Severity: Medium]
Can this silently disarm Wake-on-LAN across a suspend?

Setting poll on the SGMII PCS makes phylink arm its periodic link_poll
timer, since macb also sets phylink_config.default_an_inband = true in
macb_mii_probe(), so cfg_link_an_mode ends up as MLO_AN_INBAND:

drivers/net/phy/phylink.c:phylink_pcs_poll_start() {
	if (pl->pcs && pl->pcs->poll && pl->cfg_link_an_mode == MLO_AN_INBAND)
		mod_timer(&pl->link_poll, jiffies + HZ);
}

That is reached from phylink_start() -> phylink_mac_initial_config() ->
phylink_major_config() -> phylink_pcs_poll_start().

The timer is only cancelled by phylink_stop() (timer_delete_sync of
pl->link_poll) or phylink_pcs_poll_stop(), but macb_suspend() skips
phylink_stop() entirely on the Wake-on-LAN path:

drivers/net/ethernet/cadence/macb_main.c:macb_suspend() {
	...
	/* Enable Receive engine */
	macb_writel(bp, NCR, tmp | MACB_BIT(RE));
	...
	enable_irq_wake(bp->queues[0].irq);
	}
	...
	if (!(bp->wol & MACB_WOL_ENABLED)) {
		rtnl_lock();
		phylink_stop(bp->phylink);
		rtnl_unlock();
	...
}

macb also does not use the Wake-on-LAN aware phylink_suspend(pl, true) /
phylink_resume() pair, so pl->phylink_disable_state stays 0 and
phylink_fixed_poll() keeps re-arming itself and queuing pl->resolve on
system_power_efficient_wq, which is not freezable.

If the poller then observes a PCS link change during the suspend window,
macb_mac_link_down() clears exactly the bit macb_suspend() just set:

drivers/net/ethernet/cadence/macb_main.c:macb_mac_link_down() {
	/* Disable Rx and Tx */
	ctrl = macb_readl(bp, NCR) & ~(MACB_BIT(RE) | MACB_BIT(TE));
	macb_writel(bp, NCR, ctrl);
}

The WOL register and the queue-0 wake interrupt remain enabled, so the
driver still believes Wake-on-LAN is armed while the receive engine is off
and a magic packet or ARP frame can no longer be received.  Clocks stay on
here because macb_runtime_suspend() skips macb_clks_disable() when
device_may_wakeup(), so the register write does reach the MAC.

The opposite direction looks odd too: a poll-triggered macb_mac_link_up()
re-enables RE|TE and re-writes the per-queue IER with
bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP) after the RX queues
have been tied off or set to MACB_BIT(QUEUE_DISABLE) and NAPI has been
disabled, on an IRQ that is an armed system wake source.

phylink documents the intended behaviour for this case in
phylink_suspend():

	/* We do not call mac_link_down() here as we want the
	 * link to remain up to receive the WoL packets.
	 */

Would switching macb_suspend()/macb_resume() to phylink_suspend(bp->phylink,
true) / phylink_resume(), or otherwise stopping the poller on the
Wake-on-LAN path, be preferable now that a periodic PCS poller exists?
-- 
pw-bot: cr
