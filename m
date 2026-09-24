Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E85416853;
	Thu, 24 Sep 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238396; cv=none; b=lsAfg/oTv93fRkgH8qLxnKNTjWM/pNZgEss/L3GQLLbbsint1WilLExLxRECTArCIUlP7k3fd/UyHynCpYp0PQXu5a51WbriK18ULKgdrNE1+o7BMwMXKBnmknhMc1tPc1d3jOMSHG+DdrrqJaiRgRn4LmPsvEUqni1S24MYmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238396; c=relaxed/simple;
	bh=BRDlwTyyJkRN2BTw2CUN7uYkeJyBdEwCpyt5ZnHZASQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMuXXKndz7ZqEOkNHdsHaNwsIgk/DHJYAEDtDZJG4yEPJqMuIzWn+3wgFKhIFFaPdQYGfb81Ahi9Y+AVfSors1GEHPIrMqDH2GLW+ZihmJinC55WwYM9grWLyy3D06kFkHms5MJYzrJ7VmgJ/jg4n/JOezXPD3qME/RA3Nvdhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=m6Hd96Yr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="m6Hd96Yr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5A2A3EBB0;
	Thu, 24 Sep 2026 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790238390; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=4PlGIrCCrZl9tpd41pC+kG64/uPTPc4RFMBQwiX9fw4=;
	b=m6Hd96Yr16Bdd9E/MBwgkTGZo9xuNNoA1fqh2C7gHtjryH/G7W5c2dS6rSgKAOsf8j2KtM
	9eVrIaUpP+/7YA+V9HK6fOu9q4nCNblYSALy8Sye/Fhx7hn/o7KG2UX/eX7/f35LDqnl0s
	4B0jWhgp5UZ78Kr35MuhIj3YCoOs50nKMyIBaNhV3oYXrEo1mTwed/QVAZq3Vm7cXjErXZ
	UeDUtBZkOowcfHKpz2eflE4mAgukR0Khg7JBVLVUVkRgaDUq6UMAH7S/WSh2E6c7g2frHu
	3VQjoPO+/oogIyBki6kdV7fIPtMIVCbPBW7MVHDloeC26Xtr3yP7gp3ZKiFj6g==
Date: Thu, 24 Sep 2026 10:26:27 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Message-ID: <20260924082627.GA51120@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260921-wiznet-link-gpio-v10-3-5874a7a147a2@marmottus.net>
 <179021495594.2160803.16936851129108019714@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179021495594.2160803.16936851129108019714@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEmCnXx7c76lGCnQch+XQsI2AI2brFkMRbATZPCH48LLaurF1Is3yy53R0x0aKlhUw04ggt9L7Vzf2G9WH1Tmea7knTysw5XBzLPAQycE/oj5Jug8Fb4b86hLGpZWi8kx9bGZ13OJ3UjidF94KzIQIOHfPdck61kiAMQt5zDqpssnMAIwRm+T6HF/B7wOXfZcH6+qtvq/5t392/24yCTg+bJvwf6VnWPW43KkZvJk0GIqgrXOEg22IKuQ36oyxvTryOlhjDAydm9p1h7kqAq7RZqDZkmrYMC/+0JFi3VfIlShhDGDfXUqMAVFjUHlZ8te3bdEzlNPtV71KSL2j73uQ2GUk8GBtef8nAAyc3jv949WFHFW4YVUpX4q4e9huHR73qXV7coth1ggvqQrHPaLWcMZ5SA2eYHyySDCDLvJrE3POwz4OADrIwy1MXKG4aFYyfo54gmoTOMO9k9u4BiGH4NOACe8oVt7RsFUF6CYxpEmYRFLggoOLIxVdmMl2IDcSfOYneHAJNAIVbJKHokA5m7/lqL8fOvBDOg4B33r+oSslbpkCWdoXboe95ptyGAPdvm1YcWI/achR2Rjh7iwT+ag6e+7i7p54FO5/eGz1g6IUHr7Ud7md5/LiV9lAzXM1i3r58uDKWoWhOyM/haXlg8rNrrCrzTpzDW47yFUpHdQ

On Thu, Sep 24, 2026 at 01:55:55AM +0000, netdev-bot+sashiko@kernel.org wrote:
>[Severity: Medium]
>What happens to the carrier state when the PHYCFGR read fails here?
>
>w5500_get_phycfgr_lnk() returns a negative errno on SPI failure, but
>w5500_report_carrier_state() only acts on state > 0 and state == 0, and it
>returns void, so the error is neither acted on nor propagated.
>
>The carrier is forced off beforehand (netif_carrier_off() in w5100_probe()
>for the link_irq case, and in w5100_stop()/w5100_suspend()), and
>w5100_open() samples the state exactly once:
>
>	if (priv->link_irq > 0) {
>		w5500_report_carrier_state(ndev);
>		enable_irq(priv->link_irq);
>	}
>
>	return 0;
>
>Since w5100_open() still returns 0 and the link IRQ is edge triggered
>(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING), no further event arrives while
>the link stays up.  Can a single failed read at open (or resume, or restart)
>therefore leave the netdev permanently without carrier, with dev_activate()
>refusing to leave noop_qdisc and dev_watchdog() skipping the device, until
>the cable is toggled or the interface is cycled?  Meanwhile w5500_get_link()
>re-reads the register and keeps reporting "Link detected: yes".

