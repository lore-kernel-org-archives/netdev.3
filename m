Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484845;
	b=PisH0zcPHtHF43qjMPFBksLOPvZsDrmlkq6W+2oqsyHnfRbEhk/3hk2xvY09wv0EXlpS
	 n8XxsA58dXDTJ1piLDR08QNDpsgixvi5viftUo8jpsJWGr8W1PakTowXDHp1HT2UVsfCw
	 suQhDROA8iSjAoE9qPNtZNANyJ/HIAOv0SEQcbvkQRcju8GxPL3uK1Ce25nhdEfbuEpHM
	 jd0lhDcC08erjRhmc+4BHYFhbKQ2RE9mh68QApczJMX8KVNdsRpd5UvwO2IhIfg8KkXKF
	 fZyEyVKKmAAT0/k0X/ksKVPON+UVThsmg4PO9VnFj9gocagUy3VsoJ6QN8aQ2nSsg9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484845;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3eP4I0Ez26so6pJApDkwIpCymms6xr8duaAA7LctjtY=;
	b=jwy2jwIKIITTz6+5lU5TTB2UO1Zwvh6GD8j8iotHUIukP0hFyxCycXpBbSLNnZLyydJB
	 WodglHTWJcWd0tlABhEo/wRp7LoyTxAxh3BvQNH72StECPnbNEqigzMTK/Lww8IVFuHPo
	 OXILYef0tfIxKMzMTxeiFmlyzbTP+M01tnUXLeNRDMpdGFdYTXFGRVN+f0hgAXckT1kaD
	 og7Vc/aEWIUxq7+gFaM2TmLqbVaTna9E7cfNoZvu1N++zUU2U3okr33ArDeAj5AOqhzEX
	 nxyaZxFvtq3w47TkmyeXuKfHxnz21o3psxqAGCNZOY8K9frgXGq8lfONBvxDMzxUEBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXU1vLX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA69606A339;
	Thu, 12 Nov 2026 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXU1vLX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0A71F00AC7;
	Thu, 12 Nov 2026 12:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484845;
	bh=3eP4I0Ez26so6pJApDkwIpCymms6xr8duaAA7LctjtY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eXU1vLX5y2O/zQ40iydFNNsy+2kn5+VuCCKdSnCS/wSuBJXgCa62nZTQS+BICpNqj
	 mGYH35BYtrK0xWAtIT4D/0Gqo7mIQESWLXe+VA46l2xmFvhdYYp5ndwVW/uPnkz9dc
	 4ZwcZIQT5uaRwHnqaIFp967FdT7Zu2/tSf/ZxZwu9fepWFt+JJ+uXvlIW9rFTZcV4B
	 k217Ep3DtKAKARnDgQYpU1Znsb9guF9js74AJuKY9Wg1gS4voki6t9OWWQdtp8zv0v
	 ef8zXASbNpgTy+X2RHDvKHEixSTq4PrQlh/xyZK7CTOGeawr7KQXJ9u2VOUVhAanN3
	 cd3bMXPGfZQvw==
Subject: Re: [PATCH net-next v2 7/7] net: ethernet: adi: adin1110: Add OA TC6
 protocol support for ADIN1110
From: netdev-bot+sashiko@kernel.org
To: iustin.stolniceanu@analog.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, parthiban.veerasooran@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, marcelo.schmitt@analog.com,
 alvin.sipraga@analog.com, ciprian.regus@analog.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 12:00:44 +0000
Message-ID: <179448484417.2199510.5272200957302283278@kernel.org>
In-Reply-To: <20261109085952.105331-8-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-8-iustin.stolniceanu@analog.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: adin1110: NULL netdev_ops dereference in
  adin1110_oa_tc6_probe()
- [Medium] In OA TC6 mode, the ADIN1110 hardware reset no longer goes
  through the driver's own reset sequence in adin1110_check_spi().
- [Low] In adin1110_oa_tc6_probe() (drivers/net/ethernet/adi/adin1110.c),
  every -EPROTO returned by oa_tc6_init() is turned into -ENODEV, and…

--

net: ethernet: adi: adin1110: Add OA TC6 protocol support for ADIN1110

This adds OPEN Alliance TC6 SPI protocol support for the ADIN1110 using
the oa_tc6 framework, selected by the adi,spi-oa-tc6 property. Register
accesses go through new read_reg/write_reg callbacks, so both protocols
share the MAC configuration code. ADIN2111 is rejected in TC6 mode, and
strap/property mismatches are reported with -ENODEV.

> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index 53fac3dc8be62..3f054565acb0e 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c

[ ... ]

> @@ -1115,14 +1230,89 @@ static int adin1110_check_spi(struct adin1110_priv *priv)

[ ... ]

