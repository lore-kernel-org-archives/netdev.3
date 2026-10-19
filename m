Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05C4CCDF8;
	Mon, 19 Oct 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404528; cv=none; b=KOuvw3wLvoiWydZCji0SZZXMa3K8VZhpk2yaB08C4MQgOvTKV3Wgs2MZagvb6Xc3Cic8/B4jzhdCB3J3+i8Y/LK66pnDG4MC+vdIi//oPaw93jCAFMWSIlVTjaaUD4M1Wa6L3BoqRvT4L7mrxvOMItm6knH+5/L+4600HXOY+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404528; c=relaxed/simple;
	bh=SW0h6/v8gnLyxdLNbv7/5TTRo3f5lXIJf6a1NdZtxIE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BXcjMKo/tGwdZSh98PA6tz6kphgzbp0WDk2skLn73J7GRGyqElpGhN5L3FIe1jiCi06ELR3Yp0c06oKij0Mz39JXOLqLv16tZHQomvlVKmE1oOTBjo0lwDIMt9sGM5ErembLialQTXChTqwkfAJXifNZl1YtkQZgJ1zrDGbU/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvX70ETl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvX70ETl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171F51F000C5;
	Mon, 19 Oct 2026 10:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792404527;
	bh=6Tyq2SzMp8vw0ux3JuZ51PYAfuwH2zXt7vQEJwLWoK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CvX70ETlZzej2/Whp6C3ZFUXWiPi4JJVEClbS458jgO3+YoMakPRClMnQCLRK5KTS
	 R1aAox9QPBUJNenhSmaSX1yt11dZiKquPMsje2aJr27nEjyhx201h/rc/MmHX0QRPz
	 yTvGHB0ARN7YkcQXABRlZd0ccfXKI/MAZZXTg0BjFUMRLsQq3Nbe3SWX39tCc8oicu
	 sPdUiADbDPbZfHFzbjEunFYE1MnfJHlVEuuZP+Ca+BU8Gcbb3Vb+78L1i7QgQj6z0m
	 McQj/igWsnFy+UvMVfBByiPCFDT4hiNO9LJV4O2sH6Q3vshR6W39wADmZNGX6U4GJl
	 GCKPvH4EVIQ4w==
Subject: Re: [PATCH net-next v15 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, edumazet@kernel.org,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Mon, 19 Oct 2026 10:08:45 +0000
Message-ID: <179240452564.3135.4025477777348146503@kernel.org>
In-Reply-To:
 <20261015-dsa_lan9645x_switch_driver_base-v15-4-562f316f78b9@microchip.com>
References:
 <20261015-dsa_lan9645x_switch_driver_base-v15-4-562f316f78b9@microchip.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Nothing in the tree can bind or exercise this driver.

--

net: dsa: lan9645x: add basic dsa driver for LAN9645X

This adds a basic DSA driver for the Microchip LAN9645x switch. It covers
switch initialization, NPI, CPU and front port setup, and phylink MAC
configuration for the internal CuPHYs and the RGMII ports. All register
access goes through named regmaps requested from a parent device, which
is meant to be an MFD driver submitted in a later series.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> new file mode 100644
> index 0000000000000..c7de3836e6967
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -0,0 +1,456 @@

[ ... ]

> +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> +{
> +	u32 val = 0;
> +	int err;
> +
> +	/* The parent must reset the whole chip before instantiating its
> +	 * children, so the switch core is disabled when we get here. The
> +	 * sequence below must not run more than once: initializing the
> +	 * memories on a running core corrupts pointers inside the queue
> +	 * system, which eventually fills up and stops passing traffic. If the
> +	 * core is already enabled the chip was not reset, so skip it.
> +	 */
> +	if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
> +		return 0;

[ ... ]

> +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
> +{
> +	const char *resource_name;
> +	struct regmap *tgt_map;
> +
> +	for (int i = 0; i < NUM_TARGETS; i++) {
> +		resource_name = lan9645x_resource_names[i];
> +		if (!resource_name)
> +			continue;
> +
> +		tgt_map = dev_get_regmap(lan9645x->dev->parent, resource_name);
> +		if (IS_ERR_OR_NULL(tgt_map)) {
> +			dev_err(lan9645x->dev, "Failed to get regmap=%s\n",
> +				resource_name);
> +			return -ENODEV;
> +		}

[Severity: Medium]
Does anything in the tree provide these regmaps?

lan9645x_probe()->lan9645x_request_target_regmaps() asks the parent for 17
named regmaps: gcb, qs, chip_top, rew, sys, hsio, dev0..dev8, qsys and ana.

A search of drivers/mfd/ for lan9645x or lan96455s finds nothing. That is
still true at the end of the series, through "net: dsa: lan9645x: add port
statistics".

The new microchip,lan96455s-switch binding requires reg and reg-names, but
the driver never reads them. A DT node that follows the binding would
therefore always fail probe with "Failed to get regmap=gcb".

dev_get_regmap() returns NULL, not -EPROBE_DEFER, so the probe is not
retried if a parent appears later.

lan9645x_reset_switch() above relies on the same missing parent. When
CORE_ENA is already set, it skips the RAM init without logging anything.
That precondition also can't be checked without the parent driver.

The commit message says:

    The MFD driver will come in a later series, because there are
    requirements on the number of child devices before a driver qualifies as
    a MFD device.

Until that series lands, the driver can't be bound or tested on any in-tree
configuration. Could this be merged together with the parent driver, or is
there another way to bind it in the meantime?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip.com