I'll add a retry loop.


>[Severity: Low]
>This isn't a bug as such, since the commit message documents the intent, but
>for a w5500 board whose DT has no second (LINKLED) interrupt the two link
>uAPIs end up permanently disagreeing.
>
>w5100_probe() installs the new ops for every w5500:
>
>	ndev->ethtool_ops = ops->chip_id == W5500 ? &w5500_ethtool_ops :
>						    &w5100_ethtool_ops;
>
>so ethtool reports the real PHYCFGR bit, while every netif_carrier_on|off()
>call in this patch (including the netif_carrier_off() in probe) sits inside
>an if (priv->link_irq > 0) block.
>
>With the carrier bit never touched, netif_carrier_ok() stays true (nothing
>in net/core sets __LINK_STATE_NOCARRIER at registration).  Would it be
>better to only publish .get_link when the driver can also maintain the
>carrier, so that ip link and ETHTOOL_GLINK cannot report IFF_LOWER_UP and
>"Link detected: no" at the same time?
>

No but that's a fair point, .get_link() should probably be
implemented only on w5500 with a link irq.

>[ ... ]
>
>> @@ -656,9 +744,16 @@ static int w5100_open(struct net_device *ndev)
>>  	struct w5100_priv *priv = netdev_priv(ndev);
>>
>>  	netif_info(priv, ifup, ndev, "enabling\n");
>> -	w5100_hw_start(priv);
>>  	napi_enable(&priv->napi);
>> +	enable_irq(priv->irq);
>> +	w5100_hw_start(priv);
>>  	netif_start_queue(ndev);
>> +
>> +	if (priv->link_irq > 0) {
>> +		w5500_report_carrier_state(ndev);
>> +		enable_irq(priv->link_irq);
>> +	}
>> +
>>  	return 0;
>>  }
>
>[Severity: Medium]
>Can a link transition be missed here because PHYCFGR is sampled before the
>edge triggered IRQ is enabled?
>
>The same read-then-enable order is used in w5100_restart() and
>w5100_resume().  The IRQ is requested with
>
>	IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT |
>	IRQF_NO_AUTOEN
>
>so at open the enable_irq() is the initial irq_startup(): the flow handler
>has never run, no IRQS_PENDING state exists in the irq_desc for the core to
>resend, and replay of an edge that happened while the line was masked
>depends on the irqchip latching it (GPIO controllers such as bcm2835 clear
>the per-line edge enable bits on mask, so nothing is recorded).
>
>A transition inside the window between the read and enable_irq() would then
>be seen by neither, leaving the carrier stale until the next physical
>change.  Would enabling the IRQ first and reading PHYCFGR afterwards be
>safe, given that w5500_report_carrier_state() is idempotent and serialized
>by priv->link_lock?  The v7 changelog entry ("Enable the link IRQ before
>reading the PHYCFGR bit") suggests this order was intentional at some
>point.

I'll enable the irq before reporting the state.

>
>>
>> @@ -667,13 +762,38 @@ static int w5100_stop(struct net_device *ndev)
>>  	struct w5100_priv *priv = netdev_priv(ndev);
>>
>>  	netif_info(priv, ifdown, ndev, "shutting down\n");
>> +
>> +	disable_irq(priv->irq);
>> +	if (priv->link_irq > 0)
>> +		disable_irq(priv->link_irq);
>> +
>> +	cancel_work_sync(&priv->restart_work);
>> +	cancel_work_sync(&priv->setrx_work);
>> +	flush_work(&priv->rx_work);
>> +	flush_work(&priv->tx_work);
>> +
>>  	w5100_hw_close(priv);
>
>[Severity: High]
>Can flush_work(&priv->rx_work) block here indefinitely, since it now runs
>before w5100_hw_close() stops the producer of receive traffic?
>
>disable_irq() stops interrupt handling, but socket 0 is still open and the
>chip keeps filling its 16 KB RX buffer.  The worker drains without a budget
>or a shutdown check:
>
>drivers/net/ethernet/wiznet/w5100.c:w5100_rx_work() {
>	while ((skb = w5100_rx_skb(priv->ndev)))
>		netif_rx(skb);
>
>	w5100_enable_intr(priv);
>}
>
>and w5100_rx_skb() only returns NULL once the hardware buffer reads empty:
>
>	u16 rx_buf_len = w5100_read16(priv, W5100_S0_RX_RSR(priv));
>
>	if (rx_buf_len == 0)
>		return NULL;
>
>The SPI drain rate is well below the wire rate, so an adjacent sender
>flooding the link can keep RSR non-zero for as long as it likes.
>
>ndo_stop runs under RTNL, so would "ip link set dev down" (and
>unregister_netdev() from w5100_remove(), which now runs first) stall with
>RTNL held, blocking all other network configuration?  Closing the hardware
>before flushing rx_work, as the previous code did, would avoid this.

Yeah, I've had this suggestion when running Sashiko locally too. This
patch is a Pandora box or race conditions! But hopefully I figured it
out and it's fixed in v11.
I am really learning a lot along the way regarding the synchronization
of ndos and how the calls are made.

>
>> -	netif_carrier_off(ndev);
>> +
>> +	if (priv->link_irq > 0)  {
>> +		mutex_lock(&priv->link_lock);
>> +		netif_carrier_off(ndev);
>> +		mutex_unlock(&priv->link_lock);
>> +	}
>> +
>
>[Severity: Medium]
>Making this netif_carrier_off() conditional, together with the new carrier
>sampling in w5100_open()/w5100_resume(), looks like it also repairs an
>existing user visible breakage.  Should that be split out with a Fixes: tag?
>
>In the baseline tree, dacf281771a9 ("w5100: remove unused gpio link
>detection") removed w5100_get_link()/w5100_detect_link() and both
>netif_carrier_on() call sites, but kept the unconditional
>netif_carrier_off() in w5100_stop() and w5100_suspend().  git grep
>netif_carrier_on on the baseline returns no match in this driver.
>
>A freshly registered netdev has __LINK_STATE_NOCARRIER clear, so the first
>ifup works, but after the first ifdown (or suspend cycle) the bit is set and
>nothing ever clears it again, and dev_activate() takes the "Delay activation
>until next carrier-on event" path, so the interface cannot transmit until
>the module is reloaded.
>
>As written, the fix is buried in a feature patch that also rewrites probe
>ordering, IRQ enable/disable and work cancellation, which makes it hard to
>pick up for stable.

It still don't think it is a fix. The patch is bringing back the
interrupt and improves it but it is too much of a change to be called
a fix.

>[Severity: Medium]
>The commit message says:
>
>    w5100_remove(), w5100_stop() and w5100_suspend() call
>    cancel_work_sync()/flush_work() to make sure there is no pending
>    work
>
>but w5100_suspend() only drains restart_work.  w5100_stop() and
>w5100_remove() drain all four (restart_work, setrx_work, rx_work, tx_work).
>Could the changelog be adjusted, or the suspend path made to match?
>
>[Severity: High]
>Does leaving setrx_work, rx_work and tx_work pending here allow the chip to
>be re-armed after w5100_hw_close()?
>
>disable_irq()/synchronize_irq() waits for the threaded handler only, not for
>work already queued on priv->xfer_wq:
>
>w5100_interrupt()      -> queue_work(priv->xfer_wq, &priv->rx_work)
>w5100_start_tx()       -> queue_work(priv->xfer_wq, &priv->tx_work)
>w5100_set_rx_mode()    -> schedule_work(&priv->setrx_work)
>
>A pending w5100_rx_work() ends with w5100_enable_intr(), re-arming
>W5500_SIMR / W5100_IMR; w5100_setrx_work() calls w5100_hw_start(), which
>issues S0_CR_OPEN and enables interrupts again; w5100_tx_work() can program
>S0_TX_WR and issue S0_CR_SEND.
>
>Any of these can run concurrently with, or after, the w5100_hw_close() a few
>lines below, so the controller can stay open with socket interrupts armed
>for the whole suspend while the CPU IRQ is disabled, and the SPI transfers
>are issued after the device was marked absent.  All in-tree ops set
>may_sleep = true, so this is the live path.  Would replicating the
>w5100_stop() sequence here be appropriate?
>
>[Severity: Medium]
>Can restart_work be re-queued after this cancel_work_sync(), because the
>cancel happens before netif_device_detach()?
>
>In that window the device is still running, still present, and (for the
>link IRQ case) still carrier-ok, and the tx watchdog timer is not lowered on
>the suspend path.  On the dev_close() path, dev_deactivate_many() calls
>netdev_watchdog_down() before ndo_stop, which is what makes the same
>ordering safe in w5100_stop().
>
>dev_watchdog() only requires:
>
>net/sched/sch_generic.c:dev_watchdog() {
>		if (netif_device_present(dev) &&
>		    netif_running(dev) &&
>		    netif_carrier_ok(dev)) {
>	...
>}
>
>and w5100_tx_timeout() is now unconditional:
>
>	schedule_work(&priv->restart_work);
>
>The re-queued w5100_restart() would then pass its
>
>	if (!netif_running(ndev) || !netif_device_present(ndev))
>		return;
>
>test, since nothing serializes that check with netif_device_detach(), and
>proceed to w5100_hw_reset(), enable_irq(priv->irq), w5100_hw_start() and the
>PHYCFGR read, concurrently with the w5100_hw_close() below.  Would detaching
>first and cancelling afterwards close this?

I reworked all those in the upcoming v11. I really tried to figure out
all the edge cases.

Arthur
