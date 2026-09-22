Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848355C330;
	Tue, 22 Sep 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091816; cv=none; b=XdgnTFcwEtHPqpOw2P7ZvjGhO9Qj237CKJEyY1aRA2uuuBkRzEFCp1VsGXnCsGeuVpJTK/KlMhCi6vTmA6C7PWE2ExOD4z6biJncSABufZBaluUbxmFJ9YCsdGJTPBwSljkwGKLFtdPsCXC9J/JkOBpAqBsWuUgV3Hx14OvkErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091816; c=relaxed/simple;
	bh=z4NdSFDuNGVI597MDXLguyEDoV9x60podj//kOFM5gg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDLT20Uetlyd4Kgvf+RfPBtyNUsQPjQMj8GuhsNnI5hoAuATIqgbaTU3rpOEgyS65zqcrhxNT3vdVNnpVPg3bj30ND0TwdhOqj22j6tpGOLVtfiZ8y3fO4ywLdFHTa6KeP69IXa+w0Un3+TkW6kGI9VzjNZAWofnwbL2J6XJS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPCb2dxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPCb2dxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B71F00893;
	Tue, 22 Sep 2026 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091807;
	bh=ISUSffucPB0qD9ReW/OifIPAtckZSXhpko4VRsVYfk4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aPCb2dxPV3JVJkwmJLwp+YjAt584RQYkIoWdXOoAm8l75cJuUwlz6L9UeUz1piMCm
	 8Xn3ppoN1tN+BqcvQTgt8dLf2Py+Ak2bNtIx029vnuc0QkqjYeLa5VFBd8EelxCzAf
	 aHHxiHjrXzUvZ0vhP0JfJQ5EmLaUsX2qKg9b5FmrWXZGoukT8kEsZfJ8azpcRdehSe
	 HnWbhXMgmoTA5/y3RZ1gxcegnl3ASdVt5r6uWvCkAWJXJ8wx6qCX28ma18PurxOkWa
	 aLoIzW61AtCFbf4bThdvDHr9sv082eIpiLn4hMlIVn6TNJ6YfFPmJPytp9947w9TDl
	 zwOImF0YEglqw==
Subject: Re: [PATCH net-next v9 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
From: netdev-bot+sashiko@kernel.org
To: arthur@marmottus.net
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 15:43:26 +0000
Message-ID: <179009180606.2160803.9423654885662355459@kernel.org>
In-Reply-To: <20260918-wiznet-link-gpio-v9-3-5536f24d8d6d@marmottus.net>
References: <20260918-wiznet-link-gpio-v9-3-5536f24d8d6d@marmottus.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 5 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] w5100_suspend() does not quiesce three of the four work items,
  so hardware access continues after (or concurrently with) the suspend-…
- [High] w5100_stop() newly calls flush_work(&priv->rx_work)
  (w5100.c:775) *before* w5100_hw_close() (w5100.c:778), i.e. while…
- [Medium] The patch silently fixes a long-standing user-visible bug
  without saying so and without a Fixes: tag.
- [Medium] The commit message states 'w5100_remove(), w5100_stop() and
  w5100_suspend() call cancel_work_sync()/flush_work() to make sure…
- [Medium] w5500_report_carrier_state() (w5100.c:369-386) silently
  discards a PHYCFGR read failure: w5500_get_phycfgr_lnk() returns the…
- [Medium] The driver samples PHYCFGR *before* enabling the edge-
  triggered LINKLED interrupt, so a link transition occurring in that…
- [Medium] net: w5100: sleep in atomic context in w5100_restart()

--

w5100: detect carrier state using link status bit and optional interrupt

This adds carrier detection for the w5500 by reading the Link Status bit of
PHYCFGR, exposed through a new w5500 specific ethtool .get_link and updated
from an optional second interrupt wired to the LINKLED pin. It also reworks
the probe/remove ordering, adds a mutex around the link state, and
enables/disables the main irq in open/stop and suspend/resume.

> diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
> index 53d8dc642fbd..e6dc5fe7c088 100644
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
When w5500_get_phycfgr_lnk() returns a negative errno, neither branch runs
here, so the carrier is left untouched and the failure is not reported to the
caller either.

w5500_get_phycfgr_lnk() forwards the error from w5500_spi_read(), which
propagates spi_write_then_read() failures.

In w5100_open() the carrier bit has just been forced off (probe calls
netif_carrier_off() when a link irq is present, and w5100_stop() clears it
as well), so a single failed PHYCFGR read leaves the interface latched at
NO-CARRIER while w5100_open() still returns 0. The same applies to
w5100_resume() after w5100_suspend() cleared the carrier.

The link irq is requested edge triggered, so with a stable physical link no
further edge arrives. Is there any path that would correct the state short
of a cable flap or an ifdown/ifup? Should the read error be retried or
propagated to the caller?

Note ethtool .get_link re-reads the register, so it can report link detected
while operstate stays down.