> +static int adin1110_oa_tc6_probe(struct adin1110_priv *priv)
> +{

[ ... ]

> +	quirks.hwreset_settle_us = 50000;
> +	quirks.softreset_settle_us = 10000;
> +
> +	port_priv->tc6 = oa_tc6_init(priv->spidev, netdev, &quirks);

[Severity: High]
Isn't netdev->netdev_ops still NULL at this point?
devm_alloc_etherdev() leaves it unset. It is only assigned to
&adin1110_tc6_netdev_ops near the end of adin1110_oa_tc6_probe(),
after oa_tc6_init() has already returned.

quirks.quirk_flags does not set OA_TC6_BROKEN_PHY, so oa_tc6_init()
attaches the PHY to this netdev while it runs:

  oa_tc6_init()
    oa_tc6_phy_init()
      phy_connect_direct()
        phy_attach_direct()
          phy_link_topo_add_phy()
            netdev_need_ops_lock(dev)

With CONFIG_NET_SHAPER enabled, netdev_need_ops_lock() reads
dev->netdev_ops->net_shaper_ops. That would dereference the NULL
netdev_ops and oops on every probe in TC6 mode.

As far as I can tell, lan865x_probe() had the same ordering problem
with oa_tc6_init(). It now sets netdev_ops before calling into the
framework.

Can the netdev->netdev_ops assignment, and probably ethtool_ops with
it, be moved above oa_tc6_init()? None of the ndo callbacks should
be reachable before devm_register_netdev(), so moving the assignment
up looks safe.

[Severity: Medium]
In TC6 mode, adin1110_probe() branches to adin1110_oa_tc6_probe() before
adin1110_check_spi() runs, so oa_tc6_init() now does the hardware reset.
The existing reset in adin1110_check_spi() holds the SPI bus lock while
the configuration pins are latched:

drivers/net/ethernet/adi/adin1110.c:adin1110_check_spi() {
    ...
		/* MISO pin is used for internal configuration, can't have
		 * anyone else disturbing the SDO line.
		 */
		spi_bus_lock(priv->spidev->controller);

		gpiod_set_value(reset_gpio, 1);
		fsleep(10000);
		gpiod_set_value(reset_gpio, 0);

		/* Need to wait 90 ms before interacting with
		 * the MAC after a HW reset.
		 */
		fsleep(90000);

		spi_bus_unlock(priv->spidev->controller);
    ...
}

The reset in oa_tc6_init() requests the GPIO with GPIOD_OUT_HIGH and
does not lock the bus:

drivers/net/ethernet/oa_tc6.c:oa_tc6_init() {
    ...
	if (tc6->reset_gpio) {
		...
		fsleep(10);
		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
		fsleep(tc6->hwreset_settle_us);
	}
    ...
}

On a shared SPI bus, can a transfer to another device drive MISO/SDO
while the ADIN1110 latches its configuration as it leaves reset? That
configuration includes the SPI_CFG1 protocol selection this path relies
on. If it latches wrong, the first control transfer would fail and probe
would report a strap/DT mismatch on a board that is strapped correctly.

The timings also differ from the generic SPI path. The reset is asserted
for 10 us instead of 10 ms, and the settle time is 50 ms where the
comment in adin1110_check_spi() asks for 90 ms. The oa_tc6 patch earlier
in this series cites a 50 ms datasheet limit. Which value is correct?
Should the comment in adin1110_check_spi() be updated, or should
hwreset_settle_us be 90 ms?

> +	if (PTR_ERR_OR_ZERO(port_priv->tc6) == -EPROTO)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "no OA TC6 reply, check the SPI_CFG1 strap and adi,spi-oa-tc6\n");

[Severity: Low]
The commit message says:

  If the first OA TC6 control transfer gets no valid reply, or the PHY ID
  does not match, probe fails with -ENODEV and a message pointing at the
  strap and the property.

Is this check limited to the first control transfer? In oa_tc6.c,
-EPROTO comes from the reply checkers that every control access uses:

drivers/net/ethernet/oa_tc6.c:oa_tc6_check_ctrl_write_reply() {
    ...
	if (memcmp(tx_buf, rx_buf, size - OA_TC6_CTRL_IGNORED_SIZE))
		return -EPROTO;
    ...
}

drivers/net/ethernet/oa_tc6.c:oa_tc6_check_ctrl_read_reply() {
    ...
	if (*tx_buf != *rx_buf)
		return -EPROTO;
    ...
			if (complement != ~reply)
				return -EPROTO;
    ...
}

oa_tc6_check_ctrl_protection() only succeeds if the chip answered in TC6
mode. After that, oa_tc6_init() still runs these steps:

  oa_tc6_sw_reset_macphy()
  oa_tc6_unmask_macphy_error_interrupts()
  oa_tc6_phy_init()
  oa_tc6_enable_data_transfer()
  oa_tc6_update_buffer_status_from_register()

Each one returns its error unchanged as ERR_PTR(ret). A reply mismatch
in any of them would still be logged here as a strap/property problem,
with -ENODEV.

> +	if (IS_ERR(port_priv->tc6))
> +		return PTR_ERR(port_priv->tc6);
> +
> +	priv->read_reg = adin1110_read_reg_tc6;
> +	priv->write_reg = adin1110_write_reg_tc6;
> +
> +	ret = devm_add_action_or_reset(dev, adin1110_oa_tc6_remove, port_priv->tc6);
> +	if (ret)
> +		return ret;
> +
> +	ret = adin1110_read_reg(priv, ADIN1110_PHY_ID, &val);
> +	if (ret < 0)
> +		return ret;

The PHY ID read is handled differently. An -EPROTO from
adin1110_read_reg_tc6()->oa_tc6_read_register() is returned here as
-EPROTO rather than -ENODEV. Is that difference intended?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109085952.105331-1-iustin.stolniceanu%40analog.com
