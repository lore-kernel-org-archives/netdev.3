Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6504AAC50;
	Sat, 10 Oct 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645063; cv=none; b=QqwIUWW5IFBRl+O5mn8xbQk+pDybnmd01BFA7UFS9bllVxsRDNvhWuVAX0I3FqfKU74lw3uEOV/MN1q3Xd7QV7jTwOb10XEHs57FoUCWr2OkVcFDquzeEolGlsSJAcP/ZqP00QvOF+OHwYF6YCzRsGLcrlKDkOmtlK4P7+Z1S+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645063; c=relaxed/simple;
	bh=uMSWYYLd+3dC5c6o7LkwY2x7NK5YiNjOd8P0A2Khoys=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oWNHf9NkfMjbkrRn7TzHh9oux6Nae+bnO6eb7DnIDAO47wIGFa42C5iMLL9hNy+z/QcAGKdASa0u5ulj3SLiVdZajDoXftD6UxkydEuxcoiO9kr1osPUaQlHQo5hsC670ECl57r/QyYbBDsZDVSd2cwp3XQi673zJr7s2Upocok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcmA2JOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcmA2JOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312E51F000FF;
	Sat, 10 Oct 2026 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645062;
	bh=XHqIJq78TPh3CMoZn8eT46bz2UXEjv2uCG2uaAz+oRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UcmA2JOW7GZF07D9cRKdH83D4Exa25SGk/szOAEwHpgE8vaLdHswjiBwHNUrM5oHq
	 e0UIqL7MwkXy0ABWxrZVHpS9R/LLsmYxLP82+ojftAjg8kYuLFrd0moCaEDgQbtWQv
	 ED4CT7jjMFo//3oenBf7WPCy4f5OB/kdv+7Bv2SdPbV6lzfR3t3fSkYWMkjUBC4meM
	 YEfitWZYyKWBhDLmQwfRHGfvaPQb1nQQ2iyuqWssV0AThefP2w6Omr3bUjHIqB2hqX
	 huuNon+6WqYFNyTQUj66iLoWTwCNZ53g6d3nc/V1mlJfF3QlRg4YZNsTtojB5s9kR4
	 yM2clIuxh2gLA==
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, linux@armlinux.org.uk,
 conor.dooley@microchip.com, bcm-kernel-feedback-list@broadcom.com,
 tglx@kernel.org, mlichvar@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 15:11:00 +0000
Message-ID: <179164506067.434549.2658464555254529067@kernel.org>
In-Reply-To: <20261009143506.2507607-6-jjc@jclark.com>
References: <20261009143506.2507607-6-jjc@jclark.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Two things in the timestamped-write path are only known to
  hold on BCM2711, but the patch applies them to every UniMAC/GENET/ASP…
- [Low] The driver now uses two different reference rates for the same
  BCM2711 MDIO block.

--

net: mdio: bcm-unimac: implement timestamped MDIO writes

This adds a write_sts implementation to the UniMAC MDIO driver. It takes
system timestamps around the MDIO command start and shifts them by 63.5
to 64.5 MDC periods, computed from the reference rate and the MDC
divider. When no clock is present on BCM2711 GENET, it uses a hardcoded
200 MHz reference rate.

> diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
> index 31e396cc9fbf2..e1ae806d1a84e 100644
> --- a/drivers/net/mdio/mdio-bcm-unimac.c
> +++ b/drivers/net/mdio/mdio-bcm-unimac.c

[ ... ]

