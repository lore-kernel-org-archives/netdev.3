Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11324A840C;
	Thu,  3 Sep 2026 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440927; cv=none; b=nvQrH/2u59WpTDvSchocawAsVwC6uJefINCcR0AoIhZ1CI3E3Z1xVaVWpUtdn+FGrO4hh+Y1/TqvnZmDmxG1dFBc5EPhFBf1W2h6amaLuGu9QaGXUR+cA3sIa0bQwDvM9VvkKQ1xwZcJqM0ts+D4RQ3i3pFJPHGzwGBoott6cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440927; c=relaxed/simple;
	bh=B7gP3NvBRh0rhjmEr6G22KSrhqGQckl4vySMbPcxqsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm6/Og/EMD3oKrgNtVRLSUCyoqpcvPz1TaC229zXZNVzYS80hdrHJtig1HUXCnXDVMsxfkt+gP8SdLpYryS6P2NSDIaLbxIe2OGx4gixtXztq9sqLQ1PTRn8vs1DD/D9f3/wPzNHnxAp9XzKJiwReYdJHNSu37/Dhy4K8Wze974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=I8h9zvhq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="I8h9zvhq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27B033EB9F;
	Thu,  3 Sep 2026 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788440904; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezftVVWjg4mTK3jr/ZWAuNM0boK7VeRLMet+FZYTEIg=;
	b=I8h9zvhq07zCES0kkREqe2quRwg8DIpCkgMEBT8hk8GA9mxMwlNphKcOK7m0+O0P9BuWGr
	Bw7MXFlUP+XVoGZQ77UuO9GJfG0GGGJsEjX2FdG+rtUlacV0EK4iYwki51h327CpNfNy3c
	GeX8rvi/JE/ImkcylQU1BZTkpVWyu+fWnqWucFm8bLiAn5xviaHY8x6ekDVLsFPkw8WqAo
	gGEZP5qNKz3hlmG8fBrFehxN71sSt6W3aeXp+kFSfdjhNTJFd1YEeuO2/ii0WZFGcUFhrA
	I4uKCVrNx3g+w3ekAIb1VvDQYSZqCwYW2jvOGjcRdhwne4bRTiskHoEJKu0dNA==
Date: Thu, 3 Sep 2026 15:08:20 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v6,3/3] w5100: detect carrier state using link status
 bit and optional interrupt
Message-ID: <20260903130820.GA21664@marmottus.net>
Reply-To: arthur@marmottus.net
References: <20260831-wiznet-link-gpio-v6-3-abee6c5c966e@marmottus.net>
 <178839696443.3394541.11998106403165239318@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178839696443.3394541.11998106403165239318@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: 0
X-GND-Cause: dmFkZTFN9/iVgFO0LR/rgx/+R/0XfJacygIZvmGlzeXxQuFPVoK8LUoPUEvJqepmnWLKhWKR1gJMVlovry/3niCx4teN7dlqx5f72f1njn1ToMYuInFpAklslcFZrof12Cj6Gn6mqpImlOsvPbsgVQ5B8DhGYDCnc0DVwgvhh0/nBZaXhbJL+cQTWmDv8SCKTWyoW8h6iNNsHZ8CMuAh66MxeodOf2M8ARp+KtsUzx9hcRrNvTnbbxZ9Lps10ACPQ7t8Qg7FD3fVZg3UnluR9UClgXOTu2PKFaXz1T7jdNSuOevXzFMNOp4h9QStZNUY+LI0KWpwOR7mX6YYA9qETJiUcVvMhUugQ3dWYlK884RMjdquiwI3WxtZEnqxWEBa7tMZxlkW9+hOSnyEcSaYb/N2e0bEYyu2ot3gEikqRESjas102ktBwLz7gKDlgk3euJ+pnKHe1wqE7k5m7RtDb0zbyD5rxGxsnX5s7Y43zLoTs7IFSBcO9Mo50OP7pObKkp8RJhaFPRh5LzuZs5U6qg7Rab46OiqZjif0TC11Szq/GgfvSZ/HUCPxDGu9/t1YZH57BAnl5TMrP90NS2BJbLgdXTH9eZcjT+HCrjfAND5MhxEh8PoJQ3sM7YuzNPpAagbQ5plm0wky0LMqodz6zNmspsBCBvGog6s6WPMAeeLDV89uPg
X-GND-State: clean