> [ ... ]
>  static int w5100_hw_reset(struct w5100_priv *priv)
>  {
>  	u32 rtr;
> @@ -448,12 +526,25 @@ static void w5100_restart(struct net_device *ndev)
>  {
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
> +	if (!netif_running(ndev) || !netif_device_present(ndev))
> +		return;
> +
> +	disable_irq(priv->irq);
> +	if (priv->link_irq > 0)
> +		disable_irq(priv->link_irq);
> +
>  	netif_stop_queue(ndev);
>  	w5100_hw_reset(priv);
> +	enable_irq(priv->irq);
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
>  
>  static void w5100_restart_work(struct work_struct *work)
> @@ -656,9 +747,16 @@ static int w5100_open(struct net_device *ndev)
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
w5100_restart() is not always reached from process context.
w5100_tx_timeout() only defers to restart_work when priv->ops->may_sleep
is set:

	if (priv->ops->may_sleep)
		schedule_work(&priv->restart_work);
	else
		w5100_restart(ndev);

and the memory mapped ops in this same file (w5100_mmio_direct_ops /
w5100_mmio_indirect_ops) set .may_sleep = false, so for those the
function is called directly from ndo_tx_timeout, i.e. from dev_watchdog()
in softirq context.

This hunk now puts sleeping calls on that path. disable_irq() begins with
might_sleep() and then synchronize_irq(), and when a link irq is present
w5500_report_carrier_state() takes priv->link_lock via mutex_lock().
Either one is a scheduling while atomic BUG, not just a lockdep
complaint.

The mutex part is confined to W5500, since priv->link_irq is only queried
for that chip and W5500 is SPI attached with may_sleep true, but the
disable_irq(priv->irq) / enable_irq(priv->irq) pair is unconditional and
is executed by every may_sleep == false user.

What is the intended split here - should w5100_tx_timeout() always queue
restart_work now that w5100_restart() can sleep, or should the irq
masking and the carrier re-check be done only in the may_sleep path?

[Severity: Medium]
The link irq is requested below with IRQF_NO_AUTOEN and
IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, so it stays masked until this
enable_irq(). PHYCFGR is sampled first and edge detection is only turned on
afterwards:

	w5500_report_carrier_state(ndev);	/* reads PHYCFGR */
	enable_irq(priv->link_irq);		/* edge detection starts */

If the PHY link comes up between those two steps, can that transition be
lost for good? On the BCM2835 controller used in the binding's own example,
masking disables edge detection and also discards latched events:

drivers/pinctrl/bcm/pinctrl-bcm2835.c:
	bcm2835_gpio_irq_config(pc, gpio, false);
	/* Clear events that were latched prior to clearing event sources */
	bcm2835_gpio_set_bit(pc, GPEDS0, gpio);

so unmasking does not replay the missed edge, and with a now stable LINKLED
level the driver keeps reporting carrier off until the next physical link
change.

w5100_restart() and w5100_resume() use the same order, and restart follows a
chip reset with PHY re-negotiation. The changelog lists this ordering as
intentional ("enable the link irq after checking PHYCFGR") - would enabling
the irq first and then reading PHYCFGR close the window?

>  
> @@ -667,13 +765,38 @@ static int w5100_stop(struct net_device *ndev)
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
flush_work(&priv->rx_work) now runs while socket 0 is still open, because
w5100_hw_close() is called after it.

w5100_rx_work() drains without a budget or a shutdown test:

	while ((skb = w5100_rx_skb(priv->ndev)))
		netif_rx(skb);

and w5100_rx_skb() only returns NULL once the hardware receive buffer is
observed empty:

	u16 rx_buf_len = w5100_read16(priv, W5100_S0_RX_RSR(priv));

	if (rx_buf_len == 0)
		return NULL;

disable_irq(priv->irq) masks the host interrupt but does not stop the
controller from filling its receive buffer. Each frame is drained with
several synchronous SPI transfers, which is slower than line rate, so can
sustained incoming traffic keep RX_RSR non-zero and make this flush_work()
never return?

ndo_stop runs with rtnl held, so an ip link set down would then stall all
network configuration in an unkillable wait. w5100_remove() reaches the same
path through unregister_netdev().

Would calling w5100_hw_close() before flushing rx_work avoid this?

> -	netif_carrier_off(ndev);
> +
> +	if (priv->link_irq > 0)  {
> +		mutex_lock(&priv->link_lock);
> +		netif_carrier_off(ndev);
> +		mutex_unlock(&priv->link_lock);
> +	}
> +
>  	netif_stop_queue(ndev);
>  	napi_disable(&priv->napi);
>  	return 0;
>  }

[Severity: Medium]
Making this netif_carrier_off() conditional on a link irq also fixes a
pre-existing user visible problem, but that is not called out and there is
no Fixes: tag.

Before this patch, w5100_stop() and w5100_suspend() called
netif_carrier_off() unconditionally, and there was no netif_carrier_on()
anywhere in drivers/net/ethernet/wiznet/. Since net_device state starts with
NOCARRIER clear at registration, an interface came up with carrier on, but
after the first

	ip link set dev ethX down
	ip link set dev ethX up

or after a suspend/resume cycle it stayed NO-CARRIER permanently.

With both carrier_off calls now guarded by priv->link_irq > 0, and link_irq
only ever queried for W5500, that behaviour disappears for w5100/w5200 and
for a W5500 without the optional LINKLED irq.

The changelog only says:

  The carrier state is also not reported using netif_carrier_on|off().

which reads as a description of the new design rather than a fix. Could this
be split into its own patch with a Fixes: tag so it can be picked up for
stable independently of the new feature?

> [ ... ]
> @@ -794,22 +926,44 @@ int w5100_probe(struct device *dev, const struct w5100_ops *ops,
>  
>  	if (ops->may_sleep) {
>  		err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -					   netdev_name(ndev), ndev);
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> +					   IRQF_NO_AUTOEN,
> +					   dev_name(dev), ndev);
>  	} else {
>  		err = request_irq(priv->irq, w5100_interrupt,
> -				  IRQF_TRIGGER_LOW, netdev_name(ndev), ndev);
> +				  IRQF_TRIGGER_LOW | IRQF_NO_AUTOEN, dev_name(dev), ndev);
>  	}
>  	if (err)
>  		goto err_hw;
>  
> +	if (priv->link_irq > 0) {
> +		err = request_threaded_irq(priv->link_irq, NULL,
> +					   w5500_detect_link_interrupt,
> +					   IRQF_TRIGGER_RISING |
> +					   IRQF_TRIGGER_FALLING |
> +					   IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					   "w5100-link", ndev);
> +		if (err < 0)
> +			goto err_irq;
> +
> +		netif_carrier_off(ndev);
> +	}

