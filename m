Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2944A7C95;
	Fri, 18 Sep 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733940; cv=none; b=NDldJQmmmwLpP9ZEw4+XRQVWdQ1yKL+0KsI3kBy+kWg5efbmv1mKD/Sa21b+DK7lqewSwWFDlwTVKpXcXbOPkguIBQDDHRXEzS1s9h5sogR6SRmFhFlYGzmEEeHrBoVSumH2iUr2dCCMNyQHC6zrf0VoOTfcgiuOgPKqgwk6GKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733940; c=relaxed/simple;
	bh=JfhqZh3CdZwE9Gz70/DgNXeiVZtqzRPeJI1oBADTp5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muBRbPxW0395jB64YbNABf4acgRQutVQd0CwRCTLjHswjqrntQHZmRvmfpa2cOya/e0AGAjtSiZhKmZas0FSIr3Q/ySUoKkRSPZyz0anJfTnsuAl2jMz+vKjWbp1P7dPLvUhtXAgJ2sdMLwVvfXNyH0gRY30V/Oui+vb6ZAZDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=ggrYxOoH; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="ggrYxOoH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D3D81F6AA;
	Fri, 18 Sep 2026 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1789733927; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=0v/KpntsYte0y2RxYlTW5mjU0ri4ImMFMwR0X1VOIO0=;
	b=ggrYxOoHFBn0RwTonrlABwu6gQ5D7w++v1At+6XrN4LFXJJui48lfLvpU3wtW7FA3S4dfU
	ZOXjL8OPkqz7iSfwfTas1+6GrvUlfx3c7gQv1xNPSZ19a6rZMOYBKbShnRQ6H8cpAnCzKx
	keXmur6aKorYxG7MQWv0p+T7dumT5/2BZRczEdUvBohaHoRIoyDzc6gqhJQqve1GwFq5Ad
	1PvdnTJHoAkMpfXgK5AdF0lHT2GPGmLnEV8/C1+uoakwmQpRl7Cgks2dTW7MtftM7b2KTZ
	4UHnsiu9lqWJkMfkdy99zTFplZmblRNCh+WJBRP6jvbXngn0ojT/zSNTJqPO8g==
Date: Fri, 18 Sep 2026 14:18:43 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Message-ID: <20260918121843.GB30413@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260915-wiznet-link-gpio-v8-3-d173622474cc@marmottus.net>
 <178967573220.22033.14908658366180861063@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178967573220.22033.14908658366180861063@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: 0
X-GND-Cause: dmFkZTFtLuTXSoGXMxHFX+8qCSiA0YRXf1kaXo9NDoDMnL2ogB1Ez1wmuSsZ3ntAsQlJWMFIUZsbU1FFCFQW/Y6OXuLKROicQUmgIACM7SRug38NtQ8N74mtliXYa3HKqvEp2W+2QYlNxBoxDV8ChxbXaZTO4uR4VtORlLuBi10jXf+fqeXScU7eZGxh6eIkWepoe2fDJcpg1OTRByysuSPPLj12maqJ3b4LrIkPkz/m4kJ6QGH8In8PybT9H9ULRlTKvKvkZ952BtF6m0ry1VTD3+Ifh2jrowcUt4JhPysH5bHNPw6TjdFIGSTxI1oz4lkW9lEqHDSlb32KuR8ZbaQjl6QIFvnBpapLLb+2AxMyttkpOLprSN73Azz2hHlA4u017+lvUofB30FTx8Lq+BxGrVX0CS0aHq9UzIPK3FhAS70CDhFLY1jHJBjsBaAtjIHnW3rOyIarCKrs83A4/WWUi/m0hihp6SEPD7QMmCTXSA0R3+HPLyXLihV+bNqHBGwRsHRvyPqqhLq2nOHNqcj0BANlJ2NMfhh84/+g/dGfD1PFpsLbyJhN77kfZJY5vIwBZV6I0M03uu+ejRx7QgsJZKPs1XTTPInKuAvRnjoWf7FILadIJgZfvuNW+6+aAQEPUWXc2eQsJLE2mtDwapntHyylpxGIwcY1fEZyXe6/zAOjfw
X-GND-State: clean

On Thu, Sep 17, 2026 at 08:08:52PM +0000, netdev-bot+sashiko@kernel.org wrote:
>[Severity: Medium]
>Should the message also mention the teardown changes that apply to all chip
>variants, not just w5500 with a link interrupt?
>

I can reword a bit the commit message to mention this.

>[Severity: Medium]
>Can a single failed PHYCFGR read leave the interface stuck with the carrier
>off while the PHY is linked?
>
>The negative case here intentionally leaves the carrier untouched, and there
>is no retry, delayed re-read or polling fallback.  The previous value at the
>two initial synchronisation points is off: w5100_probe() calls
>netif_carrier_off() before register_netdev(), and w5100_suspend() forces the
>carrier off.
>
>The errors do reach here.  w5500_spi_read() in w5100-spi.c propagates SPI
>failures:
>
>	ret = spi_write_then_read(spi, cmd, sizeof(cmd), &data, 1);
>
>	return ret ? ret : data;
>
>so for example an -ENOMEM from the fallback allocation in
>spi_write_then_read() ends up as a negative return of
>w5500_get_phycfgr_lnk().
>
>The only other refresh comes from LINKLED edges, requested with
>IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.  If the link is already up and
>stays up, the pin holds a constant level and no further edge is produced.
>
>So if the read in w5100_open() or w5100_resume() fails once, does the carrier
>stay off until the interface is manually taken down and brought back up,
>with linkwatch keeping the qdisc deactivated in the meantime?  Would
>re-arming a delayed PHYCFGR read on read failure address this?

