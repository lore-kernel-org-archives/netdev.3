Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A53BB10E;
	Thu, 24 Sep 2026 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214959; cv=none; b=SQ2Cyn21aGXfkVswMXY48Y2xA0UP3SrHfQO/5Vy7MTuc1LnBx97lamqkJFbAdfElRwR7iKw95tIQjzHlLhc+EJurULRS9CJn6hMJr21xqDwgZUCvD4R2NFxw9H4NN53EGV9pDS+y6UQ2kMWN0rC0LUwUxiMJZk/MUSprhoWaPKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214959; c=relaxed/simple;
	bh=lWp25Fg7EpR0C/XbEX4lsNNIrqxjI5MBoHFCLAF5AXY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AUQDyy7kofc8W8ssSst6/dwbB7/bORezzri42FhW4g0aghEExiftyDixOGKe9Y23clmgg0XKAlTwutX0Nr2O2gHFfRztRT5jH1LTqPzRpR9sV7fYHNmJ+t9o/xDx0/dFptB8V6EVSXsm7z/1ruU9tyRfVLuHWRo124hLYZU3LjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8A+Z0qG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8A+Z0qG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D0B1F00899;
	Thu, 24 Sep 2026 01:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214957;
	bh=NLlxKLEwdj6R94NFZREneEC67JN6yr719CbwOaK7yt8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K8A+Z0qG9YYdyZqKxP/RhqmCLD4G9UgzRu7QdOs1zjuO74Q6rESk8UXMINpMV0Y6D
	 AejGxGZKPH2e00SpeVgGYnwqTMm850ADewy1CzFAlkYuf3s5tWYtKmI+lpZ9jjxyuU
	 v4/iJQRrKE1H5g5C8Vpi6gGekq4suy6aiS4bsmrbC1W4/ToS6uwW3IjLSU8f+VwKxc
	 jenTUfA/v1JuWI53oQpqim/JuO12hHcsxYXYqX/5JI9hu86BbUUdhJWj5OyNSZKxzb
	 06v5KBrm0hJx2gQE4JyFcsZzBbKzNOsJdbU/SefYs+hq5kJjD44Yi5OoJoCMvlEtAK
	 hNXoCmDl+N21g==
Subject: Re: [PATCH net-next v10 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 01:55:55 +0000
Message-ID: <179021495594.2160803.16936851129108019714@kernel.org>
In-Reply-To: <20260921-wiznet-link-gpio-v10-3-5874a7a147a2@marmottus.net>
References: <20260921-wiznet-link-gpio-v10-3-5874a7a147a2@marmottus.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] w5100_suspend() does not quiesce the deferred hardware-access
  paths before closing the controller: it disables the IRQs, cancels…
- [High] w5100_stop() now waits synchronously for the receive worker
  *before* stopping the hardware that produces receive traffic:…
