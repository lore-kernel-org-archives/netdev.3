Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B94B0E58;
	Thu, 17 Sep 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675736; cv=none; b=uMtsb7wZYL535nofo61SL5O3CHh8hBNqhPkK5+5FF6Vn88SmDWyAUld8lW5ekz0M9c0B5sAIjAPjW2AzWfDAk8OeXSEMYcolvbg1K2ndMtnsmirXB5dpGIetduoe3hQKKjlpcLOLjW9Rjj+vB0UJic4rgxABiMLXQ75IfDP9Ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675736; c=relaxed/simple;
	bh=u7QR7V0OJNVy5bFyru3FKBiBQ/5LrouKvLhfgcdaTVs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POpePQsevxZ7Yx0imSKL9NlCbEK4PBd363AnQRDooWRtszbFqskOF3hDVMIta/Wf+5fr6vxBaQrYNl7Q90F0szjUPOAISMpeh9W/aN64PTuGgHGcvk3waTckdf0SpD0QdsD3/NCUqBCgMIOLZarHjkPV23o89hc/qD/TxYr5zjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBfkFpoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBfkFpoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AA01F00898;
	Thu, 17 Sep 2026 20:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789675733;
	bh=+Sn08GwIylBel3Bt292Ry+rmSKZIvt90pd0HLazDIwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CBfkFpojfCOA/ZqX/yy+usiu5XPBwYdX+WZG4cMcRggXFtGqQtv/1eoCJxfNEnFiD
	 GkxOTJF7CWc2BEDOr1dc/ffYMwhs82I4UoHiYDheiNXmzQTyFdoz001ncEERtJVyAM
	 OQ3O0KoFMDVTKp6DiQq4QDABn/gMxRr4TSuou7Hq5gUEKmh7ZWvRc8qcu0UcUl4sMG
	 OKHvAmNtyafxoVNa5bgM3wgtlIZi++Y7Y9mWk8fdiPlLrNEapAafQR6onuQz6Kklmy
	 nQiepk1EBD/STSiEJAlJSwA+gIqErsJ3uFmIgZgac///2wTQ+LIYnyOvBn6pcTdJ00
	 S57iR1cYUUOHw==