On Thu, Sep 03, 2026 at 12:56:04AM +0000, netdev-bot+sashiko@kernel.org wrote:
>> +static int w5500_get_phycfgr_lnk(struct net_device *ndev)
>> +{
>> +	struct w5100_priv *priv = netdev_priv(ndev);
>> +	int ret = w5100_read(priv, W5500_PHYCFGR);
>> +
>> +	if (ret < 0) {
>> +		netif_err(priv, link, ndev,
>> +			  "failed to read link status: %d\n", ret);
>> +		return 0;
>> +	}
>> +
>> +	return ret & PHYCFGR_LNK;
>> +}
>
>[Severity: Medium]
>
>Returning 0 on a failed read makes a bus error indistinguishable from a
>genuine LNK=0 for every caller.  For the w5500, w5100_read() ends up in
>w5500_spi_read():
>
>drivers/net/ethernet/wiznet/w5100-spi.c:w5100_spi_read() {
>	ret = spi_write_then_read(spi, cmd, sizeof(cmd), &data, 1);
>
>	return ret ? ret : data;
>}
>
>so negative returns are reachable (spi_write_then_read() can fail with
>-ENOMEM on its internal buffer, or with any controller error).
>
>If that happens once inside w5100_open(), the else branch latches
>netif_carrier_off(); inside w5100_resume() it just skips netif_carrier_on()
>and the carrier stays off.  After that, the only code that ever touches the
>carrier again is w5500_detect_link(), which runs on a LINKLED edge only, so
>if the cable is left plugged in does the interface stay carrier-down for the
>rest of its lifetime with no retry or re-read anywhere?
>
>Would returning the error to the callers, and leaving the carrier state
>unchanged on a failed read, be preferable?

Good point, I can propagate the error and handle it in the caller and
leave the carrier state unchanged.

>One more note on the diagnostic: priv->msg_enable is never initialised in
>w5100_probe() (the priv area comes from the zeroed alloc_etherdev()) and the
>only writer is w5100_set_msglevel(), so netif_msg_link(priv) is false by
>default and this netif_err() prints nothing unless the message level was
>raised beforehand.

I guess it would be up to the userland to decide if they want to have
error messages enabled?

>> @@ -659,6 +705,15 @@ static int w5100_open(struct net_device *ndev)
>>  	w5100_hw_start(priv);
>>  	napi_enable(&priv->napi);
>>  	netif_start_queue(ndev);
>> +
>> +	if (priv->link_irq < 0 || w5100_get_link(ndev))
>> +		netif_carrier_on(ndev);
>> +	else
>> +		netif_carrier_off(ndev);
>
>[Severity: Medium]
>
>Since || short-circuits, w5100_get_link() is not called at all when link_irq
>is negative and the carrier is unconditionally turned on.  The ethtool
>callback added just above, however, keys on the chip id rather than on
>link_irq:
>
>	if (priv->ops->chip_id == W5500)
>		return w5500_get_phycfgr_lnk(ndev);
>

Again, good catch! One could setup the w5500 without the link IRQ but
still use the PHCFGR register for the carrier state.

>> +
>> +	if (priv->link_irq >= 0)
>> +		enable_irq(priv->link_irq);
>
>[Severity: Medium]
>
>The link bit is sampled and the carrier committed before the LINKLED source
>is armed here.  The interrupt is requested with IRQF_NO_AUTOEN, so this
>first enable_irq() is what performs irq_startup(); can an edge that arrives
>between the PHYCFGR read (an SPI transfer) and enable_irq() be dropped
>rather than replayed by check_irq_resend()?
>
>w5100_resume() has the same order, right after w5100_hw_reset() /
>w5100_hw_start() where the PHY renegotiates, which looks like a spot where a
>link-up edge is likely to land in the window.
>
>Since w5500_detect_link() also writes the carrier from its own PHYCFGR
>sample, with no lock in common with open/resume, would swapping these two
>statements be sufficient on its own, or does the "sample plus carrier
>update" pair need serializing against the handler (or a re-sample after
>enable_irq())?
>
>If a transition is lost here, the carrier stays stale until the next
>physical link change.

Chances are probably low but I can enable the irq after the get_link
check.

