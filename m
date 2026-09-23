Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BA443A81;
	Wed, 23 Sep 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156217; cv=none; b=oUUUFPkzw96Ir56XL0wA3y5HaxbtdjD+pN4ZlnC7e08p40lHN8kHOls9l+cg/JO6pyTm9UXgR4OOVq3LcSgw6ah1B9FyZT4UGmaOVrKRcT+Ve1YbR+4/RHxID5fkw3MV2JcsnQxTwfDIGXEML5qtkRIXxKhJvhK+2jfQDieVk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156217; c=relaxed/simple;
	bh=v2PqbuChpTur7OvHCDFOgIY4pTln1eOuKbw6gjH6dX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW3A/z46t6ecZcEJf4Vh5YRD80UWxSDkclq9GjgQCE8Ej9KdQc0U7B7K6ihWK/AmtLYW/luiwT8XT77Zvx3jGWrhTlRDnS80GwKd8oe29jdJoI8W78HWchPiYOMzIPiME5pJawZiHfrNKWQM9nhzL7vd6ue8gtmDghCVbssP2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=gfmLKkGp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="gfmLKkGp"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 250823EB9F;
	Wed, 23 Sep 2026 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1790156213; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=TVLpoLZircA9uY6MKdQKASS6OYX7q7237zr5erJLo2c=;
	b=gfmLKkGpwMstCOPRaAMgVclPICcBnzgQczdDVbbQbndlCVhW36pvd1U8hLnBooW2qf9qLw
	Di+OGPWxTMD0AwaO81qEWI4LWvJysOFidlwgQkncdzQKzSdwukdF37duNMzE0m/4UEdK9q
	O0gNkHwZDNXtGJVSpoy1FyVb/jO9zXbEc4SGHOk22K9HT8EFuNBYhQYWVLWQ2fMxHAg/zB
	TS3qib3EQQivZwnS8uzSaBwafsTJFzDl3MCh2FLcPjVrIeKhjpUAUU8KCawD5cNzPTMdHb
	MQJ3VGjpQ1xBbwfaCyJq1abOhn3RuCarxmim6sPu+iiMxu2ptKU7sjn5CSVHxQ==
Date: Wed, 23 Sep 2026 11:36:49 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] w5100: detect carrier state using link
 status bit and optional interrupt
Message-ID: <20260923093649.GA120572@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260918-wiznet-link-gpio-v9-3-5536f24d8d6d@marmottus.net>
 <179009180606.2160803.9423654885662355459@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179009180606.2160803.9423654885662355459@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: 0
X-GND-Cause: dmFkZTElW8X2q0lulgsp4H/AOs69gw8Lfv7GQ/1U1Pu7zjhdYthSb9btPJRF6DO/umpgKmqIMpS4ft2SqqaXI/Zupk/Ls/dJjmCzGZMO49s8tFz5quLCF2InJznTmjyKIOgAy5Y/e34yDB1J9w+jBECO7isRNmXFJN3KKKMdlTBDqWb0uPciSYT58CMZT5kZRm3uBbshzgLwoHa8tH3+XSEDQlctfSEnr3xJzZFg/AxvALUlyV2badDXBRR2YNNK5l97iCGWuZLvnfwWiPV3+sYhtT+FxKg+ZwpIowxTzBxtP6D+shKB/pklBTHGvtNTDgjLtL+lgPfniQ1xypYQyeVeA9rHc9BHj/lgKPMOJXaoneJFZQ2bcbNQ9F4B7mBqFFvOOkEg0t8NVBPmBzoHLtHTr9e0RQ0NJSAjbpfDRYDvVKpvjlF20rEaJa60LkjmfIUC+mbaqg2dOUlT25BGmK+wfwpBFgZz8iE5fae6RzU/j1eWqKeWgyAQjZkdzPhOb2PUgTe2tyCwNrvs1l6szQDVGE90p/ABEyUEySpwdzrGKRJoiMfoxr/UfKf0mariTVIfJEnNh/ZQ5j/5lZrsOlh7U8HvVEVykX6UKGE/8nk4tjjg1RDdaUwTsI1XFI68xvoKg03Kng4s1cmHPECKxxeOORKdcnNS9KXf3mHM8jNWYa2jjQ
X-GND-State: clean

On Tue, Sep 22, 2026 at 03:43:26PM +0000, netdev-bot+sashiko@kernel.org wrote:
>[Severity: Medium]
> ...
>What is the intended split here - should w5100_tx_timeout() always queue
>restart_work now that w5100_restart() can sleep, or should the irq
>masking and the carrier re-check be done only in the may_sleep path?

schedule_work() will always be called (see v10).

