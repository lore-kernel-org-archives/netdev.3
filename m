Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484839;
	b=X4s2qjYCQZfdIEuUWnQ5B/1Y9wpKrgReiCNAzN9512xFPFlQ7DqMUOsHdsjf3jOSQ5sv
	 4N8Lh/fHP0UdE2AxJ4IBeiGJ+k22yY/8oXURELzmrn9DytYKp1Ngmfgh+Zq1HJxfPuxZ+
	 KqQMm0Hmt4BMfxs9djd7xYR6YI6PB8i5a8BwjhnKX4IOOWH4nwZB1EPnFNqjqKappqPb2
	 FTLj0npEqZsM+Esli0YztonLratFf3hfJ4JRziwnHFvx+MkMMQF85ky7f2Fx0rvr3W/Q8
	 8E0rinK8MhrjQtjn5ulKKxeAQ4QfzfNamfb/WtpG8C7sKkr7jjvSNd4JWdq0g11uEUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484839;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5PnvePViqRVgTyh191bMD2IOvsKk1Zkj+A+MkvxzKeY=;
	b=GOboKu16nBW+WvS3sqBuY0AqLMzJYf1a/9LOm3mF++QJaqjXr+707UWTV6F674DkR36I
	 KakPdPHfXxsBEPsGhSTwaXWupV6HmQy9iG51Xm5dmrCuJaOoLvFZ8wMiYjnf014zL5Awa
	 37lulQt/HegMUxtTlTFP3MUsaqaAPCURERvAdciUVcQ4biOI6w3u3omEvqUfQQ5R/OvOS
	 Q5WwlbY4Y9rysYELS4xeTe5X4unQ5RNNpi9k1Jfups4saOff2KO6WOlWYZqWUrIdisU9V
	 virKsOFf2sg1CTaelJuQjiyxHha/X1FJ04KWeZBbExltToi1a+ijdLsU/IAtCAfJo2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcDznNFe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F9606A31C;
	Thu, 12 Nov 2026 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcDznNFe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ADA1F00A05;
	Thu, 12 Nov 2026 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484839;
	bh=5PnvePViqRVgTyh191bMD2IOvsKk1Zkj+A+MkvxzKeY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZcDznNFetFWJG1C8faMGgggQqfq7WNRRlWLrT6elduD5KlKbsEUl+di9xfASULHeN
	 iL/j7Rcu3FqVDtvSyJxUx9dWNIJFriiQO1mX3ePai8pbmvBLTbBGQ2y+OVs+XlCiUb
	 zZjpr3l3gD6c/tJGHQQzjTsFLkAL1tyf0DrsSDTZSEqF+kBWQGBRp1tvG+Tt49jXqq
	 QkgFMWd+rnNqa8PSH+FSh9qpQPZr6qGSFYf3y6jc8qf2/504Q2kgnoxnIeIlOfLx4m
	 mqD+OuUSs0OZwAZrIzEXBYdLqAAsf7q+Y2g+Rr4yUXK9x1oxQMgTuUvRhfqE2i79Ya
	 K/QzMqZf/9S8g==
Subject: Re: [PATCH net-next v2 2/7] net: ethernet: oa_tc6: Allow custom reset
 settle time values
From: netdev-bot+sashiko@kernel.org
To: iustin.stolniceanu@analog.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, parthiban.veerasooran@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, marcelo.schmitt@analog.com,
 alvin.sipraga@analog.com, ciprian.regus@analog.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 12:00:38 +0000
Message-ID: <179448483815.2199510.2819430860684021311@kernel.org>
In-Reply-To: <20261109085952.105331-3-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-3-iustin.stolniceanu@analog.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] oa_tc6_init() (drivers/net/ethernet/oa_tc6.c) runs the
  hardware reset sequence without holding the SPI bus.

--

net: ethernet: oa_tc6: Allow custom reset settle time values

This commit adds hwreset_settle_us and softreset_settle_us fields to
struct oa_tc6_quirks. MAC-PHY drivers can use them to set the wait after
deasserting the reset GPIO and the wait after the software reset. The
hardware reset wait stays at 1 ms by default, and there is still no
software reset wait unless a driver sets one.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 364027c39fa4a..549997ba363ad 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c

[ ... ]

> @@ -1515,12 +1524,12 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
>  					     "failed to get reset gpio\n"));
>  
>  	if (tc6->reset_gpio) {
> -		/* Keep the reset asserted for 10 us and then allow 1 ms of
> -		 * settle time for the crystal oscillator startup.
> +		/* Keep the reset asserted for 10 us and then allow the reset
> +		 * settle time (1 ms by default).
>  		 */
>  		fsleep(10);
>  		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
> -		fsleep(1000);
> +		fsleep(tc6->hwreset_settle_us);

[Severity: Medium]
Should this reset sequence in oa_tc6_init() hold the SPI bus while
the MAC-PHY settles?

The commit message says the ADIN1110 tristates its SDO pin during
reset. For the same chip, adin1110_check_spi() in
drivers/net/ethernet/adi/adin1110.c locks the bus for the whole
reset and settle window:

	if (reset_gpio) {
		/* MISO pin is used for internal configuration, can't have
		 * anyone else disturbing the SDO line.
		 */
		spi_bus_lock(priv->spidev->controller);

		gpiod_set_value(reset_gpio, 1);
		fsleep(10000);
		gpiod_set_value(reset_gpio, 0);
		...
		fsleep(90000);

		spi_bus_unlock(priv->spidev->controller);
	}

Here, reset is asserted by devm_gpiod_get_optional(..., GPIOD_OUT_HIGH),
then deasserted and held for hwreset_settle_us. No spi_bus_lock() or
spi_bus_unlock() surrounds any of these steps.

The last patch in the series, "net: ethernet: adi: adin1110: Add OA
TC6 protocol support for ADIN1110", does this in
adin1110_oa_tc6_probe():

	quirks.hwreset_settle_us = 50000;
	quirks.softreset_settle_us = 10000;

	port_priv->tc6 = oa_tc6_init(priv->spidev, netdev, &quirks);

In that mode adin1110_check_spi() is never called. The bus-locked reset
is replaced by this unlocked sequence, and the window grows from 1 ms
to 50 ms.

Can a transfer by another device on the same spi_controller drive MISO
in that window and make the ADIN1110 latch a strap that differs from
the board configuration? The later software reset in
oa_tc6_sw_reset_macphy() does not appear to re-sample straps.

Whether this happens depends on which strap is on SDO and when the
part samples it. Those are datasheet details I couldn't verify from
the tree. If the protocol strap were flipped, the first OA TC6 transfer
would fail with -EPROTO. adin1110_oa_tc6_probe() would then fail the
probe with -ENODEV, and this would happen only sometimes, depending on
timing.

Later patches in the series don't seem to add a bus lock to this path.
Would wrapping the reset assert, deassert and settle in oa_tc6_init()
with spi_bus_lock() and spi_bus_unlock() be appropriate here?

>  	}
>  
>  	/* Check the PROTE bit status so that we can reset the device */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109085952.105331-1-iustin.stolniceanu%40analog.com