>> @@ -820,14 +902,20 @@ void w5100_remove(struct device *dev)
>>  	struct net_device *ndev = dev_get_drvdata(dev);
>>  	struct w5100_priv *priv = netdev_priv(ndev);
>>
>> +	if (priv->link_irq >= 0) {
>> +		free_irq(priv->link_irq, ndev);
>> +		priv->link_irq = -ENODEV;
>> +	}
>> +
>>  	w5100_hw_reset(priv);
>>  	free_irq(priv->irq, ndev);
>>
>> +	unregister_netdev(ndev);
>> +
>
>[Severity: Medium]
>
>Both interrupts are freed and the chip is reset here while the netdev is
>still registered and possibly up, and priv->link_irq = -ENODEV is used as
>the only guard against the other side.  Driver unbind
>(device_release_driver() -> w5100_remove()) holds no rtnl, while
>w5100_open() / w5100_stop() run under rtnl, and both read priv->link_irq
>with no lock, barrier or READ_ONCE/WRITE_ONCE.
>
>Can this interleaving happen?
>
>CPU0 (unbind, no rtnl)			CPU1 (ip link set dev down, rtnl)
>w5100_remove()				w5100_stop()
>					if (priv->link_irq >= 0)  /* true */
>free_irq(priv->link_irq, ndev);
>priv->link_irq = -ENODEV;
>					disable_irq(priv->link_irq);
>
>disable_irq() on a descriptor with no installed action leaves desc->depth
>unbalanced; after a re-bind, request_threaded_irq() with IRQF_NO_AUTOEN plus
>the single enable_irq() in w5100_open() would not bring the depth back to
>zero, so would link detection stay dead until reboot?
>
>The mirror case is w5100_open() calling enable_irq() on a just-freed link
>irq, and running w5100_hw_start() / w5100_get_link() against a chip that
>w5100_hw_reset() has already reset and whose main irq handler has already
>been released by free_irq(priv->irq, ndev).  The window covers several
>sleeping SPI transfers plus a synchronize_irq(), so it is not narrow.
>
>Would calling unregister_netdev() first, before free_irq(priv->link_irq),
>free_irq(priv->irq) and w5100_hw_reset(), close this?  It closes the device
>under rtnl and guarantees no further ndo_ or ethtool callbacks can start,
>which would also make the priv->link_irq = -ENODEV store unnecessary.

That should work, calling unregister_netdev earlier would disable ndo_ calls.

>> @@ -24,7 +24,11 @@ properties:
>>        - wiznet,w5500
>>
>>    interrupts:
>> -    maxItems: 1
>> +    minItems: 1
>> +    items:
>> +      - description: Main interrupt (INT pin on the device).
>> +      - description:
>> +          Optional interrupt for link status changes (LINKLED pin on w5500).
>
>[Severity: Low]
>
>This relaxes the count to two entries for all three compatibles, including
>wiznet,w5100 and wiznet,w5200, even though the second item's own description
>says the pin only exists on the w5500, and the driver only resolves index 1
>for that chip:
>
>	priv->link_irq = ops->chip_id == W5500 ?
>			 fwnode_irq_get(dev_fwnode(dev), 1) : -ENODEV;
>
>Should this be expressed with an allOf / if-then block, so that
>
>  if:
>    properties:
>      compatible:
>        contains:
>          enum:
>            - wiznet,w5100
>            - wiznet,w5200
>
>keeps interrupts at maxItems: 1, and only wiznet,w5500 allows maxItems: 2?
>As it stands a w5100/w5200 tree with a second interrupt passes
>dt_binding_check while the driver ignores the line.

I think the user should also be able to read the document and know
which hardware they are using? But yes, adding allOf with a condition
would be bullet proof.

>>
>>    reg:
>>      maxItems: 1
>> @@ -58,7 +62,8 @@ examples:
>>              pinctrl-names = "default";
>>              pinctrl-0 = <&eth1_pins>;
>>              interrupt-parent = <&gpio>;
>> -            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>,
>> +                         <24 IRQ_TYPE_EDGE_BOTH>;
>
>[Severity: Low]
>
>This isn't an issue introduced by this series, but the example describes the
>main interrupt as IRQ_TYPE_EDGE_FALLING while the driver requests that same
>line with a hard-coded IRQF_TRIGGER_LOW in both paths:
>
>	err = request_threaded_irq(priv->irq, NULL, w5100_interrupt,
>				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>				   dev_name(dev), ndev);
>	...
>	err = request_irq(priv->irq, w5100_interrupt,
>			  IRQF_TRIGGER_LOW, dev_name(dev), ndev);
>
>A non-zero IRQF_TRIGGER_ mask makes __setup_irq() call __irq_set_trigger()
>and reprogram the controller, so the type from the device tree is
>discarded.  The same example text came from the deleted
>Documentation/devicetree/bindings/net/wiznet,w5x00.txt.  Since the file is
>being touched anyway, is it worth aligning the example with what the driver
>actually programs?  The second entry is consistent, IRQ_TYPE_EDGE_BOTH
>matches IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.
>
>>              spi-max-frequency = <30000000>;
>>              local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
>>          };
>

Right, the DT binding is not aligned with the implementation.

>--
>Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-wiznet-link-gpio-v6-0-abee6c5c966e%40marmottus.net

Thank you!

Arthur