Subject: Re: [PATCH net-next v8 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 20:08:52 +0000
Message-ID: <178967573220.22033.14908658366180861063@kernel.org>
In-Reply-To: <20260915-wiznet-link-gpio-v8-3-d173622474cc@marmottus.net>
References: <20260915-wiznet-link-gpio-v8-3-d173622474cc@marmottus.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 5 · Low: 0

- [High] w5100_remove() now calls unregister_netdev() (line 956) *before*
  draining rx_work/tx_work (lines 958-961) and before…
- [Medium] The commit message body describes only the link-detection
  feature plus three restructuring notes (netdev registered last,…
- [Medium] The patch silently repairs a real, user-visible carrier
  regression introduced by dacf281771a9 ("w5100: remove unused gpio link…
- [Medium] In w5100_suspend(), cancel_work_sync(&priv->restart_work)
  (line 992) runs only *after* netif_carrier_off() (line 986) and…
- [Medium] The newly added cancel_work_sync(&priv->tx_work) in
  w5100_remove() (line 959) can cancel a tx_work item that has not…
- [Medium] w5500_report_carrier_state() deliberately leaves the carrier
  untouched when the PHYCFGR read fails (state < 0), and there is no…

--

w5100: detect carrier state using link status bit and optional interrupt

This adds link detection for the w5500 by reading the Link Status bit of
PHYCFGR, exposes it through a w5500 specific ethtool get_link callback, and
optionally requests a second (LINKLED) interrupt to update the carrier
state.  It also reorders the probe and remove paths and adds work
cancellation in the stop, suspend and remove paths.

A few questions about the changes below.

The commit message describes the link detection feature plus three
restructuring notes:

  The carrier state (netif_carrier_on|off) is not called anymore on
  w5100/w5200 or w5500 without the link irq.

  Make sure that the netdev is registered last in the probe function so
  no operation can be performed before the probing is finished. dev_name
  is now used instead of netdev_name.

[Severity: Medium]
Should the message also mention the teardown changes that apply to all chip
variants, not just w5500 with a link interrupt?

Specifically, w5100_remove() now calls unregister_netdev() first, adds
cancel_work_sync() for rx_work and tx_work (which were never drained
explicitly before), converts the flush_work() of setrx_work/restart_work
into cancel_work_sync(), and moves w5100_hw_reset() to after free_irq().

w5100_stop() and w5100_suspend() gain cancel_work_sync(&priv->restart_work),
and w5100_restart() gains an unconditional early return on
!netif_running(ndev) which changes tx-timeout recovery on w5100/w5200 and
the MMIO parts that can never have a link interrupt.

These items appear only in the v8 changelog below the --- separator, which
is dropped when the patch is applied.

> diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
> index 53d8dc642fbd6..335bafbc9fa46 100644
> --- a/drivers/net/ethernet/wiznet/w5100.c
> +++ b/drivers/net/ethernet/wiznet/w5100.c

[ ... ]

> @@ -345,6 +352,67 @@ static void w5500_memory_configure(struct w5100_priv *priv)
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
Can a single failed PHYCFGR read leave the interface stuck with the carrier
off while the PHY is linked?

The negative case here intentionally leaves the carrier untouched, and there
is no retry, delayed re-read or polling fallback.  The previous value at the
two initial synchronisation points is off: w5100_probe() calls
netif_carrier_off() before register_netdev(), and w5100_suspend() forces the
carrier off.

The errors do reach here.  w5500_spi_read() in w5100-spi.c propagates SPI
failures:

	ret = spi_write_then_read(spi, cmd, sizeof(cmd), &data, 1);

	return ret ? ret : data;

so for example an -ENOMEM from the fallback allocation in
spi_write_then_read() ends up as a negative return of
w5500_get_phycfgr_lnk().

The only other refresh comes from LINKLED edges, requested with
IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.  If the link is already up and
stays up, the pin holds a constant level and no further edge is produced.

So if the read in w5100_open() or w5100_resume() fails once, does the carrier
stay off until the interface is manually taken down and brought back up,
with linkwatch keeping the qdisc deactivated in the meantime?  Would
re-arming a delayed PHYCFGR read on read failure address this?

[ ... ]

> @@ -448,12 +516,23 @@ static void w5100_restart(struct net_device *ndev)
>  {
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
> +	if (!netif_running(ndev))
> +		return;
> +
> +	if (priv->link_irq > 0)
> +		disable_irq(priv->link_irq);
> +
>  	netif_stop_queue(ndev);
>  	w5100_hw_reset(priv);
>  	w5100_hw_start(priv);
>  	ndev->stats.tx_errors++;
>  	netif_trans_update(ndev);
>  	netif_wake_queue(ndev);
> +
> +	if (priv->link_irq > 0) {
> +		w5500_report_carrier_state(ndev);
> +		enable_irq(priv->link_irq);
> +	}
>  }

[ ... ]

> @@ -667,13 +752,31 @@ static int w5100_stop(struct net_device *ndev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	netif_info(priv, ifdown, ndev, "shutting down\n");
> +
> +	cancel_work_sync(&priv->restart_work);
> +
> +	if (priv->link_irq > 0) {
> +		disable_irq(priv->link_irq);
> +		mutex_lock(&priv->link_lock);
> +		netif_carrier_off(ndev);
> +		mutex_unlock(&priv->link_lock);
> +	}
> +
>  	w5100_hw_close(priv);
> -	netif_carrier_off(ndev);
>  	netif_stop_queue(ndev);
>  	napi_disable(&priv->napi);
>  	return 0;
>  }

[Severity: Medium]
Making netif_carrier_off() conditional on priv->link_irq here (and the same
change in w5100_suspend()) looks like it also fixes an existing carrier
regression.  Should this carry a Fixes: tag for dacf281771a9 ("w5100: remove
unused gpio link detection")?

dacf281771a9 removed the only netif_carrier_on() calls, which lived in
w5100_open() and w5100_resume(), but left the unconditional
netif_carrier_off() in w5100_stop() and w5100_suspend().  On the baseline,
w5100_open() has no carrier call at all, so:

	ip link set dev eth0 down
	ip link set dev eth0 up

leaves every w5100/w5200/w5500 reporting no carrier, and linkwatch keeps the
qdisc deactivated.  A suspend/resume cycle has the same effect.

Without a Fixes: tag this fix will not be picked up for stable, so released
kernels keep the unusable-after-ifdown/ifup behaviour.

[ ... ]

> @@ -820,14 +953,22 @@ void w5100_remove(struct device *dev)
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
> -	w5100_hw_reset(priv);
> +	unregister_netdev(ndev);
> +
> +	cancel_work_sync(&priv->rx_work);
> +	cancel_work_sync(&priv->tx_work);
> +	cancel_work_sync(&priv->setrx_work);
> +	cancel_work_sync(&priv->restart_work);
> +
> +	if (priv->link_irq > 0)
> +		free_irq(priv->link_irq, ndev);
> +
>  	free_irq(priv->irq, ndev);
> +	w5100_hw_reset(priv);

[Severity: High]
Can rx_work still run after unregister_netdev() here and hand an skb to
netif_rx() with a dangling ndev?

w5100_stop(), which runs from dev_close() inside unregister_netdev(), does
not cancel or flush rx_work:

	cancel_work_sync(&priv->restart_work);
	...
	w5100_hw_close(priv);
	netif_stop_queue(ndev);
	napi_disable(&priv->napi);

so an rx_work item queued just before the close can run afterwards:

w5100_rx_work()
	while ((skb = w5100_rx_skb(priv->ndev)))
		netif_rx(skb);

	w5100_enable_intr(priv);

netif_rx() takes no device reference, and unregister_netdev() has already
done flush_all_backlogs() and netdev_run_todo().  If that skb sits in a
deferred or RPS-remote backlog, is it dereferenced after the free_netdev() a
few lines below?

The main interrupt is also still registered while the cancel_work_sync()
calls run:

w5100_interrupt()
	if (ir & S0_IR_RECV) {
		w5100_disable_intr(priv);

		if (priv->ops->may_sleep)
			queue_work(priv->xfer_wq, &priv->rx_work);

so an in-flight handler can re-queue rx_work after the cancellation.  That
late work then touches chip registers concurrently with the w5100_hw_reset()
above and calls w5100_enable_intr() after the handler has been freed.

Before this patch, destroy_workqueue() drained rx_work while the netdev was
still registered and after free_irq(), so neither case could happen.  Would
freeing and synchronizing both interrupts first, then draining all work they
can produce, and only then resetting the hardware and
unregistering/freeing the netdev, be the right order?

[Severity: Medium]
Does the new cancel_work_sync(&priv->tx_work) leak priv->tx_skb?

w5100_start_tx() takes ownership of the skb and defers the free entirely to
the work item:

	if (priv->ops->may_sleep) {
		WARN_ON(priv->tx_skb);
		priv->tx_skb = skb;
		queue_work(priv->xfer_wq, &priv->tx_work);

and w5100_tx_work() is the only consumer that clears priv->tx_skb and frees
it via w5100_tx_skb() -> dev_kfree_skb():

	struct sk_buff *skb = priv->tx_skb;

	priv->tx_skb = NULL;

	if (WARN_ON(!skb))
		return;
	w5100_tx_skb(priv->ndev, skb);

If cancel_work_sync() cancels a work item that has not started yet, nothing
releases priv->tx_skb, and remove() continues to destroy_workqueue() and
free_netdev() with it still set.  The previous code reached the same state
through destroy_workqueue(), which drains queued work instead of cancelling
it, so the skb was always freed.  Would freeing priv->tx_skb explicitly
after the cancellation, or flushing tx_work instead, be preferable?

>  
> -	flush_work(&priv->setrx_work);
> -	flush_work(&priv->restart_work);
>  	destroy_workqueue(priv->xfer_wq);
> +	mutex_destroy(&priv->link_lock);
>  
> -	unregister_netdev(ndev);
>  	free_netdev(ndev);
>  }
>  EXPORT_SYMBOL_GPL(w5100_remove);
> @@ -839,9 +980,17 @@ static int w5100_suspend(struct device *dev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	if (netif_running(ndev)) {
> -		netif_carrier_off(ndev);
> +		if (priv->link_irq > 0) {
> +			disable_irq(priv->link_irq);
> +			mutex_lock(&priv->link_lock);
> +			netif_carrier_off(ndev);
> +			mutex_unlock(&priv->link_lock);
> +		}
> +
>  		netif_device_detach(ndev);
>  
> +		cancel_work_sync(&priv->restart_work);
> +
>  		w5100_hw_close(priv);
>  	}
>  	return 0;

[Severity: Medium]
Should the cancel_work_sync() come before netif_carrier_off() and
netif_device_detach() rather than after them, as it does in w5100_stop()?

restart_work can be queued at any time on w5500/SPI:

w5100_tx_timeout()
	if (priv->ops->may_sleep)
		schedule_work(&priv->restart_work);

A work item that is pending or already running when suspend starts still
passes the new guard in w5100_restart(), because netif_running() stays true
through the suspend callback and the guard does not test
netif_device_present():

	if (!netif_running(ndev))
		return;

It then re-runs w5100_hw_reset()/w5100_hw_start(), re-enabling chip
interrupts and re-opening socket 0, calls netif_wake_queue() which clears the
__QUEUE_STATE_DRV_XOFF that netif_device_detach() just set, and calls
w5500_report_carrier_state() which can turn the carrier back on right after
suspend cleared it.

With the tx queue runnable again and __dev_queue_xmit() not testing
netif_device_present(), can the stack then reach w5100_start_tx() and issue
SPI transfers to a chip whose socket w5100_hw_close() has closed, or to an
already suspended SPI controller?  Would moving the cancellation ahead of the
state changes, and/or widening the guard in w5100_restart(), close this?

>  
> @@ -857,6 +1006,11 @@ static int w5100_resume(struct device *dev)
>  		w5100_hw_start(priv);
>  
>  		netif_device_attach(ndev);
> +
> +		if (priv->link_irq > 0) {
> +			w5500_report_carrier_state(ndev);
> +			enable_irq(priv->link_irq);
> +		}
>  	}
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-wiznet-link-gpio-v8-0-d173622474cc%40marmottus.net