Yes I agree, an initial SPI read failure will leave the carrier in
such state but adding some polling mechanism in this patch will
complicate it even more.

>[Severity: Medium]
>Making netif_carrier_off() conditional on priv->link_irq here (and the same
>change in w5100_suspend()) looks like it also fixes an existing carrier
>regression.  Should this carry a Fixes: tag for dacf281771a9 ("w5100: remove
>unused gpio link detection")?
>
>dacf281771a9 removed the only netif_carrier_on() calls, which lived in
>w5100_open() and w5100_resume(), but left the unconditional
>netif_carrier_off() in w5100_stop() and w5100_suspend().  On the baseline,
>w5100_open() has no carrier call at all, so:
>
>	ip link set dev eth0 down
>	ip link set dev eth0 up
>
>leaves every w5100/w5200/w5500 reporting no carrier, and linkwatch keeps the
>qdisc deactivated.  A suspend/resume cycle has the same effect.
>
>Without a Fixes: tag this fix will not be picked up for stable, so released
>kernels keep the unusable-after-ifdown/ifup behaviour.

This patch is not really a fix, it brings back proper support for the
link detection using an interrupt and reading the device register.

>[Severity: High]
>Can rx_work still run after unregister_netdev() here and hand an skb to
>netif_rx() with a dangling ndev?
>
>w5100_stop(), which runs from dev_close() inside unregister_netdev(), does
>not cancel or flush rx_work:
>
>	cancel_work_sync(&priv->restart_work);
>	...
>	w5100_hw_close(priv);
>	netif_stop_queue(ndev);
>	napi_disable(&priv->napi);
>
>so an rx_work item queued just before the close can run afterwards:
>
>w5100_rx_work()
>	while ((skb = w5100_rx_skb(priv->ndev)))
>		netif_rx(skb);
>
>	w5100_enable_intr(priv);
>
>netif_rx() takes no device reference, and unregister_netdev() has already
>done flush_all_backlogs() and netdev_run_todo().  If that skb sits in a
>deferred or RPS-remote backlog, is it dereferenced after the free_netdev() a
>few lines below?
>
>The main interrupt is also still registered while the cancel_work_sync()
>calls run:
>
>w5100_interrupt()
>	if (ir & S0_IR_RECV) {
>		w5100_disable_intr(priv);
>
>		if (priv->ops->may_sleep)
>			queue_work(priv->xfer_wq, &priv->rx_work);
>
>so an in-flight handler can re-queue rx_work after the cancellation.  That
>late work then touches chip registers concurrently with the w5100_hw_reset()
>above and calls w5100_enable_intr() after the handler has been freed.
>
>Before this patch, destroy_workqueue() drained rx_work while the netdev was
>still registered and after free_irq(), so neither case could happen.  Would
>freeing and synchronizing both interrupts first, then draining all work they
>can produce, and only then resetting the hardware and
>unregistering/freeing the netdev, be the right order?
>

Right, I'll fix that too. Since unregister is calling ndo_close() I can
handle this there.

>[Severity: Medium]
>Does the new cancel_work_sync(&priv->tx_work) leak priv->tx_skb?
>
>w5100_start_tx() takes ownership of the skb and defers the free entirely to
>the work item:
>
>	if (priv->ops->may_sleep) {
>		WARN_ON(priv->tx_skb);
>		priv->tx_skb = skb;
>		queue_work(priv->xfer_wq, &priv->tx_work);
>
>and w5100_tx_work() is the only consumer that clears priv->tx_skb and frees
>it via w5100_tx_skb() -> dev_kfree_skb():
>
>	struct sk_buff *skb = priv->tx_skb;
>
>	priv->tx_skb = NULL;
>
>	if (WARN_ON(!skb))
>		return;
>	w5100_tx_skb(priv->ndev, skb);
>
>If cancel_work_sync() cancels a work item that has not started yet, nothing
>releases priv->tx_skb, and remove() continues to destroy_workqueue() and
>free_netdev() with it still set.  The previous code reached the same state
>through destroy_workqueue(), which drains queued work instead of cancelling
>it, so the skb was always freed.  Would freeing priv->tx_skb explicitly
>after the cancellation, or flushing tx_work instead, be preferable?

Yes, didn't think of this one.

>[Severity: Medium]
>Should the cancel_work_sync() come before netif_carrier_off() and
>netif_device_detach() rather than after them, as it does in w5100_stop()?
>
>restart_work can be queued at any time on w5500/SPI:
>
>w5100_tx_timeout()
>	if (priv->ops->may_sleep)
>		schedule_work(&priv->restart_work);
>
>A work item that is pending or already running when suspend starts still
>passes the new guard in w5100_restart(), because netif_running() stays true
>through the suspend callback and the guard does not test
>netif_device_present():
>
>	if (!netif_running(ndev))
>		return;
>
>It then re-runs w5100_hw_reset()/w5100_hw_start(), re-enabling chip
>interrupts and re-opening socket 0, calls netif_wake_queue() which clears the
>__QUEUE_STATE_DRV_XOFF that netif_device_detach() just set, and calls
>w5500_report_carrier_state() which can turn the carrier back on right after
>suspend cleared it.
>
>With the tx queue runnable again and __dev_queue_xmit() not testing
>netif_device_present(), can the stack then reach w5100_start_tx() and issue
>SPI transfers to a chip whose socket w5100_hw_close() has closed, or to an
>already suspended SPI controller?  Would moving the cancellation ahead of the
>state changes, and/or widening the guard in w5100_restart(), close this?

Good point, I'll harden the checks.

Arthur
