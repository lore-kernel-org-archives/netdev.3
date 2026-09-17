Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40044331B;
	Thu, 17 Sep 2026 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634725; cv=none; b=UYTUpWjTfwYwNr09HtonaV4cX1oLaDTXPgY9WH0zfC+FIr9Ucfa/PvRBppNwvvx/1sqh06IubRCD0y7fKYiHUKAkqtSmmzWFGKlDEgHI0GCmxTbWCTA0P/ed5N4Jg5+AvMM/qvSKFU59AjiiOmUE5xYaz6JMpffFznbxv48lvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634725; c=relaxed/simple;
	bh=sRUL5aFNdwHVISNGdn8WlSdAWXLyBYVvbuUKq64vXO0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDWeiNMcb//Vhodb8crsfMbyr+NkA5IDry7oY0soALAv+7dh5RUHfqTpT6PckNwhJv3oppsn3Q+gWDTaIB+mDvJicLtCf38wFn5Dn1LduXvcE3Md7YfjVZVxEOIqup8F/J3NUxkHg6F91uA2mTKgXSYyGWDwncb+y1XB7Zu3CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/uNknH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/uNknH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B358E1F000FF;
	Thu, 17 Sep 2026 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634710;
	bh=IOCcb+AstmyGFlD8WjwUXubHz5XoieU+5PFZedXld8o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W/uNknH7mGHA7472c84C6JcnGuolVk73wOf4D1A0lRx5bc5ka5W1qDabVl/v05K9y
	 1z7lm9RmetfXEcZCpJ2cIPGBCu8KpXt/ATokZ85rJ4/IWz/+y553ZVHa7wiOsa9uk2
	 VYchWnnN1jiUIYo0KvwkxjnfZXHukRMGh8018by52cwKXeUl/P79hxif/SoOxuvzVb
	 MBphKZvF9jy6j/VHMb4YUA2OE4F+YR0kN/Uu8Eo8MVDSdeu+No48k9q35D3dFaE4fV
	 5hyHxBcPgozDrAsE4621mX1RNYYGd7NNdssESvm07QNrg5JKoOyna76rqgkiVpWhHz
	 uvkaimDK/PRpg==
Subject:
 Re: [PATCH net-next v2 2/2] net: ethernet: oa_tc6: add reset-gpios support
From: netdev-bot+sashiko@kernel.org
To: alessandro.zini@siemens.com
Cc: parthiban.veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 08:45:09 +0000
Message-ID: <178963470920.22033.5695755552424202480@kernel.org>
In-Reply-To: <20260916075349.21822-3-alessandro.zini@siemens.com>
References: <20260916075349.21822-3-alessandro.zini@siemens.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] Lost -EPROBE_DEFER: the newly added
  devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW) at…
- [Medium] Incomplete DT ABI change: the reset GPIO is consumed in the
  *common* TC6 library (drivers/net/ethernet/oa_tc6.c:1509,…
- [Low] Both new reset-line writes ignore their return values:
  drivers/net/ethernet/oa_tc6.c:1521 and :1523 call…

--

net: ethernet: oa_tc6: add reset-gpios support

This adds an optional reset GPIO to oa_tc6_init().  When the device tree
supplies one, the reset line is asserted for 10 us and 1 ms of settle time
is allowed before the control protection check and software reset run.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 6fcc5f561d560..a697e2cb99cd8 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c

[ ... ]

> @@ -1503,6 +1506,24 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  	if (!tc6->spi_data_rx_buf)
>  		return NULL;
>  
> +	tc6->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +						  GPIOD_OUT_LOW);

[Severity: Medium]
The new reset-gpios property is consumed here in the common TC6 library, and
oa_tc6_init() has two callers:

  drivers/net/ethernet/microchip/lan865x/lan865x.c:lan865x_probe()
  drivers/net/ethernet/adi/adin1140.c:adin1140_probe()

Only Documentation/devicetree/bindings/net/microchip,lan8650.yaml gained the
property in this series.  Documentation/devicetree/bindings/net/adi,ad3306.yaml
covers both compatibles handled by adin1140.c ("adi,adin1140" and
"adi,ad3306") and it lists no reset-gpios, ending with:

    required:
      - compatible
      - reg
      - interrupts
      - spi-max-frequency

    unevaluatedProperties: false

Would a board DTS for adi,adin1140/adi,ad3306 that uses this new feature be
rejected by dt_binding_check/dtbs_check?  Should adi,ad3306.yaml be extended
in the same series, and should the commit message mention that this touches a
second driver?

> +	if (IS_ERR(tc6->reset_gpio)) {
> +		dev_err_probe(&spi->dev, PTR_ERR(tc6->reset_gpio),
> +			      "Failed to get reset GPIO\n");
> +		return NULL;
> +	}

[Severity: High]
Can this path lose a deferred probe request?

devm_gpiod_get_index_optional() in drivers/gpio/gpiolib-devres.c only folds
the not-found case into NULL:

	desc = devm_gpiod_get_index(dev, con_id, index, flags);
	if (gpiod_not_found(desc))
		return NULL;

	return desc;

so -EPROBE_DEFER (GPIO provider behind an I2C expander, or a pinctrl/GPIO
driver still to be loaded as a module) arrives here as an error pointer.  The
errno returned by dev_err_probe() is discarded and NULL is returned instead,
and the kernel-doc for oa_tc6_init() only describes "pointer reference to the
oa_tc6 structure ... otherwise NULL".

Both callers then turn that into a hard failure:

drivers/net/ethernet/microchip/lan865x/lan865x.c:lan865x_probe() {
	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
	if (!priv->tc6) {
		ret = -ENODEV;
		goto free_netdev;
	}
}

drivers/net/ethernet/adi/adin1140.c:adin1140_probe() {
	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);
	if (!priv->tc6)
		return -ENODEV;
}

Since the driver core only re-queues probe for -EPROBE_DEFER, does the SPI
device end up never retried, with the interface permanently absent?  And
because dev_err_probe() logs -EPROBE_DEFER at debug level, is the failure
also silent?

For comparison, adin1110_check_spi() in drivers/net/ethernet/adi/adin1110.c
acquires the same "reset" GPIO and propagates the value:

	if (IS_ERR(reset_gpio))
		return dev_err_probe(&priv->spidev->dev, PTR_ERR(reset_gpio),
				     "failed to get reset gpio\n");

Would giving oa_tc6_init() an ERR_PTR/errno return channel, or acquiring the
GPIO in the bus drivers, be preferable here?

> +
> +	if (tc6->reset_gpio) {
> +		/* Assert hardware reset for 10 us (datasheet specifies min 5 us)
> +		 * and allow 1 ms settle time for crystal oscillator startup.
> +		 */
> +		gpiod_set_value_cansleep(tc6->reset_gpio, 1);
> +		fsleep(10);
> +		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
> +		fsleep(1000);
> +	}

[Severity: Low]
This isn't really a bug, but both gpiod_set_value_cansleep() calls return an
int that is dropped here.  For a provider behind a slow bus, for example
pca953x_gpio_set_value() -> regmap_update_bits() over I2C, the write can
fail and the error is passed back through gpiochip_set().

If the assert write fails, does initialization continue as though a hardware
reset had happened?  And if the deassert write fails, are control transfers
then issued while the part may still be held in reset, with the GPIO errno
replaced by the later "Failed to check the protection mode" message?

Note that gpiod_set_value_cansleep() is not __must_check in
include/linux/gpio/consumer.h and ignoring it is common in-tree, so this is
only a diagnostics nit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916075349.21822-1-alessandro.zini%40siemens.com