> @@ -127,10 +150,41 @@ static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
>  	return ret;
>  }
>  
> -static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
> -			     int reg, u16 val)
> +static int unimac_mdio_sts_delays(struct unimac_mdio_priv *priv,
> +				  u64 *pre_ns, u64 *post_ns)
> +{

[ ... ]

> +	config = unimac_mdio_readl(priv, MDIO_CFG);
> +	if (config & MDIO_SUPP_PREAMBLE)
> +		return -EIO;
> +	divisor = 2 * (((config >> MDIO_CLK_DIV_SHIFT) & MDIO_CLK_DIV_MASK) + 1);
> +	/* On BCM2711 the MDC divider runs freely, so the MDC edge that
> +	 * clocks the last bit of a write comes 63.5 to 64.5 periods after
> +	 * the command start.
> +	 */
> +	*pre_ns = div64_ul(127ULL * divisor * NSEC_PER_SEC,
> +			   2 * priv->mdio_ref_rate);
> +	*post_ns = div64_ul(129ULL * divisor * NSEC_PER_SEC +
> +			    2 * priv->mdio_ref_rate - 1,
> +			    2 * priv->mdio_ref_rate);

[Severity: Medium]
The comment says the 63.5 to 64.5 period model comes from BCM2711. Does
it also hold on other UniMAC, GENET and ASP MDIO controllers?

unimac_mdio_init_sts() turns on write_sts for any controller where
clk_get_rate() is non-zero and MDIO_SUPP_PREAMBLE is clear. The
bcm2711-genet-v5 compatible check only supplies a missing rate. It
doesn't limit the model to BCM2711:

	priv->mdio_ref_rate = clk_get_rate(priv->clk);
	...
	if (!priv->mdio_ref_rate)
		return false;
	...
	return !(config & MDIO_SUPP_PREAMBLE);

Two setups that the bindings allow reach this path:

- A standalone UniMAC or ASP MDIO node with a clocks property.
  unimac_mdio_probe() picks it up with devm_clk_get_optional(), and
  brcm,unimac-mdio.yaml allows clocks.

- A GENET node with the "enet" main clock, which bcmgenet_mii_register()
  passes as ppd.clk.

In the GENET case, is the main clock really the MDC divider's reference?
A wrong rate moves both bounds by about 64 times the period error. For
example, 250 MHz instead of 200 MHz at divider 9 shifts them by about
1.6 us, while the window is only about one MDC period wide.

On those parts the start-to-edge latency or the reference rate could
differ. The [pre, post] interval would then miss the real edge without
any warning.

Would that break the mii_bus.write_sts contract in include/linux/phy.h?
It says "Set only if timestamps can always be provided". It would also
make PTP_SYS_OFFSET_EXTENDED report wrong PHC offsets with no error.

No in-tree DT gives GENET or UniMAC a clock today, so in-tree only
BCM2711 enables this. Could write_sts be limited to BCM2711 until other
variants have been measured?

Also, the note below the --- line says the model is assumed for every
UniMAC, but that note is dropped when the patch is applied.

> +
> +	return 0;
> +}

[ ... ]

> @@ -234,6 +307,30 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
>  	return ret;
>  }
>  
> +static bool unimac_mdio_init_sts(struct unimac_mdio_priv *priv,
> +				 struct device *dev)
> +{
> +	u32 config;
> +
> +	/* The reference rate is fixed, so read it once. */
> +	priv->mdio_ref_rate = clk_get_rate(priv->clk);
> +	/* BCM2711's 200 MHz GENET reference clock is not described in DT. */
> +	if (!priv->mdio_ref_rate && dev->parent &&
> +	    of_device_is_compatible(dev->parent->of_node,
> +				    "brcm,bcm2711-genet-v5"))
> +		priv->mdio_ref_rate = 200000000;

[Severity: Low]
This sets a 200 MHz reference rate for BCM2711. But
unimac_mdio_clk_set() runs straight after this in unimac_mdio_probe(),
and again from unimac_mdio_resume(). It still assumes 250 MHz for the
same hardware:

	rate = clk_get_rate(priv->clk);
	if (!rate)
		rate = 250000000;

	div = (rate / (2 * priv->clk_freq)) - 1;

bcm2711-rpi-400.dts sets clock-frequency = <1950000> on &genet_mdio. So
clk_set programs div = 250000000 / 3900000 - 1 = 63.

If 200 MHz is right, MDC then runs at 200 MHz / 128, about 1.56 MHz,
instead of the 1.95 MHz that was requested. The correct divider would be
50.

The timestamps stay consistent, because unimac_mdio_sts_delays() reads
the divider back from MDIO_CFG. The MDC mis-programming also existed
before this patch.

Still, the file now has two different reference rates for the same
block. Should unimac_mdio_clk_set() use priv->mdio_ref_rate when it is
set?

> +
> +	if (!priv->mdio_ref_rate)
> +		return false;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009143506.2507607-1-jjc%40jclark.com
