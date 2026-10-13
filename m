Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087E471430;
	Tue, 13 Oct 2026 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883162; cv=none; b=Hu+F9hjHluyLvmUJv+nxVE2ewutk1aIcUY3ILmI17gdQhvDbGOn1O02P9g7GX9jjzZREKrFu6+gsNkRsM+srbbkKeTKQyxHpCfcecqkBbq16TEF1gapfDq1xBFGw8WDk3OgSH1fj38thL7vax1ANC0wwOv8fY1n6XoyFAMsYpwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883162; c=relaxed/simple;
	bh=LkuJO49/QuuLmQpNRRVeBmz3T4vpsFHvbjbwPmNgIds=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Km6wPtODDP1s/r90/zzuozoYqEQovCNPtfb5QiLTSgc5A8fzf3K3BcrttTzqdiYDEsNc9+kDrihLgfH0mcqkfAtYh2L82AjrIz4aFHwfa6Wbtw15Ueu6toGPlPzLNM3aIzC03Aa44r7e48QyLF+UdXUaRw3zjrf1xCBJFuybmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnfDLomU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnfDLomU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193591F00893;
	Tue, 13 Oct 2026 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883160;
	bh=aesO5YqOiBaz2sVJO7oGV564Uk0FwW4UWvbEHwxIqaA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fnfDLomUzOxETqOOkUeDJIDo4ZD4kISdXTESjQNwsvBh8MUGjFv6/wic8lbRbXNjf
	 GHVJ+FMwf8nLvV5LkhzhUZmVqhqwJ9atQctMdZtW8BOoFucpJeKTi7fjThrgs0DuNf
	 Err2egymIwY+Wbx2x0ZxEENOKp4j6xvyg4VXXqm6Q/EsfbFoBUvcm5Zc2bEKXyuqu9
	 QgB1YQ6BdJkfR9hXCZjauNIklo2xwq6ZqzAfwEN3g8iZ9tMHQ9g7JUpQmhcSfOj06d
	 8A5JbnUQF99ol0vlIjqz++4neM4H1X9p0XFEftW0RkBR7w1ARN4HqbCTIpNhc208NE
	 ddmUgoGn/7Elw==
Subject:
 Re: [PATCH net-next v4 7/8] net: bcmgenet: allow the MTU to be changed
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Tue, 13 Oct 2026 09:19:19 +0000
Message-ID: <179188315964.434549.2607094947649815116@kernel.org>
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-7-2e2e3bfaf8cc@tipi-net.de>
References: <20261012-nb-genet-mtu-nn-v2-v4-7-2e2e3bfaf8cc@tipi-net.de>
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] An RX filter update can be lost during the MTU change.
- [Medium] The live MTU change leaves the PHY state machine running
  (bcmgenet_netif_stop(dev, false)), but nothing stops the PHY link…
- [Low] The patch fixes two existing bugs, but neither the commit message
  nor a Fixes: tag mentions them.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  priv->datapath_up and leaves this path unguarded.

--

net: bcmgenet: allow the MTU to be changed

This commit sets dev->max_mtu for GENET v2 and later, derived from the
packet ready threshold and the one page descriptor limit. It adds an
ndo_change_mtu that rebuilds the DMA rings and MTU registers in place while
the PHY keeps running, and retries the old MTU if allocation fails. A new
priv->datapath_up flag tracks whether the datapath has already been torn
down.

Link: https://github.com/raspberrypi/linux/issues/5561

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e00661b2414b9..f158d6bc314b9 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -3179,8 +3185,12 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
>  	/* Initialize Rx priority queues */
>  	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
>  		ret = bcmgenet_init_rx_ring(priv, i, end - start, start, end);
> -		if (ret)
> +		if (ret) {
> +			/* Only the rings before this one hold a NAPI */
> +			while (i--)
> +				netif_napi_del(&priv->rx_rings[i].napi);
>  			return ret;
> +		}

[Severity: Low]
This isn't a bug, but this unwind and the new priv->datapath_up handling in
bcmgenet_close(), bcmgenet_suspend() and bcmgenet_resume() look like they
also fix two existing problems. The commit message doesn't mention either
of them.

Before this patch, if bcmgenet_init_rx_ring() failed for ring i, the NAPIs
of rings 0..i-1 stayed listed after a failed bcmgenet_open() or
bcmgenet_resume(). The next netif_napi_add() would then hit the
already-listed warning.

Also, bcmgenet_close() used to call bcmgenet_netif_stop() unconditionally.
A close after a failed resume would call napi_disable() on NAPIs that were
already disabled during suspend, and then kfree() rx_cbs/tx_cbs a second
time. That path has nothing to do with the MTU, but the new comment in
bcmgenet_close() only says:

    /* A failed MTU change can have torn the datapath down already */

Could these fixes be split into separate patches with Fixes: tags so they
can go to net and stable? The rx unwind is needed for the MTU retry, which
calls bcmgenet_init_dma() twice in a row, so it could come first in the
series.

[ ... ]

> @@ -3622,7 +3633,11 @@ static int bcmgenet_close(struct net_device *dev)
>  
>  	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
>  
> -	bcmgenet_netif_stop(dev, false);
> +	/* A failed MTU change can have torn the datapath down already */
> +	if (priv->datapath_up) {
> +		bcmgenet_netif_stop(dev, false);
> +		priv->datapath_up = false;
> +	}

[ ... ]

> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{

[ ... ]

> +	/* The watchdog trips on an idle queue once the rings are gone */
> +	netif_device_detach(dev);
> +
> +	/* Only the buffers and the MTU registers change, leave the PHY up */
> +	bcmgenet_netif_stop(dev, false);
> +	priv->datapath_up = false;
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
> +	bcmgenet_set_mtu_regs(priv, new_mtu);

[Severity: Medium]
Can the first link-up enable the MAC again in the middle of this
reconfiguration?

After ifup and before the first link-up, UMAC_CMD still has CMD_SW_RESET
set from init_umac()->reset_umac(). In that state umac_enable_set() returns
without writing anything:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:umac_enable_set() {
    ...
	if (reg & CMD_SW_RESET) {
		spin_unlock_bh(&priv->reg_lock);
		return;
	}
    ...
}

So the MAC disable inside bcmgenet_netif_stop() has no effect.

The PHY state machine keeps running here. A link-up in this window runs
bcmgenet_mii_setup()->bcmgenet_mac_config() under phydev->lock, not RTNL:

drivers/net/ethernet/broadcom/genet/bcmmii.c:bcmgenet_mac_config() {
    ...
	if (reg & CMD_SW_RESET) {
		reg &= ~CMD_SW_RESET;
		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
		udelay(2);
		reg |= CMD_TX_EN | CMD_RX_EN;
	}
    ...
}

The MAC would then be enabled while bcmgenet_set_mtu_regs() rewrites
UMAC_MAX_FRAME_LEN and the RBUF/TBUF thresholds. That function's own
comment says "Call with the MAC disabled". It would also be enabled while
bcmgenet_init_dma(priv, true) flushes the RBUF and rebuilds the rings.

Open and resume program these registers before phy_start(), so only the
new path is exposed. The window includes the 10-20 ms sleep in the DMA
teardown, so a network manager that sets the MTU right after ifup could
hit it. Does anything prevent this?

> +
> +	ret = bcmgenet_init_dma(priv, true);

[ ... ]

> +	bcmgenet_hfb_restore(priv);
> +	bcmgenet_netif_start(dev, false);
> +
> +	/* bcmgenet_netif_start() only restores the link interrupt */
> +	if (bcmgenet_has_mdio_intr(priv))
> +		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_MDIO_EVENT,
> +					 INTRL2_CPU_MASK_CLEAR);
> +
> +	/* A link event latched while the interrupts were off is gone. Internal
> +	 * PHYs on GENET v1-v4 are not polled, so resync the state machine.
> +	 */
> +	phy_mac_interrupt(dev->phydev);
> +
> +	priv->datapath_up = true;
> +	netif_device_attach(dev);

[Severity: Medium]
Can a concurrent RX address list update get lost here?

bcmgenet_netif_start() programs the RX filters through
bcmgenet_set_rx_mode() under netif_addr_lock_bh() and then drops the lock.
The device stays detached until the netif_device_attach() above. A unicast
or multicast list change in that window reaches __dev_set_rx_mode(), which
drops it:

net/core/dev_addr_lists.c:__dev_set_rx_mode() {
    ...
	if (!netif_device_present(dev))
		return;
    ...
}

netif_device_attach() doesn't resync the RX mode, and bcmgenet has no
ndo_change_rx_flags, so nothing queues the update for later.

RTNL is held here. However, IPV6_ADD_MEMBERSHIP
(ipv6_sock_mc_join()->__ipv6_dev_mc_inc()->dev_mc_add()) runs under the
socket lock and mc_lock, not RTNL, so it can race with this. The new group
would then sit in dev->mc without reaching the MDF filter until some
unrelated RX mode change.

Would it help to call bcmgenet_set_rx_mode() again after
netif_device_attach()?

[ ... ]

> @@ -4510,6 +4602,7 @@ static int bcmgenet_suspend(struct device *d)
>  	} else {
>  		/* Teardown the interface */
>  		bcmgenet_netif_stop(dev, true);
> +		priv->datapath_up = false;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but the new priv->datapath_up
flag tracks exactly this state, and bcmgenet_suspend() still never checks
it. Can a second system suspend hang after a failed resume?

The sequence would be:

1. A non-WoL suspend runs bcmgenet_netif_stop(dev, true). Its
   napi_disable() calls leave NAPI_STATE_SCHED|NPSVC set.
   bcmgenet_fini_dma() then deletes the NAPIs and frees rx_cbs/tx_cbs
   without NULLing them.

2. bcmgenet_resume() fails in bcmgenet_init_dma() (kzalloc failure, Tx/Rx
   DMA halt timeout, or Rx buffer allocation failure):

	ret = bcmgenet_init_dma(priv, false);
	if (ret) {
		netdev_err(dev, "failed to initialize DMA\n");
		goto out_clk_disable;
	}

   The device is left detached, netif_running() is still true and
   datapath_up is false.

3. On the next system suspend, bcmgenet_suspend() sees netif_running() and
   reaches bcmgenet_disable_tx_napi(). In this branch that happens through
   bcmgenet_netif_stop(), and the WoL branch calls it directly.

napi_disable_locked() would then loop forever in:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

That happens because the earlier disable left those bits set. Even if
suspend got past that point, bcmgenet_fini_dma() would kfree() rx_cbs and
tx_cbs a second time.

bcmgenet_close() is now guarded by priv->datapath_up. Should the teardown
in both branches of bcmgenet_suspend() check it too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc%40tipi-net.de