[ ... ]

> @@ -839,7 +998,18 @@ static int w5100_suspend(struct device *dev)
>  	struct w5100_priv *priv = netdev_priv(ndev);
>  
>  	if (netif_running(ndev)) {
> -		netif_carrier_off(ndev);
> +		disable_irq(priv->irq);
> +		if (priv->link_irq > 0)
> +			disable_irq(priv->link_irq);
> +
> +		cancel_work_sync(&priv->restart_work);

[Severity: Medium]
The changelog states:

  w5100_remove(), w5100_stop() and w5100_suspend() call
  cancel_work_sync()/flush_work() to make sure there is no pending
  work

but w5100_suspend() only cancels restart_work here. setrx_work (queued with
schedule_work() from w5100_set_rx_mode()), rx_work (queued on priv->xfer_wq
from w5100_interrupt()) and tx_work (queued from w5100_start_tx()) are
neither cancelled nor flushed, while w5100_stop() drains all four. Should
the changelog be narrowed, or the suspend path made to match stop()?

[Severity: High]
Independently of the changelog wording, can these work items still touch the
hardware after suspend has closed it?

disable_irq(priv->irq) waits for the threaded handler w5100_interrupt() to
finish, but any rx_work it already queued is still pending, and
priv->xfer_wq is created with WQ_MEM_RECLAIM | WQ_PERCPU (no WQ_FREEZABLE),
so it keeps running during suspend. w5100_rx_work() does SPI register
accesses (S0_RX_RD writes and S0_CR_RECV) and ends with:

	w5100_enable_intr(priv);

which re-arms the chip interrupt masks that w5100_hw_close() cleared, while
the host irq stays masked.

setrx_work runs on system_wq and calls w5100_hw_start(), re-issuing
S0_CR_OPEN and w5100_enable_intr() after suspend closed socket 0. tx_work
can still issue S0_CR_SEND. Any of these transfers issued after the suspend
callback returns are rejected once the SPI controller itself is suspended.

There is also a re-queue window: restart_work is cancelled here, before
netif_device_detach() below. In between, dev_watchdog() can still fire
(netif_device_present(), netif_running() and netif_carrier_ok() all hold,
and carrier_ok() is permanently true on w5100/w5200 and on a W5500 without a
link irq):

w5100_tx_timeout()
	if (priv->ops->may_sleep)
		schedule_work(&priv->restart_work);

The re-queued w5100_restart() then passes its own netif_running() /
netif_device_present() test and runs w5100_hw_reset() plus w5100_hw_start()
against the device suspend is closing.

Should netif_device_detach() come before the cancel, and should setrx_work,
rx_work and tx_work be drained here as they are in w5100_stop()?

> +
> +		if (priv->link_irq > 0) {
> +			mutex_lock(&priv->link_lock);
> +			netif_carrier_off(ndev);
> +			mutex_unlock(&priv->link_lock);
> +		}
> +
>  		netif_device_detach(ndev);
>  
>  		w5100_hw_close(priv);
> @@ -854,9 +1024,15 @@ static int w5100_resume(struct device *dev)
>  
>  	if (netif_running(ndev)) {
>  		w5100_hw_reset(priv);
> +		enable_irq(priv->irq);
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
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-wiznet-link-gpio-v9-0-5536f24d8d6d%40marmottus.net