>
>[Severity: Medium]
>The link irq is requested below with IRQF_NO_AUTOEN and
>IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING, so it stays masked until this
>enable_irq(). PHYCFGR is sampled first and edge detection is only turned on
>afterwards:
>
>	w5500_report_carrier_state(ndev);	/* reads PHYCFGR */
>	enable_irq(priv->link_irq);		/* edge detection starts */
>
>If the PHY link comes up between those two steps, can that transition be
>lost for good? On the BCM2835 controller used in the binding's own example,
>masking disables edge detection and also discards latched events:
>
>drivers/pinctrl/bcm/pinctrl-bcm2835.c:
>	bcm2835_gpio_irq_config(pc, gpio, false);
>	/* Clear events that were latched prior to clearing event sources */
>	bcm2835_gpio_set_bit(pc, GPEDS0, gpio);
>
>so unmasking does not replay the missed edge, and with a now stable LINKLED
>level the driver keeps reporting carrier off until the next physical link
>change.
>
>w5100_restart() and w5100_resume() use the same order, and restart follows a
>chip reset with PHY re-negotiation. The changelog lists this ordering as
>intentional ("enable the link irq after checking PHYCFGR") - would enabling
>the irq first and then reading PHYCFGR close the window?

Probably very unlikely to happen and more of an edge case but I can
enable link irq first.

>[Severity: High]
>flush_work(&priv->rx_work) now runs while socket 0 is still open, because
>w5100_hw_close() is called after it.
>
>w5100_rx_work() drains without a budget or a shutdown test:
>
>	while ((skb = w5100_rx_skb(priv->ndev)))
>		netif_rx(skb);
>
>and w5100_rx_skb() only returns NULL once the hardware receive buffer is
>observed empty:
>
>	u16 rx_buf_len = w5100_read16(priv, W5100_S0_RX_RSR(priv));
>
>	if (rx_buf_len == 0)
>		return NULL;
>
>disable_irq(priv->irq) masks the host interrupt but does not stop the
>controller from filling its receive buffer. Each frame is drained with
>several synchronous SPI transfers, which is slower than line rate, so can
>sustained incoming traffic keep RX_RSR non-zero and make this flush_work()
>never return?
>
>ndo_stop runs with rtnl held, so an ip link set down would then stall all
>network configuration in an unkillable wait. w5100_remove() reaches the same
>path through unregister_netdev().
>
>Would calling w5100_hw_close() before flushing rx_work avoid this?
>
>> -	netif_carrier_off(ndev);
>> +
>> +	if (priv->link_irq > 0)  {
>> +		mutex_lock(&priv->link_lock);
>> +		netif_carrier_off(ndev);
>> +		mutex_unlock(&priv->link_lock);
>> +	}
>> +
>>  	netif_stop_queue(ndev);
>>  	napi_disable(&priv->napi);
>>  	return 0;
>>  }
>

Agreed, w5100_hw_close() should be called earlier.

>[Severity: Medium]
>The changelog states:
>
>  w5100_remove(), w5100_stop() and w5100_suspend() call
>  cancel_work_sync()/flush_work() to make sure there is no pending
>  work
>
>but w5100_suspend() only cancels restart_work here. setrx_work (queued with
>schedule_work() from w5100_set_rx_mode()), rx_work (queued on priv->xfer_wq
>from w5100_interrupt()) and tx_work (queued from w5100_start_tx()) are
>neither cancelled nor flushed, while w5100_stop() drains all four. Should
>the changelog be narrowed, or the suspend path made to match stop()?
>
>[Severity: High]
>Independently of the changelog wording, can these work items still touch the
>hardware after suspend has closed it?
>
>disable_irq(priv->irq) waits for the threaded handler w5100_interrupt() to
>finish, but any rx_work it already queued is still pending, and
>priv->xfer_wq is created with WQ_MEM_RECLAIM | WQ_PERCPU (no WQ_FREEZABLE),
>so it keeps running during suspend. w5100_rx_work() does SPI register
>accesses (S0_RX_RD writes and S0_CR_RECV) and ends with:
>
>	w5100_enable_intr(priv);
>
>which re-arms the chip interrupt masks that w5100_hw_close() cleared, while
>the host irq stays masked.
>
>setrx_work runs on system_wq and calls w5100_hw_start(), re-issuing
>S0_CR_OPEN and w5100_enable_intr() after suspend closed socket 0. tx_work
>can still issue S0_CR_SEND. Any of these transfers issued after the suspend
>callback returns are rejected once the SPI controller itself is suspended.
>
>There is also a re-queue window: restart_work is cancelled here, before
>netif_device_detach() below. In between, dev_watchdog() can still fire
>(netif_device_present(), netif_running() and netif_carrier_ok() all hold,
>and carrier_ok() is permanently true on w5100/w5200 and on a W5500 without a
>link irq):
>
>w5100_tx_timeout()
>	if (priv->ops->may_sleep)
>		schedule_work(&priv->restart_work);
>
>The re-queued w5100_restart() then passes its own netif_running() /
>netif_device_present() test and runs w5100_hw_reset() plus w5100_hw_start()
>against the device suspend is closing.
>
>Should netif_device_detach() come before the cancel, and should setrx_work,
>rx_work and tx_work be drained here as they are in w5100_stop()?

suspend() and resume() will call w5100_stop() and w5100_open()
directly.
And yes, netif_device_detach() will be called before.

Arthur