- [Medium] The patch silently repairs a live, user-visible regression
  introduced by dacf281771a9 ("w5100: remove unused gpio link…
- [Medium] Commit message claim is not implemented: the message states
  "w5100_remove(), w5100_stop() and w5100_suspend() call…
- [Medium] w5500_report_carrier_state() (w5100.c:369-386) silently
  discards a failed PHYCFGR read: w5500_get_phycfgr_lnk() returns a…
- [Medium] Lost link-state edge because the PHYCFGR sample is taken
  before the edge-triggered link IRQ is (re-)enabled.
- [Medium] w5100_suspend() calls cancel_work_sync(&priv->restart_work)
  (line 1004) BEFORE netif_device_detach() (line 1006).
- [Low] For a w5500 whose DT does not supply the optional second
  (LINKLED) interrupt, the driver installs w5500_get_link() in…

--

w5100: detect carrier state using link status bit and optional interrupt

This adds carrier detection for the w5500 by reading the Link Status bit of
PHYCFGR, exposes it through a new w5500-only .get_link callback, and adds an
optional second interrupt (LINKLED) to update the carrier with
netif_carrier_on|off().  It also reworks probe/remove ordering, IRQ
enable/disable across open/stop/suspend/resume and work cancellation.

> diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
> index 53d8dc642fbd6..203a2099aa7b8 100644
> --- a/drivers/net/ethernet/wiznet/w5100.c
> +++ b/drivers/net/ethernet/wiznet/w5100.c

[ ... ]

> @@ -345,6 +352,77 @@ static void w5500_memory_configure(struct w5100_priv *priv)
>  	}
>  }
>  
> +static int w5500_get_phycfgr_lnk(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +	int ret = w5100_read(priv, W5500_PHYCFGR);
> +
> +	if (ret < 0) {
> +		netif_err(priv, link, ndev,
> +			  "failed to read link status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret & PHYCFGR_LNK;
> +}
> +
> +static void w5500_report_carrier_state(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +	int state;
> +
> +	mutex_lock(&priv->link_lock);
> +
> +	state = w5500_get_phycfgr_lnk(ndev);
> +	if (state > 0) {
> +		netif_info(priv, link, ndev, "link is up\n");
> +		netif_carrier_on(ndev);
> +	} else if (state == 0) {
> +		netif_info(priv, link, ndev, "link is down\n");
> +		netif_carrier_off(ndev);
> +	}
> +
> +	mutex_unlock(&priv->link_lock);
> +}

[Severity: Medium]
What happens to the carrier state when the PHYCFGR read fails here?

w5500_get_phycfgr_lnk() returns a negative errno on SPI failure, but
w5500_report_carrier_state() only acts on state > 0 and state == 0, and it
returns void, so the error is neither acted on nor propagated.

The carrier is forced off beforehand (netif_carrier_off() in w5100_probe()
for the link_irq case, and in w5100_stop()/w5100_suspend()), and
w5100_open() samples the state exactly once:

	if (priv->link_irq > 0) {
		w5500_report_carrier_state(ndev);
		enable_irq(priv->link_irq);
	}

	return 0;

Since w5100_open() still returns 0 and the link IRQ is edge triggered
(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING), no further event arrives while
the link stays up.  Can a single failed read at open (or resume, or restart)
therefore leave the netdev permanently without carrier, with dev_activate()
refusing to leave noop_qdisc and dev_watchdog() skipping the device, until
the cable is toggled or the interface is cycled?  Meanwhile w5500_get_link()
re-reads the register and keeps reporting "Link detected: yes".

> +
> +static irqreturn_t w5500_detect_link_interrupt(int irq, void *ndev_instance)
> +{
> +	struct net_device *ndev = ndev_instance;
> +
> +	if (netif_running(ndev))
> +		w5500_report_carrier_state(ndev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static u32 w5500_get_link(struct net_device *ndev)
> +{
> +	struct w5100_priv *priv = netdev_priv(ndev);
> +	int state;
> +	bool link;
> +
> +	mutex_lock(&priv->link_lock);
> +
> +	if (!netif_device_present(ndev)) {
> +		link = netif_carrier_ok(ndev);
> +		goto out;
> +	}
> +
> +	state = w5500_get_phycfgr_lnk(ndev);
> +
> +	if (state < 0) {
> +		link = netif_carrier_ok(ndev);
> +		goto out;
> +	}
> +
> +	link = state > 0;
> +
> +out:
> +	mutex_unlock(&priv->link_lock);
> +
> +	return link;
> +}

[Severity: Low]
This isn't a bug as such, since the commit message documents the intent, but
for a w5500 board whose DT has no second (LINKLED) interrupt the two link
uAPIs end up permanently disagreeing.

w5100_probe() installs the new ops for every w5500:

	ndev->ethtool_ops = ops->chip_id == W5500 ? &w5500_ethtool_ops :
						    &w5100_ethtool_ops;

so ethtool reports the real PHYCFGR bit, while every netif_carrier_on|off()
call in this patch (including the netif_carrier_off() in probe) sits inside
an if (priv->link_irq > 0) block.

With the carrier bit never touched, netif_carrier_ok() stays true (nothing
in net/core sets __LINK_STATE_NOCARRIER at registration).  Would it be
better to only publish .get_link when the driver can also maintain the
carrier, so that ip link and ETHTOOL_GLINK cannot report IFF_LOWER_UP and
"Link detected: no" at the same time?

[ ... ]

> @@ -656,9 +744,16 @@ static int w5100_open(struct net_device *ndev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	netif_info(priv, ifup, ndev, "enabling\n");
> -	w5100_hw_start(priv);
>  	napi_enable(&priv->napi);
> +	enable_irq(priv->irq);
> +	w5100_hw_start(priv);
>  	netif_start_queue(ndev);
> +
> +	if (priv->link_irq > 0) {
> +		w5500_report_carrier_state(ndev);
> +		enable_irq(priv->link_irq);
> +	}
> +
>  	return 0;
>  }

[Severity: Medium]
Can a link transition be missed here because PHYCFGR is sampled before the
edge triggered IRQ is enabled?

The same read-then-enable order is used in w5100_restart() and
w5100_resume().  The IRQ is requested with

	IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
	IRQF_NO_AUTOEN

so at open the enable_irq() is the initial irq_startup(): the flow handler
has never run, no IRQS_PENDING state exists in the irq_desc for the core to
resend, and replay of an edge that happened while the line was masked
depends on the irqchip latching it (GPIO controllers such as bcm2835 clear
the per-line edge enable bits on mask, so nothing is recorded).

A transition inside the window between the read and enable_irq() would then
be seen by neither, leaving the carrier stale until the next physical
change.  Would enabling the IRQ first and reading PHYCFGR afterwards be
safe, given that w5500_report_carrier_state() is idempotent and serialized
by priv->link_lock?  The v7 changelog entry ("Enable the link IRQ before
reading the PHYCFGR bit") suggests this order was intentional at some point.

>  
> @@ -667,13 +762,38 @@ static int w5100_stop(struct net_device *ndev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	netif_info(priv, ifdown, ndev, "shutting down\n");
> +
> +	disable_irq(priv->irq);
> +	if (priv->link_irq > 0)
> +		disable_irq(priv->link_irq);
> +
> +	cancel_work_sync(&priv->restart_work);
> +	cancel_work_sync(&priv->setrx_work);
> +	flush_work(&priv->rx_work);
> +	flush_work(&priv->tx_work);
> +
>  	w5100_hw_close(priv);

[Severity: High]
Can flush_work(&priv->rx_work) block here indefinitely, since it now runs
before w5100_hw_close() stops the producer of receive traffic?

disable_irq() stops interrupt handling, but socket 0 is still open and the
chip keeps filling its 16 KB RX buffer.  The worker drains without a budget
or a shutdown check:

drivers/net/ethernet/wiznet/w5100.c:w5100_rx_work() {
	while ((skb = w5100_rx_skb(priv->ndev)))
		netif_rx(skb);

	w5100_enable_intr(priv);
}

and w5100_rx_skb() only returns NULL once the hardware buffer reads empty:

	u16 rx_buf_len = w5100_read16(priv, W5100_S0_RX_RSR(priv));

	if (rx_buf_len == 0)
		return NULL;

The SPI drain rate is well below the wire rate, so an adjacent sender
flooding the link can keep RSR non-zero for as long as it likes.

ndo_stop runs under RTNL, so would "ip link set dev down" (and
unregister_netdev() from w5100_remove(), which now runs first) stall with
RTNL held, blocking all other network configuration?  Closing the hardware
before flushing rx_work, as the previous code did, would avoid this.

> -	netif_carrier_off(ndev);
> +
> +	if (priv->link_irq > 0)  {
> +		mutex_lock(&priv->link_lock);
> +		netif_carrier_off(ndev);
> +		mutex_unlock(&priv->link_lock);
> +	}
> +

[Severity: Medium]
Making this netif_carrier_off() conditional, together with the new carrier
sampling in w5100_open()/w5100_resume(), looks like it also repairs an
existing user visible breakage.  Should that be split out with a Fixes: tag?

In the baseline tree, dacf281771a9 ("w5100: remove unused gpio link
detection") removed w5100_get_link()/w5100_detect_link() and both
netif_carrier_on() call sites, but kept the unconditional
netif_carrier_off() in w5100_stop() and w5100_suspend().  git grep
netif_carrier_on on the baseline returns no match in this driver.

A freshly registered netdev has __LINK_STATE_NOCARRIER clear, so the first
ifup works, but after the first ifdown (or suspend cycle) the bit is set and
nothing ever clears it again, and dev_activate() takes the "Delay activation
until next carrier-on event" path, so the interface cannot transmit until
the module is reloaded.

As written, the fix is buried in a feature patch that also rewrites probe
ordering, IRQ enable/disable and work cancellation, which makes it hard to
pick up for stable.

>  	netif_stop_queue(ndev);
>  	napi_disable(&priv->napi);
>  	return 0;
>  }
>  
> +static const struct ethtool_ops w5500_ethtool_ops = {
> +	.get_drvinfo		= w5100_get_drvinfo,
> +	.get_msglevel		= w5100_get_msglevel,
> +	.set_msglevel		= w5100_set_msglevel,
> +	.get_link		= w5500_get_link,
> +	.get_regs_len		= w5100_get_regs_len,
> +	.get_regs		= w5100_get_regs,
> +};
> +

[ ... ]

> @@ -839,9 +997,20 @@ static int w5100_suspend(struct device *dev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	if (netif_running(ndev)) {
> -		netif_carrier_off(ndev);
> +		disable_irq(priv->irq);
> +		if (priv->link_irq > 0)
> +			disable_irq(priv->link_irq);
> +
> +		cancel_work_sync(&priv->restart_work);
> +
>  		netif_device_detach(ndev);

[Severity: Medium]
The commit message says:

    w5100_remove(), w5100_stop() and w5100_suspend() call
    cancel_work_sync()/flush_work() to make sure there is no pending
    work

but w5100_suspend() only drains restart_work.  w5100_stop() and
w5100_remove() drain all four (restart_work, setrx_work, rx_work, tx_work).
Could the changelog be adjusted, or the suspend path made to match?

[Severity: High]
Does leaving setrx_work, rx_work and tx_work pending here allow the chip to
be re-armed after w5100_hw_close()?

disable_irq()/synchronize_irq() waits for the threaded handler only, not for
work already queued on priv->xfer_wq:

w5100_interrupt()      -> queue_work(priv->xfer_wq, &priv->rx_work)
w5100_start_tx()       -> queue_work(priv->xfer_wq, &priv->tx_work)
w5100_set_rx_mode()    -> schedule_work(&priv->setrx_work)

A pending w5100_rx_work() ends with w5100_enable_intr(), re-arming
W5500_SIMR / W5100_IMR; w5100_setrx_work() calls w5100_hw_start(), which
issues S0_CR_OPEN and enables interrupts again; w5100_tx_work() can program
S0_TX_WR and issue S0_CR_SEND.

Any of these can run concurrently with, or after, the w5100_hw_close() a few
lines below, so the controller can stay open with socket interrupts armed
for the whole suspend while the CPU IRQ is disabled, and the SPI transfers
are issued after the device was marked absent.  All in-tree ops set
may_sleep = true, so this is the live path.  Would replicating the
w5100_stop() sequence here be appropriate?

[Severity: Medium]
Can restart_work be re-queued after this cancel_work_sync(), because the
cancel happens before netif_device_detach()?

In that window the device is still running, still present, and (for the
link IRQ case) still carrier-ok, and the tx watchdog timer is not lowered on
the suspend path.  On the dev_close() path, dev_deactivate_many() calls
netdev_watchdog_down() before ndo_stop, which is what makes the same
ordering safe in w5100_stop().

dev_watchdog() only requires:

net/sched/sch_generic.c:dev_watchdog() {
		if (netif_device_present(dev) &&
		    netif_running(dev) &&
		    netif_carrier_ok(dev)) {
	...
}

and w5100_tx_timeout() is now unconditional:

	schedule_work(&priv->restart_work);

The re-queued w5100_restart() would then pass its

	if (!netif_running(ndev) || !netif_device_present(ndev))
		return;

test, since nothing serializes that check with netif_device_detach(), and
proceed to w5100_hw_reset(), enable_irq(priv->irq), w5100_hw_start() and the
PHYCFGR read, concurrently with the w5100_hw_close() below.  Would detaching
first and cancelling afterwards close this?

>  
> +		if (priv->link_irq > 0) {
> +			mutex_lock(&priv->link_lock);
> +			netif_carrier_off(ndev);
> +			mutex_unlock(&priv->link_lock);
> +		}
> +
>  		w5100_hw_close(priv);
>  	}
>  	return 0;

[Severity: Medium]
Same observation as in w5100_stop(): this suspend path previously called
netif_carrier_off() with no matching netif_carrier_on() anywhere in the
driver, so a suspend/resume cycle left the interface stuck without carrier.
The repair is welcome, but it is not called out in the changelog and there
is no Fixes: tag referencing dacf281771a9.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-wiznet-link-gpio-v10-0-5874a7a147a2%40marmottus.net
